From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Git release notes man page
Date: Sat, 15 Feb 2014 10:29:38 +0000
Message-ID: <1392460179-776-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=Stefan Nwe <stefan.naewe@atlas-elektronik.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 11:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEcVD-0005f6-JX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 11:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaBOK3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 05:29:33 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:26158 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbaBOK3c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 05:29:32 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnIGABhA/1JZ8YjN/2dsb2JhbABZgwYBuR+HKoENF3SCXgEjIxiBAiSIHMIBhwKPAYI2D4F6BKpPgy08
X-IPAS-Result: AnIGABhA/1JZ8YjN/2dsb2JhbABZgwYBuR+HKoENF3SCXgEjIxiBAiSIHMIBhwKPAYI2D4F6BKpPgy08
X-IronPort-AV: E=Sophos;i="4.95,850,1384300800"; 
   d="scan'208";a="454306119"
Received: from host-89-241-136-205.as13285.net (HELO localhost) ([89.241.136.205])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 15 Feb 2014 10:29:30 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242185>

A few days too late for the 1.9.0 release cycle :(

This responds to Stefan N=E4we's request for a 'git help' command that =
would
access the release notes. ($gmane/240595 17 Jan 2014).

I've used the full name "release-notes" for the help guide rather than
Stefan's original 'git help relnotes'.

The release-notes man page lists just the notes for the current release=
=2E
The combined notes for all releases is nearing 15k lines.

The one formatting niggle is that the included text is column shifted
such that the the raw text now starts at col 12 for the man page and
reaches past col 80. Is there an attribute setting to not indent the
included block text within a man page? It looks fine in --web format.

I used the code.google link, rather than kernel.org, for the previous
release notes to match the link currently used in git(1).

Philip Oakley (1):
  Provide a release-notes man page / guide

 Documentation/Makefile             |  1 +
 Documentation/gitrelease-notes.txt | 37 ++++++++++++++++++++++++++++++=
+++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/gitrelease-notes.txt

--=20
1.8.3.msysgit.0
