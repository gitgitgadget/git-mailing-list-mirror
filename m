From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Documentation: git submodule: add missing options to synopsis
Date: Sat, 01 Aug 2009 20:49:47 +0200
Message-ID: <4A748E4B.2080108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 20:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXJeX-0006Gm-NC
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 20:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbZHAStt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZHAStt
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 14:49:49 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58008 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZHASts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 14:49:48 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 465A810F393B1;
	Sat,  1 Aug 2009 20:49:48 +0200 (CEST)
Received: from [80.128.92.229] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MXJeO-0004Ha-00; Sat, 01 Aug 2009 20:49:48 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+zXuhhawdFNsul2zVFtzieNUe4D1txHjOLEasG
	3zw0a3MKga89Kja2S+L1alSFngvUHGHaX0HWvqPituLY0hpkvq
	fdwG1tVOl+ZKnYKutTQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124643>

The option --merge was missing for submodule update and --cached for
submodule summary.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-submodule.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 683ba1a..7dd73ae 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,8 +14,8 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
-	      [--reference <repository>] [--] [<path>...]
-'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
+	      [--reference <repository>] [--merge] [--] [<path>...]
+'git submodule' [--quiet] summary [--cached] [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]

-- 
1.6.4.14.g8266f
