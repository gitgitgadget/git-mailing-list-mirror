Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EDA11F453
	for <e@80x24.org>; Wed, 19 Sep 2018 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeITA20 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:28:26 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42718 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732072AbeITA2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:28:25 -0400
Received: by mail-lj1-f176.google.com with SMTP id f1-v6so6000332ljc.9
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c1WrwGpslhHaYX9706UhokytqQnE307sdtQBMacRHrc=;
        b=JU5GAOHWxnPUhv22EcDSLlW7HPjEOjA/zSX9k1dM61QDPQpVNHQo6cbTQwWdJoYxaV
         /EC8vv5K9HZ74I6lDMTyO2RVEW9L0y2P+CGrwuYxbH9Yt2P+9VGFM3eSSsZ1jZnqsrA0
         xbWCGIAgUTT7VHoxJhMXgHhXnqDERjIFqERbIq/vyWxEoNEzownhlI+8jGKXV94PYO1Y
         UYPcJ0uRxiaEgWACzbCS306Nx0+sm1oDLjYD4rWsdP5yjql6h/8GbaPopbJDsNbwuHRW
         rbFlK0OVlsAZSkXz0eev4kgH/zqyM6nNvKJqAtwl1+gOcytz3M2telVqeCgCQAOugJlk
         N01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c1WrwGpslhHaYX9706UhokytqQnE307sdtQBMacRHrc=;
        b=Pa0HOW6mN2lLwl6sZ4y4b5bLYvmDXbVSJvUzOl/x89o7ljHfuMJUKCE9MBJH3EHHRT
         b2NYNLqUUreiypHgZKZggYQ7BPC3Orh/yFqEHiv1O8405OP+KMkA5mbKQlgD+FtHdtYp
         4ujvxV81I5BVpGvzIW6FutMKU6HzVgc/Y3H78htGz/3kmIPceFA1VVd5Uq5z7nBYq4XQ
         L/0fqxPiKIrv3lAfycT4Rsh65BNKTncWBFTdmQOpOu7S6uPaI3H33ENWYJxJdvZ9srIE
         q3yMWE7meKuRSsjSggeLTIc8kNjdTt5E0qc1bmlrsotwMYs9yC4LkQYfBDVdPUGWIW6d
         QdlQ==
X-Gm-Message-State: APzg51CTdg+bLGUfjWWgP7VmAw8i2e9gqu/FEfSNgNAHllblROgLnxBH
        +x5jKEo1ralBeXaqnnmZXtot6h8oXnG2Ovegc6E/qjLc
X-Google-Smtp-Source: ANB0VdY6YZQqaoROBpXjwJyYostLel0lahxIkkQtjP/+4a1vm33CL8EV5KZU2IMBNYaS2pgkSLsxEhu8oU52++roxq0=
X-Received: by 2002:a2e:88d0:: with SMTP id a16-v6mr22111942ljk.63.1537382950262;
 Wed, 19 Sep 2018 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACrY0PAM=Ek5T_3oYkT0zMoAsULDfu9JAYm3xJdEqaxvxpQiwQ@mail.gmail.com>
 <20180919175045.GA10005@sigill.intra.peff.net>
In-Reply-To: <20180919175045.GA10005@sigill.intra.peff.net>
From:   Leonardo Bozzi <leonardobozzi@gmail.com>
Date:   Wed, 19 Sep 2018 15:48:58 -0300
Message-ID: <CACrY0PDzo8EayzV6Zg1jWALu-9m+txkp87un0SbMr3hVUynrOA@mail.gmail.com>
Subject: Re: Access Git ssh on port 8822 ?
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok
       git clone ssh://bozzi@bozzi.net:8822/opt/gitcurso

access sucess.



Adm. Leonardo Bozzi
Administrador / Analista de Sistemas
Tel.:  (27) 99988-4576
CRA-ES: 13256


Em qua, 19 de set de 2018 =C3=A0s 14:50, Jeff King <peff@peff.net> escreveu=
:
>
> On Wed, Sep 19, 2018 at 02:47:09PM -0300, Leonardo Bozzi wrote:
>
> > Good afternoon, I'm trying to set up a git server, but I want to use
> > ssh access to connect clients on my server, but because of a
> > limitation in my internet provider it blocks access from outside on
> > port 22, so I changed the same from ssh to 8822. But when I give the
> > command:
> >
> > $git remote add origin bozzi@bozzi.net:/opt/gitcurso
> >
> > The server blocks me because I would have to access via port 8822. How
> > do I make the connection correctly?
>
> You have two options:
>
>   1. You can use the more verbose ssh URL syntax, which allows a port
>      number:
>
>        git clone ssh://bozzi@bozzi.net:8822/opt/gitcurso
>
>   2. You can use a host block in your ~/.ssh/config to set the default
>      port for that host.
>
>        {
>          echo "Host bozzi.net"
>          echo "Port 8822"
>        } >>$HOME/.ssh/config
>
> -Peff
