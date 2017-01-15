Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BFFF20A17
	for <e@80x24.org>; Sun, 15 Jan 2017 06:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750775AbdAOGYY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 01:24:24 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32998 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdAOGYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 01:24:23 -0500
Received: by mail-lf0-f52.google.com with SMTP id k86so62712004lfi.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 22:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EtyMh8epwdm6JbotF4yl0dSKSpC5IK+yTWzjSM4HNfE=;
        b=BP3Rfmm7kNCm3z9mgcfUdZD5wlsfeC0HOk6fcd1uewzFBwHlzYbmU4guX9GZIW5LQu
         O+LvEKtdfsq9IxY8xFhLWidCMRv1+FQ2zAmhzin5pCU50Mi6+AwwHa+Z3fgq0+aXdL70
         oLDFyKURL4aT7Ve8RyisBGiXAhiJvFnpHuzOJ/wSOi8OPNLcAhWaA0txp3yn0pgYsIQi
         RIbnBDVAyJViRLCz6NH3WUiSpEefKmAghFJvfwtFmq8N3mnDwH/3JsihEBhKZHFh104k
         Se1BaXTU6jd0OTr7RJawRsbHrv7mDFfyYrYORkmPKhfn6vaeZprbhHQYDza+iITH/IGj
         AmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EtyMh8epwdm6JbotF4yl0dSKSpC5IK+yTWzjSM4HNfE=;
        b=qkqVw5mOwMzrIqEKhbHDR76K0o0ek7kCaM7AkUSmQq56urUNbTOZlsjyDjupdA892C
         tliZZUhB8OzaoP+qqnSwMv9OrlCjicG2MCp4r+Lyf/E6vMS6bQOSQo1FS6UtdNzjQPZ3
         qwdNks46t0GDkeLLc0W73R89AptWKF+DXBH7H5dwHeIGNZi3c+uxu+RU6/U1QgIkby+M
         7w+YdZAaLdfHM8ArDCZRjk24Wx6yrwL30LC4xxsHnhV+FSGa3LlZsIiT4cUHKt4s6DTx
         XHC5iN68CYE9b4sKLtLzFWgd7ehyS5AA7uPzL6OauBSVdDXRlEl2aWl/5knBkFHaiZmC
         XVhQ==
X-Gm-Message-State: AIkVDXKV71I5eIUXfiKzl2FZegqrwXViT4VhC35dEnn/8vMggFn/S9YzqpRPJSe2Gv2212YOJyXiM6Jbjt3umw==
X-Received: by 10.46.14.9 with SMTP id 9mr9940655ljo.59.1484461461707; Sat, 14
 Jan 2017 22:24:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sat, 14 Jan 2017 22:24:00 -0800 (PST)
In-Reply-To: <58798686.5050401@comcast.net>
References: <58798686.5050401@comcast.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 14 Jan 2017 22:24:00 -0800
Message-ID: <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
Subject: Re: merge maintaining history
To:     "David J. Bakeman" <nakuru@comcast.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 6:01 PM, David J. Bakeman <nakuru@comcast.net> wrote:
> History
>
> git cloned a remote repository and made many changes pushing them all to
> said repository over many months.
>
> The powers that be then required me to move project to new repository
> server did so by pushing local version to new remote saving all history!
>
> Now have to merge back to original repository(which has undergone many
> changes since I split off) but how do I do that without loosing the
> history of all the commits since the original move?  Note I need to push
> changes to files that are already in existence.  I found on the web a
> bunch of ways to insert a whole new directory structure into an existing
> repository but as I said I need to do it on top of existing files.  Of
> course I can copy all the files from my local working repository to the
> cloned remote repository and commit any changes but I loose all the
> history that way.
>
> Thanks.

If I understand it.. you have two remotes now:

The "origin" remote, which was the original remote you started with.

You have now a "new" remote which you created and pushed to.

So you want to merge the "new" history into the original tree now, so
you checkout the original tree, then "git merge <new-remote>/<branch>"
and then fix up any conflicts, and then git commit to create a merge
commit that has the new history. Then you could push that to both
trees.

I would want a bit more information about your setup before providing
actual commands.

Thanks,
Jake
