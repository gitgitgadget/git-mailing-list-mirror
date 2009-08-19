From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 10:29:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
  <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
 <4A8BA9EC.9000006@storm-olsen.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgXs-00027w-5o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbZHSI3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZHSI3Q
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:29:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:48153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbZHSI3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 04:29:15 -0400
Received: (qmail invoked by alias); 19 Aug 2009 08:29:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp041) with SMTP; 19 Aug 2009 10:29:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AaEletvnAPFUTFB5qutauUDhJ1sBeUJuZdMMdFR
	WNMNA/0S3Jl3Wr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8BA9EC.9000006@storm-olsen.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126519>

Hi,

On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:

> The full IDE support is secondary, first because you *can* use the IDE 
> already, and second because it'll be harder to whip something up which 
> guarantees that the vcproj support stays in-sync at all times and won't 
> lag behind.

I think the point of Frank's patches is to make Visual Studio users 
comfortable with Git.  You cannot ask those to use a build process or an 
IDE they are not used to.

> Of course, if someone has a huge itch to restructure the current 
> Makefile; factoring out the files into a file which can simply be 
> included in the current Makefile, and easily parsed by a script, or 
> included by CMake, then that can be done in parallel and possible added 
> to git mainline before the MSVC support patches from Frank.

I still think it would be possible to use a combination of a 
Makefile rule and GNU make features to spit out a list of targets and 
their dependet .h and .c files.

Ciao,
Dscho
