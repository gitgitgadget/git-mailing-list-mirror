From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysGit and SCons: broken?
Date: Tue, 4 Aug 2009 00:13:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de>
References: <4A772A43.8070503@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1099217918-1249337617=:8306"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5mX-0007LN-A6
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZHCWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZHCWNQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:13:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:38698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbZHCWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 18:13:15 -0400
Received: (qmail invoked by alias); 03 Aug 2009 22:13:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 04 Aug 2009 00:13:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18z/y8YVg0z00fyto4apjzaq70whY08er3LbeeLA8
	mnjuPLnB8s6EyQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A772A43.8070503@dirk.my1.cc>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124728>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1099217918-1249337617=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 3 Aug 2009, Dirk Süsserott wrote:

> I'm using Git for Windows (1.6.3.2.1299.gee46c)

I suspect the appropriate mailing list would have been the msysGit list, 
then.

> and *used to use* SCons as a build tool. Since my last Git-update (from 
> 1.6.1.9.g97c34 to 1.6.3.2.1299.gee46c) SCons doesn't work an longer.

We do not have any SCons (or Python) support in msysGit.  If you want it 
officially supported, I invite you to provide patches to compile and 
install Python (see the recent work on Perl and Subversion).

> I'm not exactly sure that the Git upgrade made things worse, but I 
> didn't upgrade neither SCons (0.98) nor Python (ActivePython 2.4) and 
> now they cease to work.
> 
> When running in git-bash, SCons tells me "TypeError: listdir() argument 
> 1 must be (buffer overflow), not str:" and some stack trace.
> 
> When running in native Windows' cmd.exe it works fine.
> 
> Is it somehow possible that the Git upgrade broke python scripts? By 
> setting certain ENV vars or something? I don't want to blame someone for 
> this, really, I'm just trying to track down my problem.

How does your SCons call relate to Git?  Do you call it from the Git Bash?  
Do you call it from cmd.exe directly?  Is Git/bash in your PATH?

Ciao,
Dscho

--8323328-1099217918-1249337617=:8306--
