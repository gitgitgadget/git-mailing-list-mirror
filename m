From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of 
 function
Date: Wed, 19 Aug 2009 12:15:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908191158310.5594@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>  <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com> 
 <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>  <4A8A3ADE.9010703@gmail.com>  <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302> <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 12:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdiCt-0005SS-KG
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 12:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZHSKPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 06:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZHSKPn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 06:15:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:46950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751001AbZHSKPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 06:15:43 -0400
Received: (qmail invoked by alias); 19 Aug 2009 10:15:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 19 Aug 2009 12:15:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MsaRHhRHM/UTOqNW/BKx07Y7wWKf9nPCUq7v5Ro
	NbsmEW9Ctzl/0Z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126531>



On Wed, 19 Aug 2009, Frank Li wrote:

> > Okay, I will wait for Frank's updates (just fetched tgit.git and it still
> > contains the old branch), merge the early part and add the compiler flags.
> >
> Today, I just update 5 patch according review feedback.
> Do I need send it again?
> 
> I have push my change to tgit
> git://repo.or.cz/tgit.git
> branch vcpatch2
> 
> How do I know if patch has been applied main line?

I applied them to 4msysgit.git's devel.  Note that I had a strange merge 
conflict in pager.c: you replaced and #ifndef __MINGW32__ with an #ifndef 
WIN32, but I don't have that #ifndef at all.

Ciao,
Dscho
