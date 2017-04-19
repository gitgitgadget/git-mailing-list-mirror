Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EFD207BF
	for <e@80x24.org>; Wed, 19 Apr 2017 17:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968402AbdDSRWj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:22:39 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:33587 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968398AbdDSRWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:22:37 -0400
Received: by mail-yb0-f181.google.com with SMTP id 81so9653414ybp.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ECMpWmQY/LQIJx+ragUPbr9S782LU/rvnO7sTWFwFN8=;
        b=OF0wMrdtwZsWvf+Fh1Ipw4JR7nOBgC9QKjtstIDnE/3xYRrdwHzMaAgVpk3oTzWnHn
         c+oz/eucSG783YkWu04Fm78z3x6gwlnAKltqdP19kWOfxGR9lxg8A1PcvqebzWOwp3Uq
         Ry0c9afAkfm4t1f/IXimz7SbgP1MsKqBkqpbHpfkP6OA5YBLrWwsTz1zfJeLYYNtuUBJ
         0s2sEFTcrn4GUOroRpdsaRVRYMQtwLk+oVf32cr6Go/fH+1VvAHFrJlS4ZACFxahBekT
         gMZokNbWsHpsclzfN/wbxDaAqmYbBL2YiRs36d9Z97oAampXese4FPdF3l08kUxFo9pG
         fxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ECMpWmQY/LQIJx+ragUPbr9S782LU/rvnO7sTWFwFN8=;
        b=sSa5cY43cehNg1G+VpGpzJfEfFgTtupw0m98E9Uerutdr4SyTcJ5JHGoMXxLxjKwdk
         QDpTHFFaOZd6wpJD6nOSjSqFBz1QGd5efkVx2oDGNpryoiTi8Dao+hN4KcT3U0VTKkqe
         uvNjAmCrZjB/rYG1JYYMzJvkHBktK62Ltr+bFicjGDiUYeW3tIzsJnQwi67+jBbBBFs6
         XM4p+wD4+jF0M6+fp+R+4zd/IBJmRN6zoLM9OLozPs8B1JHeBnxOo3Dc3TeLbreuTntq
         Pb75x3LqYC8MJmgdFvg8PAY0p4t5AtY5BsgWcv1eP5lmtohc/ZranQ+eJrClXVX7FxhD
         eYYg==
X-Gm-Message-State: AN3rC/7+Yq+t3Uj4+2DM0mHhVJpdneYHxtcsCXrfV3Ihzu1Fxkh1BkHh
        Rgxb4PGJb2Kk05cRLUvBOdbuKVbg1s0k
X-Received: by 10.98.24.195 with SMTP id 186mr3986430pfy.35.1492622556068;
 Wed, 19 Apr 2017 10:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 10:22:35 -0700 (PDT)
In-Reply-To: <xmqqwpah9ci5.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpah9ci5.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 10:22:35 -0700
Message-ID: <CAGZ79ka_02z-G9Z2=i2TLzRTMty3VJY9gbFtWmANtQDrwVr8Vw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #03; Tue, 18)
To:     Junio C Hamano <gitster@pobox.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh wrote:

> Also, I would like to ask is there are any more changes required in my microproject for getting it merged.
> https://public-inbox.org/git/20170403213557.27724-1-pc44800@gmail.com/

See the last what's cooking email:

https://public-inbox.org/git/20170419094145.GA9051@ash/T/#t

Junio wrote:

> * pc/t2027-git-to-pipe-cleanup (2017-04-14) 1 commit
>  - t2027: avoid using pipes
>
>  Having a git command on the upstream side of a pipe in a test
>  script will hide the exit status from the command, which may cause
>  us to fail to notice a breakage; rewrite tests in a script to avoid
>  this issue.
>

I have reviewed pc/t2027-git-to-pipe-cleanup and it looks good to me
for inclusion.

Thanks,
Stefan
