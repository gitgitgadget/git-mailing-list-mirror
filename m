Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37DE202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755512AbdGKN3l (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:29:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35372 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdGKN3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:29:40 -0400
Received: by mail-pf0-f176.google.com with SMTP id c73so67213564pfk.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=m16OYsbqzBFueznhyKKrhkLoBdkO9a9ZudKZuCIIPYg=;
        b=orP1PtT0Ck9ciJIgaCnjKBBfHGY7Wi5rnaYOR7cgBgKMNuFTET8dcL2JnlzWkuM19P
         XSFVU86CAtpK/307RRZxKZRIzmJcq3qZpDlY7kICqLTvHmiU8p2peNABxDAO8IcYmM8V
         hRMgKaI04ODgA71wT4oNclSriZK7+OxZx+P5FEcRToO+L2oD+hG03w+Y9Ngai2qfwl/8
         Mfa1SkLJGVVTb77zsyXxFqTwXImMjnjPlXWxEF7DdFyg8I0LUg3Qn0xoQ1vRcXayK9fX
         rCpoRmw6d+cGBAeDs8TmlSXlWcnXn8Atl9o9ySrvC+8hL15ZQDsib6AzsVTq/ISSYuAU
         TygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=m16OYsbqzBFueznhyKKrhkLoBdkO9a9ZudKZuCIIPYg=;
        b=U1FjmpXbd5vjkt+HGpDb1qb5Z6AjPtIyeBcm7z1F56NAIACLbGB2g8dkFkHil7ZXBc
         T0ZJiSb9m6oJZKEXaMREthF0aC7feQBGlM0jWGsAvscgILxn/0ISktOj5QyfLYrCLpvp
         jl2fHVM8+w8GBb6kFpOGXJ3qbolG7nzLb9uTnWftZxYPzJKu/3Eo1EkJCcXAuwASFibr
         OZ0GPZhu6lFNblhrPGdVxnWGC94ixcbZHROPbLyznkDFA3D1qucIrgXjjEfDK7XsvHVf
         kcNYuZEusZE8twbtAMy42Xeko/WD6Rw6Z5dKa8kcEZiLlWvtdIWrI7+5JJYy5yOVL8RC
         1QOQ==
X-Gm-Message-State: AIVw113+i1fDCQO62rhuKFTPNMnwE+sraRbvsdQ6lJVugO6CdOanJf8P
        1YQHQoGX9GTXxA==
X-Received: by 10.101.77.6 with SMTP id i6mr20239422pgt.43.1499779779896;
        Tue, 11 Jul 2017 06:29:39 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 10sm31406779pfo.134.2017.07.11.06.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 06:29:39 -0700 (PDT)
Message-ID: <1499779787.1740.5.camel@gmail.com>
Subject: Re: [PATCH 4/4] hook: add a simple first example
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 11 Jul 2017 18:59:47 +0530
In-Reply-To: <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
         <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
         <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
         <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
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

On Mon, 2017-07-10 at 13:02 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> >  I made an attempt to make the second example work with amending 
> >  with the aim of making it suitable for usage out of the box. It
> >  seems that it's not easy to make it work as the status of a file
> >  cannot be determined correctly when the index while amending
> >  introduces changes to a file that has a change in the commit being
> >  amended.
> > 
> >  Is there any way in which the second example could be made to work
> > with
> >  amending without much effort? I'm asking this assuming something
> > might
> >  have happened, since the script was added, that could ease the
> > task.
> 
> Sorry, but I do not understand what you are asking here.
> 
I'm was trying to ask, "Is there any way to change the second example
(diff --name-status) to make it work with "commit --amend" so that it
could be uncommented by default ?" 

If there was a way then the patch 4/4 could be dropped as the name
status example would be enough make the script live (I think). 

> After going back and checking 1/4, I realize that I misread the
> patch.
> you did keep the commented out 'diff --name-status' thing, so it
> still
> has three---it just lost one half of the original "first"
> example.  So
> please disregard my earlier "do we still have three, not two?"
> 
Actually speaking, I did think of promoting the second to the first to
make the sub-patches independent of each other. I held myself as I
thought it would be overkill. Anyways, I'll just overkill it!
