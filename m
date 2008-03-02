From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] format-patch --cover-letter improvements
Date: Sun, 2 Mar 2008 15:52:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021552210.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org> <alpine.LSU.1.00.0802291118540.22527@racer.site> <alpine.LSU.1.00.0803021511420.22527@racer.site>
 <alpine.LSU.1.00.0803021531230.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqVm-0005aU-0s
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbYCBPxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYCBPxZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:53:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:56697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753331AbYCBPxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:53:25 -0500
Received: (qmail invoked by alias); 02 Mar 2008 15:53:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp039) with SMTP; 02 Mar 2008 16:53:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19unUleLt5uKY1JuzxFia6rdxwuXjbG03zFuSbj+/
	4zcYSdVlAvcsB9
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803021531230.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75794>


This patch pair brings two improvements to the cover letter:

	- when calling format-patch with a diff option, this options
	  will be heeded by the cover-letter's diffstat, and

	- the onelines in the shortlog are wrapped around, just like
	  in Junio's "What's in ..." messages.


Johannes Schindelin (2):
  format-patch: use the diff options for the cover letter, too
  format-patch: wrap cover-letter's shortlog sensibly

 builtin-log.c                                      |    8 +++-
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    4 +-
 t/t4014-format-patch.sh                            |   37 +++++++++++++++++--
 3 files changed, 41 insertions(+), 8 deletions(-)


