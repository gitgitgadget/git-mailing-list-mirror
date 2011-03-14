From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/3] Fix some errors reported by valgrind
Date: Mon, 14 Mar 2011 20:18:35 +0100
Message-ID: <1300130318-11279-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 20:28:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDRm-0004Lj-0Z
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab1CNT2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 15:28:46 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51617 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab1CNT2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:28:45 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 15:28:45 EDT
Received: from bee.lab.cmartin.tk (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 67CCE460FD;
	Mon, 14 Mar 2011 20:18:48 +0100 (CET)
Received: (nullmailer pid 11309 invoked by uid 1000);
	Mon, 14 Mar 2011 19:18:38 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169012>

This patch series fixes some errors I found when running the test
suite with --valgrind.

Carlos Mart=C3=ADn Nieto (3):
  make_absolute_path: Don't try to copy a string to itself
  setup_path(): Free temporary buffer
  clone: Free a few paths

 abspath.c       |    2 +-
 builtin/clone.c |    9 ++++++---
 exec_cmd.c      |    9 ++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

--=20
1.7.4.1
