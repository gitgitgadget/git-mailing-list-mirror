From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 0/4] diff --cc: relax path filtering
Date: Fri,  3 Apr 2015 18:58:32 +0300
Message-ID: <1428076716-4449-1-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:00:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye40r-0008Pe-TR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbbDCP6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 11:58:35 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:46628
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752853AbbDCP6c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 11:58:32 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id BTyS1q0045B68XE01TyW2c; Fri, 03 Apr 2015 08:58:31 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428006853-21212-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266711>

Fixes:
* test renamed and commit message rewritten, so that
  it mentions 3-parent merge rather than other uses
* test: fix && chaining and do at new line
* use postincrement in C code

Max Kirillov (4):
  t4059: test 'diff --cc' with a change from only few parents
  combine-diff.c: refactor: extract insert_path()
  diff --cc: relax too strict paths picking
  t4059: rewrite to be adaptive to hunk filtering

 combine-diff.c                                    |  95 +++++++++------
 t/t4059-diff-cc-not-affected-by-path-filtering.sh | 142 ++++++++++++++++++++++
 2 files changed, 203 insertions(+), 34 deletions(-)
 create mode 100755 t/t4059-diff-cc-not-affected-by-path-filtering.sh

-- 
2.3.4.2801.g3d0809b
