From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Wed, 19 Aug 2009 14:56:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908191455140.5594@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
 <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302> <4A8BA9EC.9000006@storm-olsen.com>
 <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302> <4A8BDAF6.5060805@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdkia-0004XT-Gp
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZHSM4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZHSM4f
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:56:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:36762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751774AbZHSM4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:56:34 -0400
Received: (qmail invoked by alias); 19 Aug 2009 12:56:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 19 Aug 2009 14:56:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196Sv9Tyel6gnHDTHeetKmTY/jqc07jhFUx/K/nie
	bmFhdRgVrRHS1z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8BDAF6.5060805@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126541>

Hi,

On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 19.08.2009 10:29:
> > Hi,
> > 
> > On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:
> > 
> > > The full IDE support is secondary, first because you *can* use the 
> > > IDE already, and second because it'll be harder to whip something up 
> > > which guarantees that the vcproj support stays in-sync at all times 
> > > and won't lag behind.
> > 
> > I think the point of Frank's patches is to make Visual Studio users 
> > comfortable with Git.  You cannot ask those to use a build process or 
> > an IDE they are not used to.
> > 
> > > Of course, if someone has a huge itch to restructure the current 
> > > Makefile; factoring out the files into a file which can simply be 
> > > included in the current Makefile, and easily parsed by a script, or 
> > > included by CMake, then that can be done in parallel and possible 
> > > added to git mainline before the MSVC support patches from Frank.
> > 
> > I still think it would be possible to use a combination of a Makefile 
> > rule and GNU make features to spit out a list of targets and their 
> > dependet .h and .c files.
> 
> Ok, but you would still have to rely on GNU Make in this setup, and it 
> would have to generate the common_cmds.h before you can even compile 
> with the MSVC IDE.

But then I could bundle it up and give it to a Visual Studio user and they 
do not need msysGit.

But maybe we should require them to have msysGit?  After all, if the 
package is too small, no Windows developer will take it seriously, right? 
;-)

Ciao,
Dscho
