Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A60C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B2720714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="U9HE+OHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVNS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:18:29 -0500
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:51161 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbfKVNS3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Nov 2019 08:18:29 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 08:18:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1574428369; bh=HjsH4/yjlOOSEY825MLMERqvFJkYZE+7ExgH0m1vjN8=;
        h=From:Content-Type:Date:Subject:Message-Id:To;
        b=U9HE+OHjqKZZag4Mn0xTnc2EjUDbrL5rJQzGuPL0pIwxofLtao3zLB/EyumdEkBI1
         cvYegK2IyADxh+dxvrami4AAUlbtRVp46GPAwgRcCtNhW2jI6On0hk2ubOSXIbuI7l
         5w9L/bAiviwOr3LvgXxDxew3gPQKZeqBWDYogKXKsMbsi+z0w81tVk8WNn8gdUkjez
         tVbXprHaT7aL4KGZ/+odmRsEpr5QGB2Opy4jQt4A3FPyT6O9IuGyMguHeCSluqe9I0
         Ko2/rZNpqUYh5eiSwdpq6qY5LrGZ33vQxeWodR9D8ew4+2Y0aSiYTwTPnQO9YAqSzv
         1wvlhQ7FfwddA==
Received: from [10.0.1.6] (pool-72-92-234-38.prvdri.fios.verizon.net [72.92.234.38])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 3C3A3940E2B;
        Fri, 22 Nov 2019 13:12:49 +0000 (UTC)
From:   Craig H Maynard <chmaynard@me.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date:   Fri, 22 Nov 2019 08:12:48 -0500
Subject: Git CLI
Message-Id: <3AD06998-1729-46C2-8B60-BD405C365656@me.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=698 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911220117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just noticed this:

$ git pull
Already up to date.
$ git push
Everything up-to-date

The two messages covey the same information but use different =
punctuation and hyphenation. While not terribly important, this quirky =
inconsistency doesn't inspire confidence.

My environment:

git version 2.24.0
hub version 2.13.0

--
Craig H Maynard
Rhode Island, USA

