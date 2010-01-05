From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Wed, 6 Jan 2010 00:02:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001052357500.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 23:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSIKx-0003QN-6a
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 23:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab0AEW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 17:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755283Ab0AEW5H
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 17:57:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:58013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755277Ab0AEW5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 17:57:04 -0500
Received: (qmail invoked by alias); 05 Jan 2010 22:57:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 05 Jan 2010 23:57:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wGY1j6tHwtYZHoeoQXThCpwpNyRbGsdR3Xrgvs+
	KaX/xK5mLXhrgS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136218>

Hi,

On Tue, 5 Jan 2010, Junio C Hamano wrote:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> >> I think "clone" has a chicken-and-egg problem.  If all of your 
> >> project ... what kind of participant you are.  It has to become 
> >> two-step process; either "clone" going interactive in the middle, or 
> >> you let the clone to happen and then "submodule init" to express that 
> >> information.
> >
> > Yes, we can leave it that way for now (first "clone" and then 
> > "submodule init <the submodules you need>"). We can migrate to the 
> > "group mapping" functionality later (which would then allow to force 
> > certain submodules to always be populated because they appear in every 
> > group).
> 
> Even with group mapping, you need to clone the superproject first, before
> seeing the mapping (which I would assume comes in the superproject).

That's just like saying "you only see the URL first, and you have to clone 
before you see what the project is about".

So in effect you are saying that things are bad.  But you do not take the 
leap of imagination to say what we need to improve.

There are quite a number of settings which could benefit from git-clone -- 
finally -- learning to take more information than just the URL; autocrlf 
and submodules' "grouping" (which is a lousy name, by the way) being the 
most prominent examples (which the core Git developers very obviously do 
not use, otherwise the state of things would not be as sorry as it is).

Ciao,
Dscho
