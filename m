From: Matthew Ruffalo <mmr15@case.edu>
Subject: [PATCH/RFC 3/3] Add documentation for new diffstat config options
Date: Sun, 28 Nov 2010 18:52:03 -0500
Message-ID: <4CF2EB23.7040206@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 00:56:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMr6Z-00026X-Hp
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 00:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab0K1X4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 18:56:22 -0500
Received: from mpv2.tis.CWRU.Edu ([129.22.105.37]:30579 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab0K1X4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 18:56:22 -0500
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv2.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id ATF11095
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:52:11 -0500
Received: from mail-qw0-f54.google.com (mail-qw0-f54.google.com [209.85.216.54])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OUP46045
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:52:05 -0500
Received: by mail-qw0-f54.google.com with SMTP id 8so2966389qwg.13
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 15:52:05 -0800 (PST)
Received: by 10.224.2.212 with SMTP id 20mr4604850qak.302.1290988325319;
        Sun, 28 Nov 2010 15:52:05 -0800 (PST)
Received: from [10.0.8.11] (cpe-184-56-209-12.neo.res.rr.com [184.56.209.12])
        by mx.google.com with ESMTPS id x9sm2781272qco.22.2010.11.28.15.52.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 15:52:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162368>

>From 5b50cfe9095bd0d0b8dab976f5f88bebced942d1 Mon Sep 17 00:00:00 2001
From: Matthew Ruffalo <matthew.ruffalo@case.edu>
Date: Sun, 28 Nov 2010 18:11:20 -0500
Subject: [PATCH 3/3] Add documentation for new diffstat config options

Signed-off-by: Matthew Ruffalo <matthew.ruffalo@case.edu>
---
 Documentation/config.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a6c0b5..148487e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -849,6 +849,15 @@ diff.ignoreSubmodules::
        commands such as 'git diff-files'. 'git checkout' also honors
        this setting when reporting uncommitted changes.
 
+diff.stat.width::
+       Controls the default width of 'git diff --stat' output. Can be
+       overridden with the command line option '--stat-width'.
+
+diff.stat.namewidth::
+       Controls the default width of the filenames in 'git diff --stat'
+       output. Can be overridden with the command line option
+       '--stat-namewidth'.
+
 diff.suppressBlankEmpty::
        A boolean to inhibit the standard behavior of printing a space
        before each empty output line. Defaults to false.
-- 
1.7.1
