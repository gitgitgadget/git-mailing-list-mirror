Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834BF1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbdLOTUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:20:21 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36006 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbdLOTUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:20:20 -0500
Received: by mail-wm0-f46.google.com with SMTP id b76so19674498wmg.1
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/nboJkQxLRvmPo4B155kUzjPld6txLNfjjo6hLMk4/s=;
        b=RVIBzQS6rTO61ypeTBPU6fjs4mpYFsbV7L0n9y3LkZnafHs0MWUJvJWW+QCMI2ou1r
         O0BENDQcG6AwbtxsMCAtPF5yaowKyEkdH0svqtBJ558uuQJD/qNYiji5YfUWUZwRZB/L
         r6R/MbW+CKaSBTH9KcOFF5Mb3t0YPl7+q5bR+RHKsu5FW5ugHRVxwXEDBBV46J5HgkqU
         H5okPmIXSttGLDQcOW5u4D0TWbiqKG773thQkGjvSB07saglplsdSwE/L0bh9FndGEGW
         T5JVLJxc4I8l5FZHo60EdTe6MYtqtr0PgKtsIih5dpWIi7fFWZIxF6A8Na2sThliiB15
         DDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nboJkQxLRvmPo4B155kUzjPld6txLNfjjo6hLMk4/s=;
        b=IjJPqKYefZEaltnPVsnQe3zHSk6rekAWbt59GGJWznV7y4rg7+oEuNZ4Wskj6S53wK
         RaCBXE0w7XffcXDDB1LJYpq7lfcVIJxoOZLvxgvEstBL8qnbVSUO3K43xSF2kZ4OjIol
         8ZwgeVAdLhOyX5m1gUd8LN/2fwugIGapZWoPAWihsVJRgHI/QHcj/MuVGKpNFzr8OJyp
         sP+QSDSXhrCWPV0aAIxfEb6fvQUJnd5GXv36U+ecT8r+zLoIjx7cygv7mAg+zxbVC6m/
         ySsVQzC/CgfcXhp/T27uq2aX4DPGGm3pDGRlb5ouPvoh+Igi46kIWn/BvVsFoovl8WSa
         l13Q==
X-Gm-Message-State: AKGB3mIf5B/hBBVVnILt0UDNPQXVsBsXTHpCiEiBNySfypbAbCnU9Ro1
        kvdxIfCIwdWWpI/qVqO90SvkS1BQ
X-Google-Smtp-Source: ACJfBoukiecn7ttjZAAZqoF6KQyCNjUhHp/OYG9E6P3PwoivZDm6qRqcKnf5nbae8ITZKwGGOLcCOw==
X-Received: by 10.28.149.203 with SMTP id x194mr6067552wmd.145.1513365619284;
        Fri, 15 Dec 2017 11:20:19 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m50sm13129066wrm.12.2017.12.15.11.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 11:20:18 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
 <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
 <xmqq1sjvreoy.fsf@gitster.mtv.corp.google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <89694b65-a0b0-c505-fcab-24c2e8961b12@gmail.com>
Date:   Fri, 15 Dec 2017 20:20:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sjvreoy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/12/2017 20:09, Junio C Hamano wrote:
> 
> > Junio, what about consecutive runs, while merge conflicts are still 
> > unresolved?
> 
> The impression I got was that the original running with svn does not
> deal with conflicting situation anyway, so I did not think about it
> at all, and I personally do not care ;-)

Heh, fair enough :) Though I was genuinely interested if there is a 
better way to accomplish it than `git add -u && git reset`, but I 
guess I can take that as "whatever works" ;)
