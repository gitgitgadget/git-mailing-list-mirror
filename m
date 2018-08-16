Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3291F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeHPVOM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:14:12 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:43387 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeHPVOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:14:12 -0400
Received: by mail-qk0-f181.google.com with SMTP id z74-v6so4436436qkb.10
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=80CvYPqCV9vsPWOfQPNnPp+mOikRRIt2ShGjxkJMhmI=;
        b=KlW9BNx7Zze0BC5inrKTaZFa26bim5RHzbL5HFuDgn818kImIf0Ihtfx0IXRT6VzHj
         lrx91MrvHNUsaXos6VIh1whe6/fY8LbOGo9JaaI1WilMgkL0IEeWwCvyhm40k5bEZfM7
         oHTtFy9TxHwh5NIev2Lqo3QvVKSkHm2DwBZ8cQ157cE7+mO94PlC4i9ioMN3aKi6BaOS
         NtW8P/emKOKPP+0geoMsdVB64AwXTTg5gRVAXoQU9JVCgNIkCz8b/AvZSNmyxLurhkr/
         LTkCaH3ELHRvKeBVt88cCP6dsiyjfEoHz8xpPh6zTtxuh+CDp21LayAXkswx3/zrXMm/
         05UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=80CvYPqCV9vsPWOfQPNnPp+mOikRRIt2ShGjxkJMhmI=;
        b=M+lwEDSmXjn/NbU6LyTgmkr/0BVkl5zDwnD1qhlbMGUEbCLqBzz8Uv+gBRbQn+Mb1c
         YYnTmSxJl+ltrVv+0vzzal9qpBlTbgvXak+2QN37FJz17XT+9uNvQ19Bgs41P/6RbEL5
         Qx6Ou0cvk/5346amt3twI76HicgxfXi3qQU+OY2UXoAyRWmWZ95TuZ1nofO5tJPK4zLz
         GXplM8gFbFJi3CeDzXjLlhWA3l9ExigYJzJZy4TdJFkeEZG1zmEyvIn9GrMtMv0N5Hxb
         F8Aeth1jcqMLdeWa8XB6Nh8p8rkk/W9BgEmQYNxq2l0URLj6xZliECh/6yaslWgLOBAO
         43yA==
X-Gm-Message-State: AOUpUlG2STE1YQoht8xVj7fQAh3EPFP/cDo/ICItf6NabCgaH9CN04et
        r6AKKp/R9FBUd55Xy0i9RgbPZLO+dQ+yzmos9iN6oZxU
X-Google-Smtp-Source: AA+uWPyJ5qh0Cg2Ub5cmczAdlSLAFDksNotYBeVV6SZUvi9HDp/oTZ8GiVP+5oGuVwi+ou0wWy+nXULgWhWw/VgZfws=
X-Received: by 2002:a37:9c06:: with SMTP id f6-v6mr28680006qke.312.1534443252063;
 Thu, 16 Aug 2018 11:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:53c2:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 11:13:51
 -0700 (PDT)
In-Reply-To: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
References: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 16 Aug 2018 20:13:51 +0200
Message-ID: <CACBZZX5QXiAMfP8=bBps26JqSOHYSaK722GcnRjfDX-OcKQ=cw@mail.gmail.com>
Subject: Re: submodules : switching to an older commit/Tag in project with submodules
To:     Shani Fridman <Shani.Fridman@visionmap.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 12:54 PM, Shani Fridman
<Shani.Fridman@visionmap.com> wrote:
>
> Hi everybody,
>
> I've got a question regarding submodules -
>
> I'm working on a git project with submodules connected to it, and pulling=
 changes from them every month (more or less).
> Sometimes I need to checkout older versions of the project (tags or speci=
fic commits), that needs the older versions of the submodules as they were =
when I defined the tag. The problem is, that the checkout only changes the =
superProject directories, and not the submodules... I have to checkout the =
relevant submodules commit manually.
>
> Have you came across the same problem? Any idea what can I do?

You run "git submodule update".
