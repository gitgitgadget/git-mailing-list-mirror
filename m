Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE48201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbdB1Uxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:53:33 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34825 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdB1Uvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:51:32 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so2916904pgz.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xUvxA/Rr2CmT88rl+2gWJwODTl7d3Flfi2W2Gc+FHsI=;
        b=p7IyfeD85LBX9jQG35BAF7ZTZwOOyI4/8Peq1GP+F7SBX1BWN06IjlQk/jzPHpY6d5
         lrpQrJHeUyoA6unUZ8b66kCktHGK/APTWiaR/6/mHC+i8ng9oA9ASv/+cxUaCvJLMVE+
         PiVnw9+8ft7fW/5uEh0RvmmR1C4Ye3LRPO4TVQVf0dTphWdW2EJUW8uWW8w8FVk4438B
         65BOAipeW2GSbWfh2unjIPE9JoAkgmXSEJtmkgefll5CTiGnZoR7JrD8wnJccs4fHBd9
         obrEPrnVG+4TmsH/Q50q9nJR09j0NHTck3+1+qpDv7ezWHrVMCKZ5T8A/dMf8zlemhS0
         zfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xUvxA/Rr2CmT88rl+2gWJwODTl7d3Flfi2W2Gc+FHsI=;
        b=NRvrYWrpTNkicrMiwzzYkzczzRFxSLALSdaQ8DqhryzTuvnlrMlxRDzcH2JHxZY0n9
         IBLsXOfILaSjsL+z+rGi28tYeWLwj1xamPBLqv1/hmobVG4v0zxCcRky/gV+xiRsyNBi
         GKHXAGhbs0bvHgP0konjs369t+rZ8jNXylSp99EKayjKBUvCloGm0Ap+AiHYwoO9fyNP
         XHdvKHMzgMfkc1ZHg1gjNla7y0JTt6ROJFaSkNDfMAPXXwP8WNpaSbZ1PwUKzMgeC5Mr
         Llki1JevUsBkBWyBBYxpDYe3VLDbXYBE7r7DaUVRpDE0CEjSyrj6kDw5Dhn6L/zu8Exx
         k+4g==
X-Gm-Message-State: AMke39mZIzB2rPAUAblxsFFrkdlg9oAmMsTsiaKdN+pqKJ1Kx7GLokDqxGydlYdmnkm1vw==
X-Received: by 10.98.157.12 with SMTP id i12mr4695772pfd.166.1488315073858;
        Tue, 28 Feb 2017 12:51:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id p66sm5920857pfb.88.2017.02.28.12.51.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 12:51:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Documentation: Link descriptions of -z to core.quotePath
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
        <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
        <1487968676-6126-3-git-send-email-asheiduk@gmail.com>
Date:   Tue, 28 Feb 2017 12:51:12 -0800
In-Reply-To: <1487968676-6126-3-git-send-email-asheiduk@gmail.com> (Andreas
        Heiduk's message of "Fri, 24 Feb 2017 21:37:56 +0100")
Message-ID: <xmqqmvd6jayn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index e6215c3..7c28e73 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -192,10 +192,9 @@ ifndef::git-log[]
>  	given, do not munge pathnames and use NULs as output field terminators.
>  endif::git-log[]
>  +
> -Without this option, each pathname output will have TAB, LF, double quotes,
> -and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
> -respectively, and the pathname will be enclosed in double quotes if
> -any of those replacements occurred.
> +Without this option, pathnames with "unusual" characters are munged as
> +explained for the configuration variable `core.quotePath` (see
> +linkgit:git-config[1]).

Seeing that many other instances call this "quoted", we may want to
be consistent.  I can see "munge" in the pre-context, but that one
can stay as is. Under -z, no modification/munging happens.  With -z,
a specific kind of modification (called "quote" described in the
documentation for core.quotepath variable) happens.  The same
comment applies to the change to Documentation/git-apply.txt

Otherwise the patch looks good.

Thanks.
