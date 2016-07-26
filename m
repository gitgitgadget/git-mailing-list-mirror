Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A204203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbcGZNJ7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:09:59 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38067 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcGZNJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:09:57 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so16095980wme.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 06:09:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HI2mDig3LBu6H5ydul+kiPfBHKTQirdXwP7H/tvWrII=;
        b=APp7DCSFDNp8vpaQzNmWmkntkN4g4bqod6+ap9PzS1aosYbCA3O/AdJn8ssfa92Kym
         9p+DSG7sKxZ4unoNLh8HY4rIrvWxOiMezbKTIpCYufh1/FfRdaGpkKwlsHzM951yACDS
         zNKpY7bslMAr2aKo1t34V9h9rnx75EAL/lN4WpUbBLgNnXagB0Ys0GvT/0YLIJ/6Fr8R
         SG33/TvO1+ezec6AsVmWCSYsu90It5dOcv4gNhlk9gNiS5zquNpucNqphNGdlNuM8skX
         v8hRo3lNJGUTmKPmF3w4+MVNBFKVDgQo1LQG7WaVIj52RauWNDtPr73FVOCFuyV6KL7g
         VxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HI2mDig3LBu6H5ydul+kiPfBHKTQirdXwP7H/tvWrII=;
        b=BDRBUjm+kZxxNNZtUJ25xPii5HPB04Qe3zEtAJug0d6s1TF33ka2TixctLkz0T8g0q
         6PNWHqHTgtPcbA7ALxn1qfjUr1vCPuhB5Nh+/V9aCVPfi6kugaUzDsZO9riI3G3MOFhT
         I7KsHLLagt4q46qxtGEE1r7/8Xf5HjX6XiPl/SmIulRqnW0AJvrym35rx5lcNIWeRDYb
         7eRPXdXnL+Zf+arH2b6kfyH6IkHSsW0o1f+fAMbPgx+PGCjODNa8XMJkeAiVH93/SKO0
         T+Wl0xqm4//Ns6b06xgT7OgIJ/oNBSBAXRn9YCPttQ7YsjgUT7sJvaExGWSFw0GbhBI9
         jvfw==
X-Gm-Message-State: ALyK8tLxZF0oqfj1iQKqJpHjL0Aj5T/L+qbGWozsVyvwBlaROHAN5yxx02jZiVtw3EUN0LRL4SDQVa3YlB8mEQ==
X-Received: by 10.28.109.197 with SMTP id b66mr44464496wmi.68.1469538596464;
 Tue, 26 Jul 2016 06:09:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.140.67 with HTTP; Tue, 26 Jul 2016 06:09:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607261452281.14111@virtualbox>
References: <1469519305-11361-1-git-send-email-orgad.shaneh@audiocodes.com> <alpine.DEB.2.20.1607261452281.14111@virtualbox>
From:	Orgad Shaneh <orgads@gmail.com>
Date:	Tue, 26 Jul 2016 16:09:55 +0300
Message-ID: <CAGHpTB+5ePbGyBMjozmwC=0ksqQShUt8Pa=QzPg4R0tf5467Xw@mail.gmail.com>
Subject: Re: [PATCH] commit: Fix description of no-verify
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi and thanks for your reply.

On Tue, Jul 26, 2016 at 3:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Orgad
>
> On Tue, 26 Jul 2016, Orgad Shaneh wrote:
>
>> From: Orgad Shaneh <orgads@gmail.com>
>
> This is unnecessary, as it matches your email address.
>
>> include also commit-msg hook.
>
> This comment was a bit cryptic, until I read the patch. Now I find that
> comment redundant with the patch.

This brings the short help in line with the documentation. I should
have stated that in the commit message.

>
> However, I think that...
>
>> -             OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
>> +             OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
>
>
> ... it may be more desirable to future-proof this simply by saying "bypass
> hooks".

That wouldn't be correct. prepare-commit-msg is not suppressed by this flag.

> In the alternative, it would be good if the commit message could
> convincingly make the case that there are no other hooks that will be
> skipped with -n.
>
> Of course, I could go and look at the source code to convince myself. But
> it is really the duty of the commit message to be already convincing
> enough.
>
> Ciao,
> Dscho

I don't have much experience with submitting patches to Git. How do I
edit the commit message? Submit it as a new patch?

- Orgad
