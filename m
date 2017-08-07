Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777682047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdHGSoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:44:10 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34225 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdHGSoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:44:09 -0400
Received: by mail-lf0-f43.google.com with SMTP id g25so5600794lfh.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JxpyOp0pc0Kbcm9vL/OD36o21jYhfUcvzlgG7TZGINQ=;
        b=N7HaPjoarS7MClgJHtR8QjX9zt3ZakRDV042mY00rFvtofGXXB4uHphw6M69R7ZjQG
         vQcJlsKaE0NwIZAE2+I1zxaZrBm3Y+3FEHYuiof4HHd7PU8y7oXygAFL6X7imB+qxvxl
         81KTEk/lFTQRWbQey/ybMu6tH7ifM/VSND5awK0nT/n2G1GLKijg7f9cLyfFk21RNhO4
         T8YLigxtAdxCrfh62/YvNvrKwhXG5YaLx/OuHKr9RoqtuLfYR9sU0ILRktlK5er5WRbr
         i0dpDwz2CpJjnqEyYqom6ty2M7FTyNJmNuAWB3Ts0Kdw/lgb8DW3pVomhGKoNsIqn3B3
         Q+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JxpyOp0pc0Kbcm9vL/OD36o21jYhfUcvzlgG7TZGINQ=;
        b=EClU/NshjibZQXwHVW7+JjgQcQObVERXpVbCEbXesNQ1YPZHOXfPc3NsXSeFPa3Djp
         k3Tv0ORdkc94MG1olP1d59Pi0nPg4DCDzREsKRE12G1nexwaRfUS0aZkXrQhO8VJU2H/
         cwL/3R0FxUjoH4jD/4qgzo0S8bnhnPoeqZ48rYh+q/OLBSd8M0xaADGNR9FLDwyp6Dm4
         V/hSUgT4pR6mKYXKdyOkUasV3A/i9kT2/O6sxxaaVQYPOm81yQzyVd8c6lmohlXOk0tV
         lqmgXfGHuGck+I0pxEwVomhpT0HnqYyfsS5/AbFTtL2rTfHNEAO3cflyRELuxkTVcM/F
         vgGA==
X-Gm-Message-State: AHYfb5gseARz5wunoyngjnb/WBtYPW/c07f76c+5tab/4SXlEMVq7zdB
        Dkl35uJZRkK4y2qiaXFAcdGmJdntT015
X-Received: by 10.46.5.80 with SMTP id 77mr497690ljf.91.1502131447647; Mon, 07
 Aug 2017 11:44:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 7 Aug 2017 11:44:06 -0700 (PDT)
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Aug 2017 11:44:06 -0700
Message-ID: <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] clean up parsing of maybe_bool
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2017 at 11:20 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> When we want to parse a boolean config item without dying on error, we
> call git_config_maybe_bool() which takes two arguments: the value to be
> parsed (obviously) and a `name` which is completely ignored. Junio has
> suggested to drop `name` and rename the function [1]. That effort even
> started shortly after that, by introducing git_parse_maybe_bool(). The
> new function currently only has a single user outside config.c.
>
> Patch 5 of this series deprecates the old function and updates all
> callers to use git_parse_maybe_bool() instead. Patch 6 is a final
> cleanup: one of the converted callers suddenly had an unused argument.
>
> Patches 3 and 4 prepare for the switch. In particular, patch 4 ensures
> that the two functions are actually equivalent. In doing so, it affects
> `git push --signed=3D..` which was very slightly inconsistent to the rest
> of Git.
>
> Patch 2 adds a failing test in preparation for patch 4. Patch 1 corrects
> the documentation not to say "git push --sign=3D.." to make it a bit more
> obvious that the opposite typo is not being made in patches 2 and 4.
>
> git_parse_maybe_bool is used in sb/diff-color-move, which is in "next".
> This series makes --color-moved and diff.colormoved consistent with
> other booleans. That should be a good thing, but cc Stefan to be sure.

The series looks fine to me overall, though patch 5 is overly gentle IMHO.
We could have removed it right there as Junio is very good at resolving
conflicts or producing dirty merges for such a situation.
But delaying it until no other series' are in flight is fine with me, too.

Looking back at sb/diff-color-move and the code where
git_parse_maybe_bool is used, I do not think this will be an issue.

Thanks,
Stefan
