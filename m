From: mmr15@case.edu
Subject: [PATCH 3/3] Add documentation for new diffstat config options
Date: Tue,  7 Dec 2010 21:44:23 -0500
Message-ID: <1291776263-16320-3-git-send-email-matthew.ruffalo@case.edu>
References: <7vzksr280s.fsf@alter.siamese.dyndns.org>
 <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
Cc: Matthew Ruffalo <matthew.ruffalo@case.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 03:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQA1T-0000Vr-1j
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab0LHCop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:44:45 -0500
Received: from mpv1.tis.cwru.edu ([129.22.105.36]:4905 "EHLO mpv1.tis.cwru.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab0LHCoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:44:44 -0500
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv1.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id BET33365
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:42 -0500
Received: from mail-vw0-f54.google.com (mail-vw0-f54.google.com [209.85.212.54])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OZJ24178
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:42 -0500
Received: by mail-vw0-f54.google.com with SMTP id 9so505254vws.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 18:44:42 -0800 (PST)
Received: by 10.220.83.196 with SMTP id g4mr1929017vcl.247.1291776282293;
        Tue, 07 Dec 2010 18:44:42 -0800 (PST)
Received: from mmr15-box.discordia.local (cpe-184-56-199-68.neo.res.rr.com [184.56.199.68])
        by mx.google.com with ESMTPS id r11sm54692vbx.11.2010.12.07.18.44.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 18:44:41 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.401.g13ba73
In-Reply-To: <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
X-Junkmail-Status: score=0/49, host=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163162>

From: Matthew Ruffalo <matthew.ruffalo@case.edu>

Signed-off-by: Matthew Ruffalo <matthew.ruffalo@case.edu>
---
 Documentation/config.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad5eb5f..5cae0f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -862,6 +862,15 @@ diff.ignoreSubmodules::
 	commands such as 'git diff-files'. 'git checkout' also honors
 	this setting when reporting uncommitted changes.
 
+diffstat.width::
+	Controls the default width of 'git diff --stat' output. Can be
+	overridden with the command line option '--stat-width'.
+
+diffstat.namewidth::
+	Controls the default width of the filenames in 'git diff --stat'
+	output. Can be overridden with the command line option
+	'--stat-namewidth'.
+
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
-- 
1.7.1
