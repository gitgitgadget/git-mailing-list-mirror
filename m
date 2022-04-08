Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D615CC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 03:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiDHDhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiDHDhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 23:37:09 -0400
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA11F8914
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1649388907;
        bh=1D60aqWqFdxfzkzU0Y44q7FWksHDeWuJnDY4ZxaT9Pk=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=zoa+/S/qMZfV8SzkUBfUJ2fIn0B0wNXjgeUJfxAeOVNGzrzS/DnEN6cTxvJiA7uQ/
         cA1O//exKc36oO/4qMI4+T5dhMTqkM5G84Ipo+tLnDdih5f6vh78FhAZECmI0ibp9x
         6a8MPGYz73/Fz0uGRqA52nUPD1mgjewdu+BZteKlmlYI0183FU45sHCrB4Sc5/qQ9r
         yrNN8WQVg9XHCLoab2cED9OKBziM2/WNlMhS6wPZjAm0jWv4v76AzsTgSRAwMlhlUv
         Zux88xW5uFmzM3Le1pkYb2gQlrtrSiXF5bx4eI30wvCzb94qdMJomF6h6vv4mQ6Hnp
         ux+zsXD2ITlCA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 16A692794025
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 03:35:06 +0000 (UTC)
From:   jurgen_gjoncari@icloud.com
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.1\))
Subject: Make commit messages optional
Message-Id: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
Date:   Fri, 8 Apr 2022 05:35:04 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.100.1)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2204080018
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think that often commit messages are unnecessary. I propose that by =
default a user should be able to commit without a message.=20

I don't think this would be a problem from the UX point of view, because =
a user could get a lot of information about a change, from the history =
of the GitHub repository, such as from the time of change, and seeing =
the diff.=20

I think that making commit messages options wouldn't even be a problem =
for retro compatibility because the feature would remain still =
functional for those who would want to use it.=20=
