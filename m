From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Sun, 21 Oct 2012 22:03:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210212138290.2695@bonsai2>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.1210171759230.3049@bonsai2> <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com> <alpine.DEB.1.00.1210171936170.3049@bonsai2>
 <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com> <CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com> <CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com> <alpine.DEB.1.00.1210181031320.3049@bonsai2>
 <CAMP44s0jgxqb8EyjCcEdzaDR6y8gqydW7X-C268NahjaXMrh6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 22:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ1kS-0004Gb-7a
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099Ab2JUUDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:03:37 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:42939 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754257Ab2JUUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:03:36 -0400
Received: (qmail invoked by alias); 21 Oct 2012 20:03:33 -0000
Received: from g228074099.adsl.alicedsl.de (EHLO bonsai2.localdomain) [92.228.74.99]
  by mail.gmx.net (mp034) with SMTP; 21 Oct 2012 22:03:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QbipYuLtQzparDr7O5NFaGkjZEqs2yuDjvYhEnc
	5MWcLTxIaLoiAF
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAMP44s0jgxqb8EyjCcEdzaDR6y8gqydW7X-C268NahjaXMrh6A@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208143>

Hi Felipe,

On Sun, 21 Oct 2012, Felipe Contreras wrote:

> On Thu, Oct 18, 2012 at 10:47 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > Without push support, remote-hg is useless to me. Without regression
> > tests proving that it is rock solid, I will not use remote-hg.
> 
> Done and done. My remote-hg now has support for pushing, all in less
> than 500 lines of code. It also manages to pass all 14 of the "extensive
> tests" of your remote-hg. Anything else?

While I think that a lot of effort was duplicated now, and while I am
still interested in less handwaving arguments than "I find the code
bloated", I will compare the performance on both hg and openjdk and if I
do not find any issues, have a look at the code, too.

That will have to wait until I am home in a bit more than a week, though.

Ciao,
Johannes

P.S.: Sverre's remote-hg does not really handle octopus merges. It is
incomplete. I had a good plan how to complete it (see the msysGit wiki
page about remote-hg) but lacked the time to implement it (the problem is
that hg does not have octopus merges, and we want things to be
bidirectional).
