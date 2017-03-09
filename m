Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E30B20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbdCIBRG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:17:06 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35053 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdCIBRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:17:05 -0500
Received: by mail-pf0-f176.google.com with SMTP id j5so21692426pfb.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=WrQGIDJaqWez4w4YWcdZHX7GrPuqgdT4rP7Dc+KNxPA=;
        b=dVdE1uGejRX/fHPppJ+jl170ARABivcQ+lBCfkPiApqLhHSMbEoz+yiwzz/ClbtAGX
         1fjxqtn9VrQAF73dAbUWfIqxoXqHXbVw53tw4RD9TcsS9bqjcDpQTHDJ+nOdNWm8/cjg
         qs8qdCB27FYHFux+S4MZp19p92xvOMC6jlp+iB3teiJtPveDC6QMUZZ7ar+bnjvreGmQ
         JBJJ2qlHXXE+LsY2vdLVEkaMM790fP8E9qn20IPcuSeGwuMJbGTi/FNgidyNT8CSukID
         HMaHYpmHBzQyAaBZHnGkNMMrk1gR3maofKnnyjUDYyvWX+32jRctfZ/bqsFSppaN+X/P
         +oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WrQGIDJaqWez4w4YWcdZHX7GrPuqgdT4rP7Dc+KNxPA=;
        b=LEX0sBSibyFwVgXJb+eQ4bu5RsOIV5sCWlboIS1PxFom7hE3rvnS8ZVlV54KRL3jp6
         /yciF2/KY8DoP/y7xhuDNmsbZXsclJgthKH/73jckhR7Rbryllt++uTffjOSi2JJrVC1
         CWVXGJIgjbBVGuV1iBKTYDdjbvSAid9CFHf4FqKDEVAEfkBm9eQoyLOe1sJgnf43kpBo
         kvIq/cITXdsxM2mPK49KpTpP+JitJFUY4N/l3TNOA+AGOOtznjTZNlyc/jFiFnaMxfVg
         /yKkgBERjX3t/QNZnnVnkJvLXa/wWtbffI9ExjuZ8/Ap97j9KpVD+Nqf7zHRO+tKiYiT
         btfQ==
X-Gm-Message-State: AMke39lri+taPobEt+3Y3DL8vfRu9YqYBLleoWzms4Epm+wD+xxD+qiCs7J0jGHISxKBRQyc
X-Received: by 10.98.5.2 with SMTP id 2mr10823701pff.77.1489020369471;
        Wed, 08 Mar 2017 16:46:09 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:85af:fb30:90cc:bb73])
        by smtp.gmail.com with ESMTPSA id s13sm8329719pfk.26.2017.03.08.16.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 16:46:08 -0800 (PST)
Subject: Re: What's cooking in git.git (Mar 2017, #03; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c8f3c838-136c-2ace-509d-8600dc743ade@google.com>
Date:   Wed, 8 Mar 2017 16:46:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08/2017 03:47 PM, Junio C Hamano wrote:
> * jt/mark-tree-uninteresting-for-uninteresting-commit (2017-02-28) 3 commits
>  - upload-pack: compute blob reachability correctly
>  - revision: exclude trees/blobs given commit
>  - revision: unify {tree,blob}_objects in rev_info
>
>  The revision/object traversal machinery did not mark all tree and
>  blob objects that are contained in an uninteresting commit as
>  uninteresting, because that is quite costly.  Instead, it only
>  marked those that are contained in an uninteresting boundary commit
>  as uninteresting.
>
>  cf. <20170228215937.yd4juycjf7y3vish@sigill.intra.peff.net>

This is superseded by [1] which I just sent out. I currently have no 
idea how to fix the "revision" commits to be correct and still 
performant (and this might not be possible), so I wrote [1] which just 
contains a partial "upload-pack" fix.

[1] <20170309003547.6930-1-jonathantanmy@google.com>
