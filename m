Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214EA202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdGFQEx (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 12:04:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36195 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdGFQEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 12:04:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so826958pfk.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=44hq6HJOxbOBzGP3KnbXXvcG6/IvcxBbLRhk2qpW1e0=;
        b=WwORQy6DF0spbvbJQFbA6ftyUcy7mRFXLZW6kzv3q1WzPrzAOQ5I6ZMZBE5/EF9Mjq
         n6CwGAgRYmB7GRbm3vCsm1jAcd0slFw7cv2nfoQURVlM2pMTr7BLmaPy9uwLPqgVbe4+
         mAnhL8M78AETDbKfOh/kM9tFh3uYKRVr4gCq0o7eqP4WSzPCqGkDfzZLQjH2XKvJyhar
         78Lb/9D4o6DM2Y1HXNES1893baCIjiEI2H64yucfsPjbCH11fmpVXEqEQ7mfi5WvTyY3
         yEP39cTyqbpVng7oLdjW8a5BWzYwjkAaGPDkIwRjTtJAY/ZP/kPXDkyt/4s3co8C5IqH
         icHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=44hq6HJOxbOBzGP3KnbXXvcG6/IvcxBbLRhk2qpW1e0=;
        b=gd6b4oUvjA76CSMpObRifVS2pMBLj4yoDCFPITrUN1w5hGGF3O5U+bYs6EaWaGbKSj
         lcr6L/o1aG4cYXIYYqifYupSxuik6UNSlDLNvAVwIMeVa/VhyjXY0z7QPop1CWK37d2b
         Wob0NHxbdDnCRWlT4CWZGEWxHLRoT7rs45aq+aB5rH9voPalQ2BM1ikYMg+oU/jVbnLS
         ERxV/rMe9e+SjccjmJIe6I81q/8jQByHRQkuRBhR3HUKFLME685CIZGe/5uX2Fb0aTnB
         4XscML52DNAB57WbNxQa0orcJO4OT3QBmelf20DiqUqvBLSC2Lh40sdhSzNTo1uVL6hy
         umfw==
X-Gm-Message-State: AIVw110Z3sX0xq8B703YfruA4/inBijXrCVBI/S4BlUzrR40FiVBJ0DU
        IiJsDE74PDBUuQ==
X-Received: by 10.98.11.4 with SMTP id t4mr26436283pfi.104.1499357092179;
        Thu, 06 Jul 2017 09:04:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id u73sm1159695pfi.105.2017.07.06.09.04.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 09:04:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] comment: fix a typo in the comment
References: <20170706144711.31002-1-szeder.dev@gmail.com>
Date:   Thu, 06 Jul 2017 09:04:50 -0700
In-Reply-To: <20170706144711.31002-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 6 Jul 2017 16:47:11 +0200")
Message-ID: <xmqqtw2pft5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Speaking of sharp eyes...  That Subject: line really needs a
> s/comment:/commit:/, doesn't it? :)

Surely it does.
