From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsimport gets parents wrong for branches
Date: Tue, 4 Jul 2006 13:33:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041330120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060703215303.GA24572@memak.tu-darmstadt.de>
 <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
 <Pine.LNX.4.63.0607041007391.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060704110313.GC24572@memak.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:34:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxjA4-0005ok-Ke
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWGDLdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGDLdq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:33:46 -0400
Received: from mail.gmx.de ([213.165.64.21]:54198 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932184AbWGDLdp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:33:45 -0400
Received: (qmail invoked by alias); 04 Jul 2006 11:33:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 04 Jul 2006 13:33:43 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Elrond <elrond+kernel.org@samba-tng.org>
In-Reply-To: <20060704110313.GC24572@memak.tu-darmstadt.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23288>

Hi,

On Tue, 4 Jul 2006, Elrond wrote:

> On Tue, Jul 04, 2006 at 10:09:18AM +0200, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Tue, 4 Jul 2006, Martin Langhoff wrote:
> > 
> > > It is pretty hard to get that one right in any case, as there are
> > > cases where the new branch starts from something that is not a commit
> > > in the parent (from GIT's perspective).
> > 
> > But it should be easy to introduce a faked commit, which just contains 
> > those versions (and takes the newest commit touching any of these file 
> > versions as branch point).
> 
> [...]
>
> just which parent should our new fake commit have?

That is what I tried to address with the "branch point" thing. Just take 
the newest commit (in the ancestor line) touching the file versions of 
that particular tree, or in other words, the oldest commit having at least 
these file versions.

IMHO it is dumb enough not to branch off of a commit that it does not 
matter that much what parent this faked commit has.

Ciao,
Dscho
