From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] Small "git interpret-trailers" fixes
Date: Fri, 07 Nov 2014 19:50:47 +0100
Message-ID: <20141107184148.16854.63825.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmodL-0006PK-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbaKGSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:51:28 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:49641 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbaKGSv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:51:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id B87BC45;
	Fri,  7 Nov 2014 19:51:24 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a series to fix a few small bugs in "git interpret-trailers".

Patch 1/5 and patch 2/5 are independent from the last 3 patches,
and can be applied to master.

Patches 3/5, 4/5 and 5/5 depend on this series by Junio:

	jc/conflict-hint (2014-10-28) 4 commits
	  (merged to 'next' on 2014-10-29 at 693250f)

Christian Couder (5):
  trailer: ignore comment lines inside the trailers
  trailer: display a trailer without its trailing newline
  commit: make ignore_non_trailer() non static
  trailer: reuse ignore_non_trailer() to ignore conflict lines
  trailer: add test with an old style conflict block

 builtin/commit.c              | 46 -------------------------------------------
 commit.c                      | 46 +++++++++++++++++++++++++++++++++++++++++++
 commit.h                      |  3 +++
 t/t7513-interpret-trailers.sh | 34 +++++++++++++++++++++++++++++++-
 trailer.c                     | 39 +++++++++++++++++++++++++-----------
 5 files changed, 110 insertions(+), 58 deletions(-)

-- 
2.1.2.555.gfbecd99
