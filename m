From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] Improve --assume-unchanged in the git update-index man page
Date: Sat,  6 Dec 2014 15:04:29 +0000
Message-ID: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 16:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxGtn-0002Nd-Hi
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 16:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbaLFPDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 10:03:51 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:40296 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751910AbaLFPDu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 10:03:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjAeAHQag1ROl3SjPGdsb2JhbABZgwUBh12xDo8KhhwEAoETFwEBAQEBAQUBAQEBODuEXyMYgQIKGgGIUdUpkE+EPQWFWJUpi1CIEgGCKT+CcwEBAQ
X-IPAS-Result: AjAeAHQag1ROl3SjPGdsb2JhbABZgwUBh12xDo8KhhwEAoETFwEBAQEBAQUBAQEBODuEXyMYgQIKGgGIUdUpkE+EPQWFWJUpi1CIEgGCKT+CcwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,529,1413241200"; 
   d="scan'208";a="654259103"
Received: from host-78-151-116-163.as13285.net (HELO localhost) ([78.151.116.163])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 06 Dec 2014 15:03:48 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260954>

This version 2 patch squashes in Junio's comments ($gmane/260915) and tidies up
the commit message. Previous series at $gmane/260901.

In $gmane/260837 the --assume-unchanged flag was reported as buggy because
of a misunderstanding about what it is being promised.

This clarifies the current situation, rather than change the code as proposed
by Duy in $gmane/260865.

Philip Oakley (1):
  doc: make clear --assume-unchanged's user contract

 Documentation/git-update-index.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
1.9.4.msysgit.0
