Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7707220282
	for <e@80x24.org>; Tue, 20 Jun 2017 13:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdFTNhe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 09:37:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36477 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdFTNhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 09:37:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so23127061pfd.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=zZ4XH7EbMcqSx+F1wo7Wndt9s6IusdXVXo4Ufhfwyzc=;
        b=I1Bq/wZyfQ5/unB43KBPSvL4bMSpLpeBy7PiQ4sMxGEJEhp5T/jagk7uGB6eMjOOL1
         N0YjW6FP/ezzeMQxATLJj4ywId2ZkArYN7Yca+GAcipc0c0EpHoNl4dgf38LsV46GSzI
         Wy85NUwZfBICpQHd+SP3pPX1OSpvjBIfFjPrdMehA8RPg6BbhKXQXf48KrGjYvzOYwk5
         pMxq6AvDbmea+qQx7X4KmrpxMZDb9HI8ucAWkj3bjoGf7ZJHVFMs9vP3SWgqZD5ZTYCh
         Co2A3B51APqIKFJep0A7Oj4LlxTQ2xh92DO18AexSqzjRyJ/Bw3ZRdaTy5yY9SaswLQR
         n9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=zZ4XH7EbMcqSx+F1wo7Wndt9s6IusdXVXo4Ufhfwyzc=;
        b=fG2+gMdbcrp5b3+DHeVEuoDrX+k1kdZVy2gCP0reF74emiuJST1K54kB4jIX+Myfec
         DHfof/3xG71VnCUqJbaRFrlO6WHtuc+krRHSDxazl44mF18mqOJ0s022L1b2UsG5iXAa
         eHaDQ0l7J4X4y2/DUjZaOgrO9ZSD7s3mpfPMStN8rTozCQS2lT+WQzpOTjIZ1L0Dl37Q
         roz/QblqXQXnA6nShHGlQdMGCyCUg8LCQjykjQF6492BGPrYKXjduhCtQBT/piw76Sc0
         Iw+K9Pk5xuGDgscJdvaiYGtlv00oJeWqwUApa28T9/d4PYsFYdDb9cNwLQL8y7QqKL7u
         I0mQ==
X-Gm-Message-State: AKS2vOw8v8dZOJC1v5vqJ8iia6K1iaskno0zFEZsI4sIVGterWZGKsTg
        6n6KI/PX+tdBDQ==
X-Received: by 10.84.129.4 with SMTP id 4mr36892081plb.9.1497965852036;
        Tue, 20 Jun 2017 06:37:32 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id u73sm27857708pfi.105.2017.06.20.06.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 06:37:31 -0700 (PDT)
Message-ID: <1497965839.2792.2.camel@gmail.com>
Subject: Re: [PATCH 1/3] Contextually notify user about an initial commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Date:   Tue, 20 Jun 2017 19:07:19 +0530
In-Reply-To: <87o9tj86hs.fsf@gmail.com>
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
         <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
         <87o9tj86hs.fsf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for trying to help. A few comments regarding your suggestions.

>  * Let's do that spacing fix (unrelated fix) in its own commit.
> 
Ok. That's a good point.

>   * You should add tests along with the code being changed, and
>     especially change tests that would fail with your new code,
>     otherwise you break bisection.
> 
I'm not sure if the convention here is to keep tests along with change
it tests. I thought it would be better to separate them as they are
"separate" changes. They're separate because in case of any issues with
the test it should be possible to identify them separately. This isn't
possible when they are added along with the change. 

Further, adding them as a separate change change (commit) immediately
after the change it tests would ease the task of finding the change it
tests.

If the convention here, really, is to add tests along with the
change, I can't do anything but to follow it. I guess it should be
mentioned somewhere in the Documentation/SubmittingPatches. AFAIK, I
don't think it's mentioned there.

>  * I think the commit message here could be shorter & clearer at the
>    same time.
I don't think it's unclear. It's longer for the reason that follows.
The commit message was crafted based on the following guideline found
in Documentation/SubmittingPatches

> The body should provide a meaningful commit message, which:
> 
>   . explains the problem the change tries to solve, i.e. what is 
>     wrong with the current code without the change.
> 
>   . justifies the way the change solves the problem, i.e. why the
>     result with the change is better.
> 
>   . alternate solutions considered but discarded, if any.
> 
I don't think the new commit message follows this. Both the commit
messages are found below for comparison.

Old one
-------
> On Tue, Jun 20 2017, Kaartic Sivaraam jotted:
> 
>  "git status" indicated "Initial commit" when HEAD points at
>  an unborn branch.  This message is shared with the commit
>  log template "git commit" prepares for the user when
>  creating a commit (i.e. "You are about to create the initial
>  commit"), and is OK as long as the reader is aware of the
>  nature of the message (i.e. it guides the user working
>  toward the next commit), but was confusing to new users,
>  especially the ones who do "git commit -m message" without
>  having a chance to pay attention to the commit log template.
>  
>  The "Initial commit" indication wasn't an issue in the commit
>  template. Taking that into consideration, a good solution would
>  be to contextually use different messages to indicate the user
>  that there were no commits in this branch.
> 
>  A few alternatives considered were,
>  
>  * Waiting for initial commit
>  * Your current branch does not have any commits
>  * Current branch waiting for initial commit
>  
>  The most succint one, "No commits yet", among the alternatives
>  was chosen.
>  
>  Helped-by: Junio C Hamano <gitster@pobox.com>
>  Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> 

New one
-------
>  status: contextually notify user about an initial commit
> 
>  Change the output of "status" to say "No commits yet" when "git
>  retaining the current "Initial commit" message displayed in the
>  template that's displayed in the editor when the initial commit is
>  being authored.
> 
>  The existing "Initial commit" message makes sense for the commit
>  template where we're making the initial commit, but is confusing 
>  when merely checking the status of a fresh repository without 
>  having any commits yet.
> 
>  Helped-by: Junio C Hamano <gitster@pobox.com>
>  Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>  Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>  

>  * The commit message doesn't follow our usual format.
Could you be more specific about where it's not following the format?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
