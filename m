From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Improve cover letter shortlog generation
Date: Mon, 25 Feb 2008 18:24:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251821440.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmh4-0005qy-02
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbYBYXYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYBYXYM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:24:12 -0500
Received: from iabervon.org ([66.92.72.58]:59580 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056AbYBYXYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:24:11 -0500
Received: (qmail 21575 invoked by uid 1000); 25 Feb 2008 23:24:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 23:24:10 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75087>

This is a somewhat gratuitous cover letter, which I'm mainly including
because I did this with "./git format-patch --stdout --cover-letter -n -2".
I also just tried -4, and correctly got a shortlog (including a patch
out of next) and no diffstat (because the tip of next is a merge, and so 
there were two boundary commits).

Daniel Barkalow (2):
      Add API access to shortlog
      Improve collection of information for format-patch --cover-letter

 builtin-log.c      |   49 +++++++++--------
 builtin-shortlog.c |  149 ++++++++++++++++++++++++++++------------------------
 shortlog.h         |   26 +++++++++
 3 files changed, 132 insertions(+), 92 deletions(-)
 create mode 100644 shortlog.h
