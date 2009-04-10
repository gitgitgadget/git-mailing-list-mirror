From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
 index)
Date: Fri, 10 Apr 2009 20:10:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>  <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>  <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
 <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-544917050-1239387036=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLAU-0002mP-Ct
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763771AbZDJSIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760084AbZDJSH7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:07:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:38535 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756300AbZDJSH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:07:58 -0400
Received: (qmail invoked by alias); 10 Apr 2009 18:07:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 10 Apr 2009 20:07:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uffY2C3wu6SRtGyTucrglv56ixlCquC4zaakhzS
	L/IisT35ULR1Ah
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116269>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-544917050-1239387036=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 10 Apr 2009, Ping Yin wrote:

> On Thu, Apr 9, 2009 at 10:00 AM, Ping Yin <pkufranky@gmail.com> wrote:
> > On Thu, Apr 9, 2009 at 5:30 AM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> >> With "git add -e [<files>]", Git will fire up an editor with the current
> >> diff relative to the index (i.e. what you would get with "git diff
> >> [<files>]").
> >>
> >> Now you can edit the patch as much as you like, including adding/removing
> >> lines, editing the text, whatever.  Make sure, though, that the first
> >> character of the hunk lines is still a space, a plus or a minus.
> >>
> >> After you closed the editor, Git will adjust the line counts of the hunks
> >> if necessary, thanks to the --recount option of apply, and commit the
> >> patch.  Except if you deleted everything, in which case nothing happens
> >> (for obvious reasons).
> >>
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> ---
> >>
> >>        I actually promised myself not to resend this patch, but a
> >>        certain guy who has a hat now asked for it.
> >>
> >
> > I am that guy :-). Thanks. Sometimes "add -e" is more useful than "add
> > -p" since i can see the full context when editing the patch. However,
> > sometimes the ability to edit the index directly is even more useful.
> > For example, if it's a big change (or rewritten), it is hard to edit
> > the patch instead of the index (in diff mode with the worktree file
> > side by side). I even encounter a case that i can't beat the patch
> > into a shape i want when using 'add -p'  ( it will fail to apply)
> >
> 
> How about this?
>  'add --edit=patch' to edit the patch and "add --edit=index" to edit the index

As others have mentioned, there _is_ a reason we have a working directory.  
Please understand this as a "I do not like the idea of editing the index 
directly at all".

Ciao,
Dscho

--8323328-544917050-1239387036=:10279--
