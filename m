Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69CC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF07620791
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="CCPA9Pdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgFZQX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:23:58 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:44280 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgFZQX6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jun 2020 12:23:58 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 12:23:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1593188284; bh=RS5jqP0ewDgqz+gBIdUQ0XqgegQxMXFweeLqd+Sh28c=;
        h=From:Content-Type:Date:Subject:Message-Id:To;
        b=CCPA9Pdw6QxJyqO2mBvzqkgBTl+TTDuPnqAkcy+uAulPdyw5vHaag6zRLZyMmxIHQ
         FnuVAEKKuaJ4QCdNX7xkZnfKzyzpnX8VCgiuRsdi7P1MoHS4OUoT/nETveZDq+2Gbx
         QVKhxXDW5dOG1k40kuUhKR4nHxY37j32ILPPxe2tNDXE03tFQ62jGPuMfiLkDaoAHm
         LqIFFp5gpa4KA5giNUjU7YR0K/I61vAS1jrgSqKsg29zKhEAUIkWI2GvrUmiFqsZoK
         PyI3NGYqfKt2OofMmJHwusZdoBCJXXka4ugwlyu/wnuVzuqircJchl56hX5xQp2TjA
         wdROd4BIAgf9Q==
Received: from [10.0.1.6] (pool-72-92-234-38.prvdri.fios.verizon.net [72.92.234.38])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id 314A870110A;
        Fri, 26 Jun 2020 16:18:04 +0000 (UTC)
From:   Craig H Maynard <chmaynard@me.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Date:   Fri, 26 Jun 2020 12:18:03 -0400
Subject: Re: Regarding Git and Branch Naming
Message-Id: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2006260114
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

Does the git init command really need to create a default branch? =
Perhaps that step could be left to the user.

Craig

--
Craig H Maynard
Rhode Island, USA

