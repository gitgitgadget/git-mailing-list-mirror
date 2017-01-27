Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD4A1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 20:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdA0UjL (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:39:11 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35110 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdA0UjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:39:04 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so159171340ith.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=175zp0pM0fhFgH/+fBeZe5+MK56iM6gGhigB6d8Ee0o=;
        b=YR6U3TfQmkAUw4Q9BJ0c1lvO4V/kv3uo7nXshWl0o27uUART45jiymUUZF/0FexUkX
         jSENpiWqiSVRRhMlwXkeXn3CLogkpOYfXY4v3it7s75rvbrnrTP2uHMQ1cTDpG+56Tqx
         Z8HPfzWT6a+DOuapFBAJt1cE1ncdERgTMZSfGpWi/BJVzG85gywvp3wjZ1A31SeCdT2u
         gvrLnYPJVqiIk6ki8K6Mpe08LDDm7cIOKRhpVsh7zIiya0S2EzovlxvfJBZBcilXL7Rs
         mlsJJb3wqgTO7oOeWHizrzqjLwZYFBsIx0FVxTw0QE0tKzRTxEX5rR4MDyLgJ6efmOT5
         EDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=175zp0pM0fhFgH/+fBeZe5+MK56iM6gGhigB6d8Ee0o=;
        b=uVzSjiXJABYJpn3zSY6MGNyNI+owZIibeuSg/dcrlG7zxu94KsuaPtxUQP2RrlYCx6
         35cwx0bCCl0Ev1kNjtQZv0CqcQI3YkUR705RgtlAOZUUzuCe0AwS3aK5pz/qUDGut8FQ
         qqnjBrpNi/rcBOvJX0YdqrVC74RjLfyk+nE24PDYwlox14067lGAVY9z9amg02BdOYtz
         74/UAc3RbkKY8PhpGNV333DkRYyCISYIkrywoq+Jb+1yHVMewVOusq4V3/zgyKgwQA+5
         63br8OsSoaC7cAcNclKTlvoJUtZXO5udneYft2mJXrxWJ9QfGYdjiKUjM+JHdPmBF03p
         7E0w==
X-Gm-Message-State: AIkVDXLHx1Qmb3/zCnI/Nn5kNwY/LbJ/M573OjmGZ5XuQDPZN3OxHPmZKCUkWmCvR5Xfc15rjqxICBokYLt7FBJ2
X-Received: by 10.36.65.4 with SMTP id x4mr4845944ita.69.1485549091244; Fri,
 27 Jan 2017 12:31:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 27 Jan 2017 12:31:30 -0800 (PST)
In-Reply-To: <20170127200136.29949-1-cornelius.weig@tngtech.com>
References: <20170127200136.29949-1-cornelius.weig@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jan 2017 12:31:30 -0800
Message-ID: <CAGZ79kb29usw4WyMdy3c5-rGH1nEcQ1gUabzdAtGgOW9zfTCDA@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 12:01 PM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> The documentation for submission discourages pgp-signing, but demands
> a proper sign-off by contributors. However, when skimming the headings,
> the wording of the section for sign-off could mistakenly be understood
> as concerning pgp-signing. Thus, new contributors could oversee the
> necessary sign-off.
>
> This commit improves the wording such that the section about sign-off
> cannot be misunderstood as pgp-signing. In addition, the paragraph about
> pgp-signing is changed such that it avoids the impression that
> pgp-signing could be relevant at later stages of the submission.
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     This patch summarizes the suggested changes.
>
>     As I don't know what is appropriate, I took the liberty to add everybody's
>     sign-off who was involved in the discussion in alphabetic order.

Heh, my first though was to conclude you haven't read the
sign off part, yet apart from the changed header.
/me goes back and actually reads the DCO again.
And actually these sign offs were there in other patches in this area,
so you'd claim (a) that yours was just created partly by you and having
other patches that were also signed off (b), whose sign offs you
merely copy over to here.

And then after reading I realized I slightly confused the signing
myself as the sign offs are also used to track the flow of a patch.
These sign offs suggest that you made the patch initially, then
passed it to Junio, then to Philip and then to me.
And Junio will sign it again when applying the patch.

So maybe s/signed-off-by/helped-by/?

The patch with the aggregation looks good to me.

Thanks,
Stefan

>
>  Documentation/SubmittingPatches | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 08352de..3faf7eb 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -216,12 +216,11 @@ that it will be postponed.
>  Exception:  If your mailer is mangling patches then someone may ask
>  you to re-send them using MIME, that is OK.
>
> -Do not PGP sign your patch, at least for now.  Most likely, your
> -maintainer or other people on the list would not have your PGP
> -key and would not bother obtaining it anyway.  Your patch is not
> -judged by who you are; a good patch from an unknown origin has a
> -far better chance of being accepted than a patch from a known,
> -respected origin that is done poorly or does incorrect things.
> +Do not PGP sign your patch. Most likely, your maintainer or other people on the
> +list would not have your PGP key and would not bother obtaining it anyway.
> +Your patch is not judged by who you are; a good patch from an unknown origin
> +has a far better chance of being accepted than a patch from a known, respected
> +origin that is done poorly or does incorrect things.
>
>  If you really really really really want to do a PGP signed
>  patch, format it as "multipart/signed", not a text/plain message
> @@ -246,7 +245,7 @@ patch.
>       *2* The mailing list: git@vger.kernel.org
>
>
> -(5) Sign your work
> +(5) Certify your work by adding your "Signed-off-by: " line
>
>  To improve tracking of who did what, we've borrowed the
>  "sign-off" procedure from the Linux kernel project on patches
> --
> 2.10.2
>
