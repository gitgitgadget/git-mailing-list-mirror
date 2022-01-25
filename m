Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC9C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587297AbiAYRQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbiAYRNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE1C06175E
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 09:12:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so64422668edj.7
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3ulb9rghKF+6CDWv56W41VBTR1Pdb5jJur02vn23Jek=;
        b=q5wSo/QqYOXSu+OA2j6faw9To/TnU5l+763pYwFQ3d3Ongba6Nz8l5LEvNLz1H/1xB
         VZi8WgK+5FTpDmrVP/Srj5M2j2wyKg3fIDJsJa9ipD9AdJstGnMr7v2pebGZOa9h5Kxk
         0BzlwwK2RJc+80yQijh5pnr6sEM1/qZyF0pEyXiThD5czXdwKAaxEnL/yKwhPPxPQH0m
         fxHZXBo9xOKtrSEpgan3JTa8MGOcy2qrjLlynxv5Z9c4Hfb56aIyMqu3M4nuurwzt0vV
         iiQw3HBAkodDBIP6cF34CEKDahflHKsU9Q45PyAYk4A8+8EBy9UVlFP6W907FMKRvRUB
         TyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3ulb9rghKF+6CDWv56W41VBTR1Pdb5jJur02vn23Jek=;
        b=z1xjG8RzO2Tm2a7aiJggbdcZmsDHv06p/J/Hki1iTqE9QzXqWkzud4s8mPIGX+1Awn
         pT616Ht5aa7Rgrg6X+rWT+56iPTSnpBBAXTtkdcJd4DoZWOMTBZzmSYJXfrZyxCAIGJ9
         F4xPM+eIKImwyqUlhJpogmFeDuq+r/kaRKwmHBr+ZCh399ZmbqJ3tLBI7dzYrrROyWn2
         FRLhMjXCzHFq07BMHYL8CTFK5HCdXG4KDIj9Lu1OwsF2ELVAAGa0XMY4856PDZNgk5eQ
         4OgKHobkOEKtlKqduSdif7WrzedZQbXL7gvGEI6YihRFeYYnYNFPKMaYHrVKsqeb0C6x
         k4eQ==
X-Gm-Message-State: AOAM5338ScRMZZ3YrL94OlI5dAPUyvemwvjGr1AOCihsdhKgFL2Py7V7
        zBn3yLH5dN7pLhoYjizgRIQFl1/k4vXpHg==
X-Google-Smtp-Source: ABdhPJw+JOTg1Trc3OSshIG7zznBysx8GRRbUBF6JHErq5wB5upaBwfBw5vK3zho8MNdEtktsYhP5A==
X-Received: by 2002:a05:6402:1bcc:: with SMTP id ch12mr21732315edb.227.1643130742145;
        Tue, 25 Jan 2022 09:12:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j15sm6386687ejx.199.2022.01.25.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCPMi-002v0j-Gy;
        Tue, 25 Jan 2022 18:12:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] docs: Fix bad whitespace in
 Documentation/config/pgp.txt
Date:   Tue, 25 Jan 2022 18:09:57 +0100
References: <20220125123716.66991-1-greg@hurrell.net>
 <20220125123716.66991-2-greg@hurrell.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220125123716.66991-2-greg@hurrell.net>
Message-ID: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Greg Hurrell wrote:

nit @ subject: I'd suggest:

	Documentation/config/pgp.txt: replace stray <TAB> character with <SPC>

Or something, i.e. the "docs" can just be replaced by the filename, so
we don't need to put it at the end.

As general style, we tend to not have the <msg> part of "<subsystem>:
<msg>" start with a capital letter, i.e. "fix" not "Fix".

> Signed-off-by: Greg Hurrell <greg@hurrell.net>
> ---
>  Documentation/config/gpg.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index 0cb189a077..abfabd6d62 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -37,7 +37,7 @@ gpg.minTrustLevel::
>  gpg.ssh.defaultKeyCommand::
>  	This command that will be run when user.signingkey is not set and a ssh
>  	signature is requested. On successful exit a valid ssh public key is
> -	expected in the	first line of its output. To automatically use the first
> +	expected in the first line of its output. To automatically use the first

Since I had to look it's a s/\t/ / of a tab between "the" and "first" in
the pre-image>
