From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/5] A few minor MinGW changes
Date: Sat, 23 May 2009 10:04:46 +0200
Message-ID: <1243065891-13270-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mcI-000525-Uu
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbZEWI36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbZEWI35
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:29:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZEWI34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:29:56 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84vL9001291;
	Sat, 23 May 2009 10:05:07 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pOJ028553;
	Sat, 23 May 2009 10:04:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119761>

Here are a few simple commits that are included in the msysgit
release but not in git.git.

        Steffen

Johannes Schindelin (4):
  MinGW: the path separator to split GITPERLLIB is ';' on Win32
  MinGW: use POSIX signature of waitpid()
  MinGW: Add a simple getpass()
  MinGW: Fix compiler warning in merge-recursive

Peter Harris (1):
  MinGW: Scan for \r in addition to \n when reading shbang lines

 Makefile                  |    4 +++-
 builtin-merge-recursive.c |    5 +++--
 compat/mingw.c            |   19 +++++++++++++++++--
 compat/mingw.h            |    4 +++-
 4 files changed, 26 insertions(+), 6 deletions(-)
