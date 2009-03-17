From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: push.default, was Re: What's cooking in git.git (Mar 2009, #04;
 Sat, 14)
Date: Tue, 17 Mar 2009 23:53:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903172350270.10279@pacific.mpi-cbg.de>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302> <20090318063053.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjiAC-0002bK-PN
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 23:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZCQWvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 18:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZCQWvs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 18:51:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:60111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbZCQWvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 18:51:47 -0400
Received: (qmail invoked by alias); 17 Mar 2009 22:51:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 17 Mar 2009 23:51:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bkW5HX3/bLTr0hb1yOgDr2dF6F7LDF0OPloVKjO
	RqJUt8vC+GjCH2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090318063053.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113533>

Hi,

On Wed, 18 Mar 2009, Nanako Shiraishi wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > On Sat, 14 Mar 2009, Junio C Hamano wrote:
> >
> >> * fg/push-default (Wed Mar 11 23:01:45 2009 +0100) 1 commit
> >>  - New config push.default to decide default behavior for push
> >> 
> >> Replaced the old series with the first step to allow a smooth 
> >> transition. Some might argue that this should not give any warning 
> >> but just give users this new configuration to play with first, and 
> >> after we know we are going to switch default some day, start the 
> >> warning.
> >
> > IIRC Steffen posted a patch series earlier, where he initialized 
> > remote.origin.push upon clone (I am not sure if he provided a 
> > corresponding patch for checkout --track), but personally, I think 
> > that would be nicer than having a push.default.
> 
> Isn't recent trend to avoid such inconsistency between behavior in an 
> existing repository and behavior in a newly created repository? For 
> example, Jeff calls such inconsistency in
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/100339/focus=100433
> 
> as "this breaks in my repo, but when I make a test repo it works". Junio 
> even called it 'madness' (^_^;)

My point is that it is _not_ an inconsistency.

It has a default setting.  One that already is well established.  Push the 
matching refs.

But you can override it by setting the config variable.  Which is also 
well established.

The only thing Steffen's patches would have changed would be to set the 
default differently now.

Which is not that much of a 'madness'.

Especially if you think about changing the default, which _will_ make for 
angry users ("why did you change the default?  I _liked_ it!  Please 
revert _now_!").

Ciao,
Dscho
