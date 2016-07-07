Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE582070D
	for <e@80x24.org>; Thu,  7 Jul 2016 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbcGGNYk (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 09:24:40 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36108 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGGNYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 09:24:38 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so210646245wma.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 06:24:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MyouuaVe10PZnDygtLXcApl341H9pya9aRN4pFv3gnY=;
        b=uEZS7T1tD4Scm1Bqhnowo5Y5ESy8HNL4EfmnPI3Ad8X0rA1NVbsUcfxBIC2gM+H6Op
         KnWFNa+c2L9LdPp3x1gffzwpNrZ/yVw86rvJH4Yo+KI4B8Kuckhcy+qIJ7tMBj2MKgQ+
         Q4SjeOyfme1grMtSNItnMFdU4PDhrd9nAyAIjS93wiuWA0ZL6vu67HAaQb+GoK0rky4f
         fJl/m1Krnj9LNXsav8l+s+MwrtAN1GWvSURNQwQ93pOmO71IKsIULi/+YK93ZV7NSo89
         z7IcqYizDaa9mmaVvkIgbwJTOu7KMQXBa87uSWwH2yBgmHAexEj19LuioD76QhSFqxdp
         NF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=MyouuaVe10PZnDygtLXcApl341H9pya9aRN4pFv3gnY=;
        b=IixJVMwjPB/iKS1gItba9qgN0G6jstTFmc0MTbKA/81Wxp2TJlyHqfPsg8AsRyXrnT
         YsEjBPHazdF+Vd7nhbWfkMRt05Gt9YssGy4ESiQPL74cmVMxN59Zs7xmd+HEFWn0NOvy
         /vTbD9Xo9/jzvYBCOmbg4sb8XweU41RTGHwRs7SopS3Erqp5s8cPtFgrQDVlXsb5laq0
         SGp1VxHDv+bV/lBUgh3sJA4O/IR4udVL3UAkthrtV+UHqS/dl3LArrGm095btg0fBYZq
         Qbvws/JzTlJtGH6ANyRs5LYsn2JYCvXusKrMjRUPTZKIztrglCYXd89PCFWbFYs3q0vd
         3prg==
X-Gm-Message-State: ALyK8tL5W2fDJdEFFgI+BFzNBRf1Ks/2dCJlwTyVJnl4ajPtX2ZWicI5OtO9c2m6vFg1HQ==
X-Received: by 10.28.167.69 with SMTP id q66mr3023063wme.100.1467897876379;
        Thu, 07 Jul 2016 06:24:36 -0700 (PDT)
Received: from [192.168.1.34] (elp79.neoplus.adsl.tpnet.pl. [83.21.209.79])
        by smtp.googlemail.com with ESMTPSA id bc9sm4993019wjc.45.2016.07.07.06.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 06:24:34 -0700 (PDT)
Subject: Re: [PATCH] am: counteract gender bias
To:	Mike Hommey <mh@glandium.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
 <20160707124943.GA22668@glandium.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577E580B.5090000@gmail.com>
Date:	Thu, 7 Jul 2016 15:24:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160707124943.GA22668@glandium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-07 o 14:49, Mike Hommey pisze:
> On Thu, Jul 07, 2016 at 01:47:19PM +0200, Johannes Schindelin wrote:
>> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
>> almost 11 years already, we demonstrated our disrespect to the pioneers
>> of software development like Ada Lovelace, Grace Hopper and Margaret
>> Hamilton, by pretending that each and every software developer is male
>> ("his_tree"). It appears almost as if we weren't fully aware that the
>> first professional software developers were all female.
>>
>> We know our field to have this unfortunate gender bias that has nothing
>> to do with qualification or biological reasons, and we are very sad
>> about the current gender imbalance of the Git developer community.
>>
>> Let's start changing that by using the variable name "her_tree" for an
>> equal number of years out of fairness, and change to the gender neutral
>> "their_tree" after that.
> 
> You make it sound like the decision to use "his" was conscious and on
> purpose. I doubt that was the case, especially 11 years ago, when these
> issues weren't as publicized. Let's not attribute to malice on part of
> the people who wrote those lines what can be attributed to linguistics.

Also, in all (?) other places we use "ours" and "theirs"; it looks like
git-am was a strange exception with "ours" and "his" (also, it was/is
inconsistent in using plural vs singular form).  Though perhaps it was
created before the terminology solidified...

As to why it was not noticed and not fixed: probably no-one worked
in this area, thus nobody noticed this (callee just don't care how the
parameter is named).

Instead of nebulous "fairness" (i.e., be unfair in other direction),
in my opinion it would be better to simply fix the issue, be consistent
and use common terminology.
-- 
Jakub Narębski

