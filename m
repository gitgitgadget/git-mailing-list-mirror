From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD in
 tests
Date: Tue, 11 Jan 2011 08:44:30 +0100
Message-ID: <4D2C0A5E.7090708@viscovery.net>
References: <201012302205.13728.j6t@kdbg.org> <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino> <201012312321.31294.j6t@kdbg.org> <7v62u8hz01.fsf@alter.siamese.dyndns.org> <4D2C09D7.3070700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 08:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcYuE-0001le-G7
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 08:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab1AKHoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 02:44:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16806 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753022Ab1AKHoc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 02:44:32 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PcYu7-0005fw-6y; Tue, 11 Jan 2011 08:44:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EC05D1660F;
	Tue, 11 Jan 2011 08:44:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D2C09D7.3070700@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164916>

From: Johannes Sixt <j6t@kdbg.org>

This adds just a "do it this way" instruction without a lot of explanation,
because the details are too complex to be explained at this point.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/README |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 90718b4..f98ebb3 100644
--- a/t/README
+++ b/t/README
@@ -283,6 +283,12 @@ Do:
    Tests that are likely to smoke out future regressions are better
    than tests that just inflate the coverage metrics.
 
+ - When a test checks for an absolute path that a git command generated,
+   construct the expected value using $(pwd) rather than $PWD,
+   $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
+   Windows, where the shell (MSYS bash) mangles absolute path names.
+   For details, see the commit message of 4114156ae9.
+
 Don't:
 
  - exit() within a <script> part.
-- 
1.7.4.rc1.1258.g84aa
