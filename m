Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44208C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 06:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BDE6113D
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 06:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhDQGnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 02:43:13 -0400
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:56817 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhDQGnM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Apr 2021 02:43:12 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 02:43:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1618641433;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=qYdj1eyb8b8mY5EIDL8W1cQ2Y752rQm+xjHEVBR/7DdNuUhLP3mG0b1hqslO5pPUI
         Bz8M7qQslhnsAtmvAgGiqHcXRGPcfrwnNBBWE1O1Q3INYr3HxwjW69Pm3O/WLDq0Zu
         erw9lE52+Hd2uI0bKe5xgixnrFfxo7+MV0pjPi5dGsClM9MbRUIGPdrGD6HHuwSZfK
         4+twGgalhrYVR6wu6lqCZvdGqS3a+g2sC7ttOF/7sdqoi70giQetWdlm5CdsWSVLub
         TQek83kQqTRsYVmbYYOaLKmjR6P+/H6MsdNA9izRdOYXPcPj4PHYcTXr/12LbB6Z5R
         BXHEruaQiXQeA==
Received: from [192.168.1.2] (unknown [86.57.115.230])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id F179EC80745;
        Sat, 17 Apr 2021 06:37:12 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   amin parvar <parvaramin6667@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] [GSOC] commit: add trailer command
Date:   Sat, 17 Apr 2021 10:45:17 +0430
Message-Id: <465564A3-A39F-4290-AD2F-3097B6E766E5@icloud.com>
Cc:     adlternative@gmail.com, bkuhn@sfconservancy.org,
        christian.couder@gmail.com, drafnel@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, periperidip@gmail.com
To:     gitster@pobox.com
X-Mailer: iPhone Mail (18D70)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-04-17=5F03:2021-04-16=5F02,2021-04-17=5F03,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=586
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2104170043
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
