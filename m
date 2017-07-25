Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0817E1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdGYSxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:53:39 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32980 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdGYSxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:53:38 -0400
Received: by mail-pf0-f178.google.com with SMTP id s70so61685650pfs.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=P89A5pro5PzlYyYwaHU4f5Fh9UMQUv48XPwjL6Oi3PQ=;
        b=DIGeWmuxQvV3iM/Qiu52GQieEWFqpMzrrtLpCsy1zvMNrH9noC7Z1rI3mxnS5DtzGY
         UD4qnVHqmS5em9vcfndurKto/sGd6aLOmfWmlzbULaBu/j2cOxJIZxSDxgYgGfOGcEip
         UZasEKql8l0/r5tyHZ4nt7ZdPDCVH3NGVViX91HqTBnKgQiPQmswCR9b9CyslllUdqVo
         n57x8QxlNMJcJ6GF86uFVMFzhTU2hTrONjtWhZtQ71JOFtbK0KR12g9Zwa0rAmNgjWWL
         b81WDDINbr/wKHIkQTWp5kkJztquLWO+VtZw6Im+72ZGCmncvFuAZCzL37iZRG/3IziT
         1nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=P89A5pro5PzlYyYwaHU4f5Fh9UMQUv48XPwjL6Oi3PQ=;
        b=l0+/4kGiQQd3JkpxgIvSw3bGkCtsoXa/qyvRn/lpZl/yAT4wVHll7gJRxT7pYpum3t
         YFLQJD3mKOLXwB47Ewbzd8e88Ch1gn4iL+YXrEvHy0UKQZ/UGtfv9liATY5XyNUvoKN1
         /FUdMJZpou60o6n+9cRMHKvOtwziJ1OJDLcEnLCzBmB8Fq0aG22w7pzjBjdvtDYWdtB+
         Gx7/PvSA4vNy82UgRdZonMTY6MP3C+q9BxwcCKigKvo2wZzEUFep9a13tAmWLiSdwKg7
         hvNl8Hi1iWSnyYZvFKXSajo6lo6Oun4EKEDtYntcAWPAKG8dRuS4Hisf6K8i/8Tke529
         YocA==
X-Gm-Message-State: AIVw110r/KPH25Rk9OIjbzX6IkoaP0q5QgoWSqhbtFcVcKoHYA3RSmLZ
        +gQhWDXv5D2fvFTlzLo=
X-Received: by 10.84.253.9 with SMTP id z9mr18259996pll.439.1501008817699;
        Tue, 25 Jul 2017 11:53:37 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id b16sm29120929pfm.84.2017.07.25.11.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:53:37 -0700 (PDT)
Message-ID: <1501008842.11979.7.camel@gmail.com>
Subject: Re: Change in output as a result of patch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
References: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
         <1500923812.20078.8.camel@gmail.com>
         <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 26 Jul 2017 00:24:02 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me see if I got everything correctly. Correct me if any of the
below observations are wrong.

On Mon, 2017-07-24 at 14:25 -0700, Junio C Hamano wrote:
> Imagine this scenario instead, which I think is more realistic
> example of making a typo.  The set of existing branches are like
> this:
> 
>      $ git branch
>        devel
>      * test
> 
> And then you get these with your patch:
> 
>      $ git branch -m tets devel
>      fatal: Branch 'tets' does not exist.
> 
>      $ git branch -m test devel
>      fatal: A branch named 'devel' already exists.
> 
> My reaction to the above exchange would be a moderately strong
> annoyance.  If I were told that I am using 'devel' for something
> else already, my "corrected" attempt to turn the 'test' branch to a
> real development branch after getting the first error would have
> been:
> 
>      $ git branch -m test devel2
> 
> and I didn't have to get the second error.
> 
> I think your patch points in the right direction---if an operation
> can fail due to two reasons, reordering the two checks and still
> fail with a report for just the first one you happened to check
> first does not give us a real improvement.  If it is easy to check
> the other one after you noticed one of the condition is violated,
> then you could give a more useful diagnosis, namely, "There is
> branch 'tets' to rename, and there already is 'devel' branch".
> 
So what's expected is an error message that details all possible errors
found in a command in a single message. Now that would be better than
what 'mv' does.

> I suspect that with a moderately-sized refactoring around
> validate_new_branchname() function, this should be doable.  Instead
> of passing two "int" parameters force and attr_only, make them into
> a single "unsigned flag" and allow the caller to pass another option
> to tell the function "do not die, do not issue a message, but tell
> the caller what is wrong with a return value".  And by using that
> updated API, rename_branch() could tell four cases apart and fail
> the three bad cases in a more sensible way.
> 
Ok, now that seems to require little work. I'll see what I could come
up with.

Before I get into this I noticed that "--set-upstream" has been
deprecated since,

b347d06bf09 (branch: deprecate --set-upstream and show help if we detect possible mistaken use,
             Thu Aug 30 19:23:13 2012)

Is there any possibility for it to be removed some time in the near
future?

I'm asking this because IIRC, the 'attr_only' parameter of
"validate_new_branchname" was introduced to fix a regression
(fa7993767560) caused by the "--set-upstream" option. In case it has
been planned to be removed some time soon, it could make the word
easier (?), not sure though.

> In any case, the illustrations of interaction before and after the
> change is a very good thing to have when discussing a patch,
I would like to credit that to "Ævar Arnfjörð Bjarmason", who suggested
that to me in one of the other threads.

-- 
Kaartic
