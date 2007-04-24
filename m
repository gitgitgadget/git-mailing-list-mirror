From: "Ron Parker" <ron.parker@mobot.org>
Subject: [PATCH] Unset CDPATH in the test library
Date: Tue, 24 Apr 2007 14:01:00 -0500
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D496D3@MBGMail01.mobot.org>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org><7vvefmeqs6.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk><7vvefmdab8.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0704232351530.8430@beast.quantumfyre.co.uk><769697AE3E25EF4FBC0763CD91AB1B0201D496D1@MBGMail01.mobot.org> <7vejm97lsi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgQGB-0007ML-9t
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 21:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXDXTBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 15:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbXDXTBD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 15:01:03 -0400
Received: from mbgmail01.mobot.org ([63.78.97.14]:37207 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbXDXTBB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 15:01:01 -0400
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <7vejm97lsi.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Unset CDPATH in the test library
Thread-Index: AceGkaDK5Y+U8VDzTJyOLL0hJOkIJAAD7CpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45485>


Signed-off-by: Ron Parker <ron.parker@mobot.org>
---

	Junio,

	Your suggestion of unsetting CDPATH in
	t/test-lib.sh took care of the problem.

	Thanks.

 t/test-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c075474..8b99a76 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -11,6 +11,7 @@ TZ=UTC
 export LANG LC_ALL PAGER TZ
 EDITOR=:
 VISUAL=:
+unset CDPATH
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME
-- 
1.5.0.5
