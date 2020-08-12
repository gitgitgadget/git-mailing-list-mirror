Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133DC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2002078B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="iDJCnoxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLAhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:37:13 -0400
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:41489 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLAhM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Aug 2020 20:37:12 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 20:37:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1597192136; bh=IjYt5pX5r7zb1dk+9hmja+qlAd2Kf5XnRG+jGOvGww8=;
        h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To;
        b=iDJCnoxQvxXLj6HAtCZPSDvP58OrjnvnGPyyPUCSNs8Shj9XEg9DtaheoqznnJVLi
         uwUlxy0iqMcTOX9ZFRuOGleSRGdvRcUOJy9LM9pSZsnZulsYJh8qH31dUPC22OukqM
         8Mto3l9tU1mZ0ipuaSjQSK4Z52EOx1G3citF2RP9QbRdPtBEAHKCTbwP6pZmOmz6H+
         tUxDy2O0ASJ9N1RWI70HyO6YFom7OtsbSz29yVcrB6S78lEmJE8Sz9VirPLg+VV6se
         2kMVOrWM0meZVVz44UfrpJGFJWh/ISd7DwX5lSzOrRNNLv9I5XDDbW0mL4QA7buHZ9
         ogIdqlMGhuFpg==
Received: from [10.0.1.11] (pool-72-92-234-38.prvdri.fios.verizon.net [72.92.234.38])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 61B67C80840;
        Wed, 12 Aug 2020 00:28:56 +0000 (UTC)
From:   Craig H Maynard <chmaynard@me.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Date:   Tue, 11 Aug 2020 20:28:55 -0400
Subject: git reflog --date
Message-Id: <730B4EB4-AA72-4097-9487-D6B8623BB8E5@me.com>
To:     Junio C Hamano <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=712 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2008120001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

I'm using git version 2.28.0. I don't see any mention of this 'git =
reflog' option in the online Git docs:

git reflog --date=3Diso

Any I missing something?=20

Thanks,
Craig

--
Craig H Maynard
Rhode Island, USA
(401) 413-2376

