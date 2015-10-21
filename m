From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Wed, 21 Oct 2015 07:08:00 +0300
Message-ID: <1445400482-1977-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zokof-0005tw-RX
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 06:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbbJUEPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 00:15:24 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:60924
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698AbbJUEPX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 00:15:23 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2015 00:15:23 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id Xg861r0045B68XE01g8Ci7; Tue, 20 Oct 2015 21:08:14 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279962>

This enables --reverse --first-parent back.

Max Kirillov (2):
  Add test to describe expectation of blame --reverse with branched
    history
  blame: allow blame --reverse --first-parent when it makes sense

 builtin/blame.c          | 11 +++++++++--
 t/t8009-blame-reverse.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100755 t/t8009-blame-reverse.sh

-- 
2.3.4.2801.g3d0809b
