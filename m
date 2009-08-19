From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 09:16:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
  <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdfPj-00059z-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbZHSHQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZHSHQr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 03:16:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:53813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751022AbZHSHQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 03:16:47 -0400
Received: (qmail invoked by alias); 19 Aug 2009 07:16:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 19 Aug 2009 09:16:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vjYIciucv5ZOJ0ndGUqEVlEzgOtoSNmPpY0n9L+
	8gw9caOnDDf/cN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126510>

Hi,

On Wed, 19 Aug 2009, Erik Faye-Lund wrote:

> On Wed, Aug 19, 2009 at 12:38 AM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> >> Nope, you're still able to skip through the erros (with F4) as ususal.
> >> I've been using a sed-script to translate gcc-style errors to msvc-style
> >> errors for makefile projects before with great success. In this case,
> >> the errors are already in msvc-style, so that part should really not be
> >> any issue.
> >
> > At this point you are just piling work-around on work-around.
> 
> At what point?

At the point where you bolt on a sed script on top of a bolted-on build 
procedure.

Using a Makefile from within Visual Studio is just not the intended way to 
do things, so you will hit the limitations sooner or later.

For example when the sed script encounters a situation which was not 
anticipated by the script author.

So I think if we support Microsoft Visual C++, it should be either through 
.vcproj files, or through a procedure that creates them.

Ciao,
Dscho
