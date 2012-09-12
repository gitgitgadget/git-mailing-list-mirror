From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 0/3] Janitor minor fixes on SHA1
Date: Wed, 12 Sep 2012 12:01:24 +0200
Message-ID: <cover.1347442430.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 12:02:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjlk-0004Uy-5R
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 12:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab2ILKBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 06:01:55 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:59124 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab2ILKBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 06:01:54 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:21d0:2ede:8970:5205])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A5B2A9401A9;
	Wed, 12 Sep 2012 12:01:45 +0200 (CEST)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id q8CA1iiC028822;
	Wed, 12 Sep 2012 12:01:44 +0200
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id q8CA1hhw028821;
	Wed, 12 Sep 2012 12:01:43 +0200
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205276>

While looking to use the git SHA1 code, I've found some small oddities.
Please find little cosmetics fixes for them.

The patches are against 'next' and can be merged in one single patch
if needed.

Yann Droneaud (3):
  sha1: update pointer and remaining length after subfunction call
  sha1: clean pointer arithmetic
  sha1: use char type for temporary work buffer

 block-sha1/sha1.c | 6 +++---
 block-sha1/sha1.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.11.4
