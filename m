From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 23:11:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
  <4A899495.8050902@gnu.org>  <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>  <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>  <alpine.DEB.1.00.0908172255140.8306@pacific.mpi-cbg.de>
 <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9TR-00058F-24
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097AbZHQVK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758088AbZHQVK1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:10:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:48849 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757985AbZHQVK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:10:27 -0400
Received: (qmail invoked by alias); 17 Aug 2009 21:10:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 17 Aug 2009 23:10:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196jCoDPj56VCBi0RGEOuwW0g8fsr9oxhHWL19hHL
	abLDrFejlFVkcK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126286>

Hi,

On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:

> On Mon, Aug 17, 2009 at 10:56 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > The problem is that this will bitrot even more, as nobody will use it 
> > for gcc, Borland C++, XCode, Eclipse or anything else, except for 
> > Microsoft Visual C++.
> 
> How do you know? Also, please note I'm not talking about *adding* a 
> CMake build system, I'm talking about *replacing* the existing autotools 
> build system with a CMake build system, even if they coexist for some 
> time.

You are mistaken.  We do not require using the autotools.  I _never_ call 
"./configure" yet the Makefile magically works.  Cool, huh?

But here's a clue: you will probably _never_ succeed in getting a 
replacement of the make-based build in git.git by the maintainer.  Make is 
just too ubiquitous and well-established for that.

Having said that, a CMake-based system _in addition_ to what is 
tried-and-tested to be able to support all those different kinds of 
Microsoft Visual Studio (took me 3 attempts to write that without a 
Freudian) would be welcome, _if_ you succeed in making it compile out of 
the box on msysGit.

By out-of-the-box I mean: you send a patch that adds 
/src/cmake/release.sh, I apply the patch (after briefly scanning that it 
does not install a backdoor on a machine that is not even mine, and 
therefore will never see even a single of my passwords typed in), run it, 
it compiles installs and commits cmake and cmake works.

If that's not possible, I refuse to add another problem rather than 
solving one.

If you succeed, I will ask you to do the same for Python, as you clearly 
proved by that point that you are a magician.

Ciao,
Dscho
