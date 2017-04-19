Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30401FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 12:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763015AbdDSMbY (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 08:31:24 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34269 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762679AbdDSMbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 08:31:22 -0400
Received: by mail-lf0-f50.google.com with SMTP id t144so11549143lff.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tamEots1nPqXuGe0aZ0pK6PNufkniZ0wNVHiTbD4R94=;
        b=gsAWV81jaqHtxPjme9QKvmtV18HYTUOJZetmZncoqFWSQxsI0JR/8sjjuPgVyHmi7t
         ROM449EZWlsg2mIrDarIxvTIIltS6UuxK+DrHpX/F9NdDk8L+HDnmMILPgQkInzDLXDJ
         +jg1j9GXcU7OUcW/MrhOX8PBGKH1gFIN6pnv5f2HEpSRixCsftod+ZDyaaSJMV71XFIK
         YrxH1tg++556lOpwyTB5dP9x8EmuPbWtJHi9jHVgHy7bUAmjw+mFYr72kvf+aMdcOAkW
         oZmnmAgFrWHyeAjLfT96BcMx4juIxNER1AAb+xZqR80J2efb8oRThZ5H51CKwyWo8Ktk
         XPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tamEots1nPqXuGe0aZ0pK6PNufkniZ0wNVHiTbD4R94=;
        b=d2NmRBCvymjxP3h4MNQV3rWq5j3pdOiI2ikvckLcFavp+L9jXAd7wl82hxKF66BoTY
         NUAXnCBsM9KuFqqJUVNehiFehQRFvj72Mmg9DmBvjXptHDZuiuraNNDX9/f4sBhxFCio
         LKks7q0mWVWLebts+sHto+MsvO8t0mMp4lnOH1xQu/qHESMBrpnAT4CDk9cseqPSDjqu
         LabyBrjcTDccYLU1cqofzIDCOgswYG/STfk3OWm0MPoDj6gqonqnzgzsq3FuMOELwb/A
         v68NFIPKhag3mmAJF/SJpIX2+qWDm2tEcmWH8NGrfbHPG6KL1FGYgOFqKrnWolImKrBS
         ojHA==
X-Gm-Message-State: AN3rC/7XLzAPJtHiKOKmowESOshtgyvl7JmUKgXwdFDab5MvA2WdMGG9
        9y8GJuNEd8OOG9tzxsef20YdQnBHMQ==
X-Received: by 10.46.1.106 with SMTP id 103mr842543ljb.97.1492605080368; Wed,
 19 Apr 2017 05:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Wed, 19 Apr 2017 05:31:19 -0700 (PDT)
In-Reply-To: <40c969f2-636e-f977-e385-d490f37f0ffa@grubix.eu>
References: <CAP8UFD3G_m1q6tORDRpfqWXQwrtpx-xQTqxfj0K=xU5WdEC+uw@mail.gmail.com>
 <40c969f2-636e-f977-e385-d490f37f0ffa@grubix.eu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Apr 2017 14:31:19 +0200
Message-ID: <CAP8UFD0MbRMwM-0AWc8_DgqE_67MC5J5qSfOdqj13TyRXcvRFA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 26
To:     Michael J Gruber <git@grubix.eu>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Werner Koch <wk@gnupg.org>,
        Peter Lebbing <peter@digitalbrains.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        demerphq <demerphq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

> Hi Christian,
>
> Thanks for the ping on the draft.

Thanks for you input on this!

> Re gpg: Maybe some valuable point of information is what Werner Koch
> himself said in that thread:
> "That [the command line is not a stable API to GnuPG] is not true.  The
> command line interface has been stable for the
> last 19 years.  We only removed a left over PGP-2 backward compatibility
> in 2.1 (-kvv).  I doubt that this has even been noticed."

Yeah, I could add the above, but there is already the following in the
article (which is already quite long):

------------------
Bernhard then replied to each of the points Linus had raised. About
"library versioning" his reply was:

> In my experience Werner (the lead GnuPG developers) is quite reasonable about
> keeping APIs stable (he often goes out of his way to keep even the command
> line version stable, maybe he shouldn't do that to the command line options
> so you are more motivated to go to this official API gpgme. >:) )
------------------

So I think Bernhard already knew and had already written that the
command line API is basically stable thanks to Werner's efforts.

> I think our conclusion was that on Git's side, there is no problem to
> solve (except, maybe, to use gpg2 by default when gpg is not installed)
> because the main problem is mixed installations of gpg1 and gpg2.1+, and
> we don't want to use a library instead of the command line API for the
> reasons mentioned by Linus and others.

I agree that one conclusion is that maybe we should use gpg2 by
default when gpg is not installed or when both gpg and gpg2 are
installed.
But I think another important conclusion on the Git side is Peff's
email, which basically says that gpg.program cannot be removed and
"gpg.program = gpgme" could be added.
But I prefer not to state these conclusions explicitly in the article
as people might disagree :-)
