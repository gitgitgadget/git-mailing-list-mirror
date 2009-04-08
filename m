From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.6.2.2
Date: Wed, 8 Apr 2009 04:46:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904080440170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 04:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNms-0001rp-KK
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687AbZDHCnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbZDHCnm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:43:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751031AbZDHCnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:43:41 -0400
Received: (qmail invoked by alias); 08 Apr 2009 02:43:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 08 Apr 2009 04:43:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QxicsNtdQehIn3Qu0e5gw+7JVrLti1Lt6vDxIcV
	gL3apguOqhrfYT
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116026>

Hi,

this email tries to inform you that the Windows installer was updated to 
the newest version of Git.

Changes since Git-1.6.2.1-preview20090322

New Features

- Comes with official git 1.6.2.2.
- Upgraded Tcl/Tk to 8.5.5.
- TortoiseMerge is supported by mergetool now (Thanks Markus Heidelberg).
- Uses pthreads (faster garbage collection on multi-core machines).
- The test suite passes!

Bugfixes

- Renaming was made more robust (due to Explorer or some virus scanners, 
  files could not be renamed at the first try, so we have to try multiple 
  times).
- Johannes Sixt made lots of changes to the test-suite to identify 
  properly which tests should pass, and which ones cannot pass due to 
  limitations of the platform.
- Support PAGERs with spaces in their filename.
- Quite a few changes were undone which we needed in the olden days of 
  msysGit.
- Fall back to / when HOME cannot be set to the real home directory due to 
  locale issues (works around Issue 108 for the moment).

Ciao,
Dscho "who really needs some sleep"
