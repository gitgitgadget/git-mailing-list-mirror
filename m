From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 16:11:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181610080.23902@racer.site>
References: <20071217110322.GH14889@albany.tokkee.org>
 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org>
 <Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>
 <Pine.LNX.4.64.0712181445420.23902@racer.site> <4767E07A.2020100@op5.se>
 <Pine.LNX.4.64.0712181513060.23902@racer.site> <4767E717.2060902@op5.se>
 <m3lk7sovt0.fsf@roke.D-201> <4767EFFA.1070909@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Sebastian Harl <sh@tokkee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4f3d-0004d8-11
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbXLRQMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbXLRQMA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:12:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:55019 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757071AbXLRQL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:11:59 -0500
Received: (qmail invoked by alias); 18 Dec 2007 16:11:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 18 Dec 2007 17:11:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Pg1UVUE9Py38ZLb4a5TlJlDYAEUTlchG8Qpj5dn
	9etX65Fwz8zuv1
X-X-Sender: gene099@racer.site
In-Reply-To: <4767EFFA.1070909@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68773>

Hi,

On Tue, 18 Dec 2007, Andreas Ericsson wrote:

> Jakub Narebski wrote:
>
> > Andreas Ericsson <ae@op5.se> writes:
> >
> > > My point is that it would be nice if all git commands that actually 
> > > manipulate objects (create/delete/modify) had a safe default, and 
> > > that experienced users such as yourself could endure the 
> > > insufferable agony of retraining your fingers to type five more 
> > > chars so that people won't have to get bitten by surprises.
> > 
> > Also for "git commit"?
> 
> git commit has a very safe default; It runs "git status" and exits.

Not in my universe.  It starts an editor, and then commits what I staged.

> > In my opinion _basic_ usage of git-stash is simply using it with one 
> > stash only: "git stash" / "git unstash" (i.e. "git stash apply"; by 
> > the way this is one (beside "git view") use case for builtin 
> > predefined aliases).  Using it with multiple stashes (only then "git 
> > stash list" is needed) is advanced usage; and for advanced usage 
> > longer form is preferred, I think.
> > 
> 
> Perhaps. I'll stop quibbling about it. I don't care very deeply about it 
> anyway.

Ah.  That explains why you made a case against the default operation ;-)

Ciao,
Dscho
