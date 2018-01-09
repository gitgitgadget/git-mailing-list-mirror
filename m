Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238481F406
	for <e@80x24.org>; Tue,  9 Jan 2018 12:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeAIM7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 07:59:50 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39817 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753842AbeAIM7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 07:59:48 -0500
Received: by mail-wm0-f41.google.com with SMTP id i11so20436009wmf.4
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=icq3X/s2VCogLCkIADB5pzdbQLWaACPeVJh2mjLAUpY=;
        b=b7dPyT1euXWsLN89+rBZf0yRl6A6GGTE7GkNdcX8HYz7zRafIZjMBWPHbJzoQE+rZX
         8pmmAXWlmMKCGDlpLbq0q5KpURxemfbHdEKXs6S32QlBT0sErRNgW8wDWRZTs+2TyU4V
         g8iUPOHuZD1J71AIWgHAMMGOGWWSO+AHWvcIAGqGUTWaTNvk7gEm6+dmc6ekmagbHFSj
         mdeuq7Z/21mFVXxid158x2/WRf41Uqkcap4309qLIAXS0/DNH0wJniA+d+U0Me9f3UXR
         hQjYYPO/h/joeh2fMZxMfA42SpjUOUBNQVDtzT/Cfnw5OtJBDAAgjkqgK9U/0ALBRlxn
         TRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=icq3X/s2VCogLCkIADB5pzdbQLWaACPeVJh2mjLAUpY=;
        b=gbLjREA/vY+MhI1v67BCP+gxA8kB8OAovvJojgsUSC7i31IZpQy1YdDgtJGcagqUcb
         lGIwjMWBJjP8M0BvYKvM3AUzRiMsIETgmhN53AGNGKr+U4BaCPtpBqx/VG9KSwwNW+QK
         zH0Z5xJCDDMzG/QigVImR4T/eNclvy7whCMjNrfG+bPwh0fRkiOhAMMbj8nWC9ZykGif
         KVohTUXilqbKKpBsKLhumh4RM5eTykqOrXcr94tVA1cQmbJIBFJnltJveQAMEy9pny44
         XdRvetRG0GXHZYzwbVJ7YvIRTk/o3dgBDKyjtWT28cCxIwl0jnFQdvqldr1XtwFAwlc+
         5ULw==
X-Gm-Message-State: AKGB3mIcSQ8YpsDegEr2NmOEuJo5kFEh8kULCI8iTAdPKiM0zcUOX2Qv
        bOTFDXnF1FbCwc8kJJgu8Ek=
X-Google-Smtp-Source: ACJfBovoSDZAFpPd2A3s2PV1lMAVHlkE4w1bRnNc7ifXJjH3mOu0+Qv14pNTuCxLJGOTZDKNnZ9Htg==
X-Received: by 10.28.131.142 with SMTP id f136mr11389618wmd.121.1515502786997;
        Tue, 09 Jan 2018 04:59:46 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n17sm11405584wra.58.2018.01.09.04.59.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 04:59:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 9 Jan 2018 13:59:43 +0100
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: 7bit
Message-Id: <ABE531C2-3173-441D-8710-B9B75C97B4F5@gmail.com>
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Dec 2017, at 00:00, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>    http://git-blame.blogspot.com/p/git-public-repositories.html
> ...
> 
> * jk/progress-delay-fix (2017-12-04) 2 commits
>  (merged to 'next' on 2017-12-05 at 8e62c2b18b)
> + progress: drop delay-threshold code
> + progress: set default delay threshold to 100%, not 0%
> 
> A regression in the progress eye-candy was fixed.

Hi Junio,

this fixes a bug that affects the Git LFS community (not only
eye-candy). Would it be possible to get this into Git 2.15.2?

Thanks,
Lars
