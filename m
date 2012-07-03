From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/3] gitweb changes
Date: Tue,  3 Jul 2012 15:02:54 +0900
Message-ID: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlwGo-0000gf-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 08:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523Ab2GCGHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 02:07:08 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:47075 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab2GCGHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 02:07:07 -0400
X-AuditID: 9c93016f-b7bccae00000345c-a0-4ff28c09c173
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id 77.88.13404.A0C82FF4; Tue,  3 Jul 2012 15:07:06 +0900 (KST)
X-Mailer: git-send-email 1.7.10.2
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200901>

Hi,

This is a small gitweb patchset to address a few issues
when dealt with the tip tree in Linux kernel.

NOTE: I'm not familiar with the code base and even the
perl language itself. Please kindly let me know if I did
something (horribly) wrong. :)

Thanks,
Namhyung


Namhyung Kim (3):
  gitweb: Get rid of unnecessary check of $signoff
  gitweb: Handle a few other tags in git_print_log
  gitweb: Add support to Link: tag

 gitweb/gitweb.perl |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
1.7.10.2
