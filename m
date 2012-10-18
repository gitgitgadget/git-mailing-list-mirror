From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:13:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210181112050.3049@bonsai2>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com> <20121017225913.GC21742@sigill.intra.peff.net> <CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com> <CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
 <CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com> <CAMP44s3+FP2N4iEmxzcu_ayUAF+XWmKdBFDCvFvj6D5RQmN+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmHX-0003qc-II
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2JRJUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:20:36 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43426 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753740Ab2JRJUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:20:35 -0400
Received: (qmail invoked by alias); 18 Oct 2012 09:13:57 -0000
Received: from unknown (EHLO bonsai2) [2.215.133.187]
  by mail.gmx.net (mp030) with SMTP; 18 Oct 2012 11:13:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8SQpD+Df8uYZo6VRtlpPGChcZ+gvJnfgv0IeVlm
	dMiM1sFOc04GXV
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAMP44s3+FP2N4iEmxzcu_ayUAF+XWmKdBFDCvFvj6D5RQmN+5Q@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207985>

Hi,

On Thu, 18 Oct 2012, Felipe Contreras wrote:

> On Thu, Oct 18, 2012 at 8:12 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > On Wed, Oct 17, 2012 at 10:18 PM, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >> Right now I've just added an error when using remote repositories.
> >> But it seems there's no way around it; if we want to have support for
> >> remote repos, we need to make a local clone.
> >
> > My git-remote-hg does the local clone into .git/ using a hash of the
> > url (although you could just as well use urlencode, basically any way
> > to safely use a url as a directory name). Have a look if you want.
> 
> Can you point to the version you are talking about? I've been checking
> the remote-hg branch of fingolfin.
> 
> https://github.com/fingolfin/git/tree/remote-hg/

The code is in https://github.com/msysgit/git/ (Sverre does not have
enough time to work on remote-hg, and was okay with me hosting it in Git
for Windows, for all the reasons I mentioned earlier in this thread).

Hth,
Johannes
