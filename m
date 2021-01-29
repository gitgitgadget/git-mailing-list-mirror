Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E218C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 06:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2092264DFD
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 06:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhA2Ggm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 01:36:42 -0500
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:38857 "EHLO
        pv50p00im-ztbu10011701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232039AbhA2Ggk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Jan 2021 01:36:40 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2021 01:36:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1611901763;
        bh=jOgpzlWbKMvPggN8x4MRA7uuXA3q98FlFK3jP24fAZA=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=d1vTb8ZuJW6aRQfeW/gQYa6AKpVX7gF2QiAR6WywEbpXdSRbx4VVJlokENyVTtC9o
         c0x1RTNyJggoCsv7EPxKHTpsFn0HXagNx96r6GE37j2XpOAPbDYTFLMsBX5qTCvBaE
         JT0i36ikDE43WLVZcOhJVCGaRNyw08XQ894igHU4wteTfB71FARjeQYlocCWn84HYZ
         OsTdhvx8T+9upAxGaO8TFRf7Xx4EUVymOQg779hNNTRDFdeD2kXM5K4rAdldQ4URfD
         5Ul9BOkDhFZ1Jd5oJYThUc47NLO05ZKZJjtChuXbCKGdE4wHgouMw2J/6gp4/nhvte
         xMJpeH2q0eQig==
Received: from [192.168.3.14] (softbank126055111154.bbtec.net [126.55.111.154])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 3C50B8A062E;
        Fri, 29 Jan 2021 06:29:23 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?55qQ5pyI?= <yuumaasaku@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 29 Jan 2021 15:29:21 +0900
Subject: Re: [PATCH] git-apply: Do not free the wrong buffer when we convert the data for writeout
Message-Id: <3148502F-D462-41BA-94E5-CE4E2F50CFCB@icloud.com>
Cc:     git@vger.kernel.org, litvinov2004@gmail.com,
        torvalds@linux-foundation.org
To:     junkio@cox.net
X-Mailer: iPhone Mail (18C66)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_02:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=471 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101290033
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCmlQaG9uZeOBi+OCiemAgeS/oQ==
