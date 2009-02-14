From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 20:12:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142011410.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141248220.10279@pacific.mpi-cbg.de> <1234621328-8998-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-395896675-1234638747=:10279"
Cc: git@vger.kernel.org, =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPwl-0007Ke-24
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZBNTLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZBNTLf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:11:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:39138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751572AbZBNTLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:11:34 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:11:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 14 Feb 2009 20:11:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Zu9AckyHZD1504S8PMy6c8MoF+iB+g4KmG9ioLV
	0icSSShr/C/ht+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234621328-8998-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109894>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-395896675-1234638747=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Sat, 14 Feb 2009, Jan Krüger wrote:
> > 
> > > Subject: [PATCH] gc: add --prune-expire option equivalent to gc.pruneExpire
> > 
> > I like it, and if nobody beats me to it, I will add a test for this 
> > option tonight.
> 
> Cool, then let's use that in the docs.

This would be needed in addition, incase that my --prune=<date> patch is 
taken:

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index d148e58..a8ad884 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -371,7 +371,7 @@ warned.
 * Expire all reflogs with `git reflog expire \--expire=now \--all`.
 
 * Garbage collect all unreferenced objects with `git gc
-  \--prune-expire=now` (or if your git-gc is not new enough to have
+  \--prune=now` (or if your git-gc is not new enough to have
   that option, `git repack -ad; git prune`).
 
 
-- 
1.6.2.rc0.367.g7f9a5

--8323328-395896675-1234638747=:10279--
