Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5C22022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdBWT3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:29:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35910 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdBWT3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:29:32 -0500
Received: by mail-wr0-f194.google.com with SMTP id z61so68810wrc.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=gqQtKwHlD39ReHz0M721Zbz8goemRjC2mROqwGOdSxg=;
        b=mmL/ujgZ+Rnx34W2uUfj/i2hj8RBIcWeecIpqCg+9qPPOPPXQTbr95aB159V0Kwa3h
         47i+CFzNcQ3hM4THRfHTeJB/ytkkNTQ105RWGsk7fNoXKWCfLXnCdjuf4hw+Q1hMblhE
         NsSuCfPJkiHoNEjAxK4v7sFQnhpzueJ9y1guT/b1AOMxO1smfKuO9OLEKO5jla2qvFml
         FWTEiB9yiIXABWC1SlbIqL8KjQkh/3WF4OTkJCXUrjfv/KiUX6LANs+OqAfrORWOrak7
         HKfzCBkl0fkjkTOI0d8v236Nk9aSRb3lrTV3ELT1BwbQZpfUJWHE40c43bl0k5m2MNSu
         BuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gqQtKwHlD39ReHz0M721Zbz8goemRjC2mROqwGOdSxg=;
        b=IwLt8Y6dptW99RJbGxzIcELlUm8HV8nSk0ZRBhC99dirGRBBy7BOtvwFK10NgXFxUf
         jHooXX2fpQqrXRpH/N/u9cZaye4lEaIVIzeFOX7/v28mWidcXrOzxvaHMz9T1nb+oPne
         fQHOcsKSbOPESjlRRs1i3UM7EzkR5zEV+hXIyHA19MaMJ4gIbsqkmfpAmZ7avhrIj4+3
         YR+QSLeLm0KKdBOCEezcOEvaCsKxTMP+Q5OmB2OAfWAh3mogQmmSyHIssXsfNc67y/dm
         l7IUsREiWuMDqq7cdU+0yhty9Be6a8cu3LfToOXI7fc7uubBr5z6ICtFCxtoi+GBLnJH
         u4Fw==
X-Gm-Message-State: AMke39knmhfP9QdpfCgW9gFAiQGFj69coM0Rt701iqHY9PvrNlM1ODwJSEBxdrCE6Jn5fQ==
X-Received: by 10.223.164.1 with SMTP id d1mr15558022wra.90.1487878170537;
        Thu, 23 Feb 2017 11:29:30 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.47])
        by smtp.gmail.com with ESMTPSA id 10sm8076568wmk.26.2017.02.23.11.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 11:29:29 -0800 (PST)
Subject: Fwd: Re: feature request: user email config per domain
To:     Tushar Kapila <tgkprog@gmail.com>, git@vger.kernel.org
References: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
 <5e25e9d5-ca52-2b32-3701-4826599774ef@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <00803225-db9e-9ba0-fe37-8977ec611d61@gmail.com>
Date:   Thu, 23 Feb 2017 20:29:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <5e25e9d5-ca52-2b32-3701-4826599774ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forwarding a message that ended on my end only, probably by accident.

-------- Forwarded Message --------
Subject: Re: feature request: user email config per domain
Date: Thu, 23 Feb 2017 13:32:56 +0530
From: Tushar Kapila <tgkprog@gmail.com>
To: Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>

Hello All,
> I'd much rather see something based on the working tree path, like
Duy's conditional config includes. Then you write something in your
~/.gitconfig

> This would allow you to have two root directories, one for your work
projects and one for open source projects (for example).

I guess this can be extended for any number of root directories. Like,
when a consultant has multiple employer email ids.

This sounds great and it would enforce at commit time, which as
pointed out, is the correct time to do it. If for some reason it is
not adopted I at least hope that we have a simple global config which
specifies that user must set email for each repo and to ignore any
global config.

Am sure this can be done via hooks, but I would like something that is
really simple for newbies and companies to enforce with minimal
instruction.

* Will try what Igor and Grant Humphries suggests.

* Thank you all for your replies, and a big thank you for git - its a
great tool. I used to dream of something like it when I was stuck with
svn (pre 2010 I was introduced to git late.)


[1] http://stackoverflow.com/a/42354282
[2] http://stackoverflow.com/users/2167004
