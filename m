Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB14CC47426
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 04:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A79221EC
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 04:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="u0FkRwTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgI0EwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 00:52:03 -0400
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:35230 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgI0EwC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Sep 2020 00:52:02 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 00:52:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1601181856;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=u0FkRwTVtazeA0JJ7A/mhkyb6WVq3qMQwZlLlUEUyG27WkjRtvZkHJMmcFRK3XOpP
         3nXvdQ8F1X1yJ0/XhWiZJP9+rzDHHvMS684tuwScBpo4tUXUFE5L51nNf1iQL4EFkQ
         WA6LPP/9bNDogl2lRkxrGqpIVBs53ZiaOUF02Y/UfHrCyEawEhTttswv7jEDPgrDLr
         7mX0aKg3hz8fOhvJfajw+wd2tTXGxZZk0fDhO8c5/6DaaLB7ot7hyGGuIJF071vbDL
         q1wmk5Z3JmtdMoyrDWePojRJT1+qwYrxfNkKmGxno23sIb+zl78NDp2AEcvzKYjNLm
         Q3VW4Wtm+ah5A==
Received: from [IPv6:2607:fb90:628a:384e:7159:fe69:6e1f:ee11] (unknown [172.58.206.238])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id AD8AE5E02C6;
        Sun, 27 Sep 2020 04:44:16 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Gabriel Young <wezeyf@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 27 Sep 2020 00:44:09 -0400
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic record type.
Message-Id: <09E85784-978A-4252-81BC-5BCED11A246C@icloud.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, hanwen@google.com,
        hanwenn@gmail.com
To:     gitster@pobox.com
X-Mailer: iPhone Mail (18A393)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-27_02:2020-09-24,2020-09-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=337 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009270042
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


