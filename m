From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Tue, 18 Aug 2009 11:47:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181140460.4680@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
 <1976ea660908171915v62fb6c40j17f750cac9836433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2118587953-1250588866=:4680"
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLII-0002Rl-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZHRJrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZHRJrr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:47:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:33219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753244AbZHRJrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:47:46 -0400
Received: (qmail invoked by alias); 18 Aug 2009 09:47:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp043) with SMTP; 18 Aug 2009 11:47:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UQshcCQFUAmG5l0HckAPSTJxR+US2/90N6RG9Pn
	9ARKF/c84DR79w
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908171915v62fb6c40j17f750cac9836433@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126365>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2118587953-1250588866=:4680
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> >> Add unix head file, dirent.h, unistd.h  and time.h
> >
> > These are copied from somewhere.  From where?  What is the license?
> 
> It comes from msys,  which used to build msysgit.

I know.  After reading the patch.  But it would be better if everybody 
knew after reading the commit message...  _Especially_ in this 
increasingly lawsuit-defined business, it is very nice to see early that 
the files you are including here are in the public domain, and come from 
MSys.

> I really want to in .vcproj.  but the same context needs to copy
> DEBUG\RELEASE 32\64bit, libgit.vcproj and git.vcproj. 8 place needs
> copy.  To avoid copy in vcproj file, I move it hear.

As I said earlier, there are common flags, but as I also said, it is 
probably better to keep the #define's in a header file for better 
visibility and editability, albeit in logically clustered blocks (i.e. all 
the NO_* and other #define's that affect what source code is 
compiled, all default paths in another cluster, #define's to bow before 
Microsoft's C runtime's decision to deprecate the C99 standard function 
names, etc)

BTW it is funny that your typos seem to be influenced by the _sound_ of 
the word ("hear" instead of "here"), rather than just simple transposed 
letters... most of my typos are the same ;-)

Ciao,
Dscho

--8323329-2118587953-1250588866=:4680--
