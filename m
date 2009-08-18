From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 23:53:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com> <4A8AED8B.9080604@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWbn-0006xR-E3
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbZHRVwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZHRVwh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:52:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:48676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751195AbZHRVwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:52:37 -0400
Received: (qmail invoked by alias); 18 Aug 2009 21:52:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 18 Aug 2009 23:52:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lu6AmiNJl82dxw1kgAMDUsHWff8tyErfUGLZDru
	xj3JuX8Ps3isxb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A8AED8B.9080604@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126470>

Hi,

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

> Johan 't Hart said the following on 18.08.2009 19:41:
> > Junio C Hamano schreef:
> > > Since use of make implies use of shell, this makes me wonder if it
> > > would make sense to go one step further by giving msvc users a thin
> > > shell wrapper mcvc-cc that turns bog-standard cc command line into
> > > whatever cl uses.
> > 
> > Just using the msvc toolchain for building git misses the whole
> > purpose of what VC is used for. MSVC would be used because of the
> > IDE, not for the compiler IMO.
> 
> Bull. MSVC produces superior code on Windows compared to MinGW, I'm afraid.
> Add the /LTGC (Link Time Code Generation), and MSVC generates very good cross
> compile-unit optimized code. (I know gcc has the option, but it's not as good,
> by far)
> Coupled now with built-in static code analysis, these are only two reasons why
> *I* would want to build it directly from the command line without worrying
> that my .vcproj is out-of-sync with the main development.
> You can still debug with the MSVC debugger if you'd like, and the MSVC IDE
> allows you to wrap Makefile project too, so you can *still* use the IDE..

Well, "you can *still* use the IDE" is a bit exaggerated, no?  At least 
unless you misunderstand "IDE" to mean "Integrated Debugging environment".

You'll lose not only the ability to follow definitions/declarations in the 
code, you'll also lose the ability to compile incrementally _while_ 
debuggin, and Visual Studio's feature to move to the next/previous compile 
error.

Ciao,
Dscho
