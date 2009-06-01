From: Clemens Buchacher <drizzd@aon.at>
Subject: various fixes to the test library
Date: Mon,  1 Jun 2009 14:14:39 +0200
Message-ID: <1243858482-6353-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 14:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB6QC-0005S5-SN
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 14:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbZFAMPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 08:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757282AbZFAMPH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 08:15:07 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:39866 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbZFAMPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 08:15:06 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 14:15:06 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MB6Py-0001k5-Ac; Mon, 01 Jun 2009 14:15:06 +0200
X-Mailer: git-send-email 1.6.3.1.147.g637c3
X-OriginalArrivalTime: 01 Jun 2009 12:15:06.0291 (UTC) FILETIME=[996D6830:01C9E2B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120463>

If a http test failed, and the test was run with --immediate, the cleanup code
would not be executed and stale web server instance were left behind. This is
fixed by 2/3.

Clemens

[PATCH 1/3] test-lib: fail if invalid options are passed
[PATCH 2/3] test-lib: allow exit trap to be used for cleanup by tests
[PATCH 3/3] test-lib: fix http exit codes

 t/lib-httpd.sh |    6 ++++--
 t/test-lib.sh  |   23 +++++++++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)
