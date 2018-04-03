Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743441F404
	for <e@80x24.org>; Tue,  3 Apr 2018 20:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDCUE6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 16:04:58 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35210 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeDCUE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 16:04:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id r82so37837703wme.0
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fOH+iMIJUJppuJo6b5jK77Ig9mq0gfYk9ipeR0eKDdM=;
        b=DKAINdeXn+iL2BfgHYa1mgSfR07yuWot9TL7Lda+7yP5fTVJ2kTKId7uF/EB/jAc1M
         x2D9x68H7zPIonCBb50qxsQ8LAVyETwlN/DpvCFvrnaertS/WqrZey5pDDsRJIPxiBDo
         Y0du2edoFGDdWNLTtuNxbbQVfk5aCWduHDk4BTyPDaEMDnDLKIY2V8xGMh5VmSZNr5cW
         ibDejwOTy1zf56UcP7HxcpGJZRclqxagWVtjERfjxhLG1kaCUF1vKRricn3SFs1Qn4I7
         dHStTkHpEpUSuhKENWLQ/Dgomhl1trVpFzo4oAzmc+Wh8oHmxv4g1aw6EiXRmxda1TUS
         SXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fOH+iMIJUJppuJo6b5jK77Ig9mq0gfYk9ipeR0eKDdM=;
        b=Fv8hvn2Lt89bsVjTUDuMkdEiuA13J7vFHkGzFoj30jlHk0nWNjQx5y8GYaqe81U6As
         qoMMp0Rw7bZGTO6jfnJHCHa4LI9bpPJec5WabbBlFPT2zqL6yZZczue5zeIRzLPTOCXm
         Nx4GyXyjma6O+ZZLHJrDIE4ujbgm+PYMpHb3JjTWN/BVt3cu3SPuxYJstEmtLvgyiD+J
         RbZ9HFEdnLSof3CJIzj42al2UwIT0za5dBmBLxODVy4QRFNE4S+LYQv488WjVIuM26VC
         dQ6HUdSW5K1eDYOadHdU0qOwozxa1PZMuVbSdFaI3de1DuXyOvi2leOaoX4saIi+lsfI
         Y21g==
X-Gm-Message-State: ALQs6tC4WAsIL2ybyq8cepf0aWZzTFEoG6zV0y0SoQWasIKtzV/TWs7q
        wKtu6izZoETPGuLwjggS8HSnlZOXUjDlH5fkzwE=
X-Google-Smtp-Source: AIpwx48ZPobPaAbET6KXBAPAI/tc7roGQk/FHsMNbvg1dlMU30iZoThj+P63acglZqGa59Xwmp+9MZ+BWC8BYzO6gVI=
X-Received: by 10.80.203.71 with SMTP id h7mr3473333edi.118.1522785896310;
 Tue, 03 Apr 2018 13:04:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.201.196 with HTTP; Tue, 3 Apr 2018 13:04:35 -0700 (PDT)
In-Reply-To: <671541522781590@web3o.yandex.ru>
References: <671541522781590@web3o.yandex.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 3 Apr 2018 13:04:35 -0700
Message-ID: <CA+P7+xoaOt4KwTOQSfwiyB1CQ317kbCZ2u26RoPA02Z4WYr9EA@mail.gmail.com>
Subject: Re: Socket activation for GitWeb FastCGI with systemd?
To:     Alex Ivanov <gnidorah@ya.ru>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 11:53 AM, Alex Ivanov <gnidorah@ya.ru> wrote:
> Hi.
> I want to use systemd as fastcgi spawner for gitweb + nginx.
> The traffic is low and number of users is limited + traversal bots. For that reason I've decided to use following mimimal services
>
> gitweb.socket
> [Unit]
> Description=GitWeb Socket
>
> [Socket]
> ListenStream=/run/gitweb.sock
> Accept=false
>
> [Install]
> WantedBy=sockets.target
>
> gitweb.service
> [Unit]
> Description=GitWeb Service
>
> [Service]
> Type=simple
> ExecStart=/path/to/gitweb.cgi --fcgi
> StandardInput=socket
>
> However this scheme is not resistant to simple DDOS.
> E.g. traversal bots often kill the service by opening non existing path (e.g http://host/?p=repo;a=blob;f=nonexisting/path;hb=HEAD showing in browser 404 - Cannot find file) many times consecutively, which leads to
> Apr 03 21:32:10 host systemd[1]: gitweb.service: Start request repeated too quickly.
> Apr 03 21:32:10 host systemd[1]: gitweb.service: Failed with result 'start-limit-hit'.
> Apr 03 21:32:10 host systemd[1]: Failed to start GitWeb service.
> and 502 Bad Gateway in browser. I believe the reason is that gitweb.service dies on failure and if it happens too often, systemd declines to restart the service due to start limit hit.
> So my question is how to correct systemd services for GitWeb to be resistant to such issue? I prefer to use single process to process all clients.
> Thanks.

This sounds like a systemd specific question that might get a better
answer from the systemd mailing list.

That being said, I believe if in this case gitweb is dying due to the
path not existing? You might be able to configure systemd to
understand that the particular exit code for when the path doesn't
exist is a "valid" exit, and not a failure case..

I'm not entirely understanding your goal.. you want each request to
launch the gitweb process, and when it's done you want it to exit? But
if there are multiple connections at once you want it to stay alive
until it services them all? I think the best answer is configure
systemd to understand that the exit code for when the path is invalid
will be counted as a success.

Thanks,
Jake
