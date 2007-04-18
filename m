From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 12:05:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704181130150.12094@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He733-00053f-61
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbXDRKFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbXDRKFi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:05:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:46612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422772AbXDRKFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 06:05:36 -0400
Received: (qmail invoked by alias); 18 Apr 2007 10:05:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 18 Apr 2007 12:05:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19l9YF1WotliZ6hU6WVe3yJNzuoKGdUAh68WLTFaR
	3lYlrep57w6oWg
X-X-Sender: gene099@racer.site
In-Reply-To: <462521C7.2050103@softax.com.pl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44879>

Hi,

On Tue, 17 Apr 2007, Marcin Kasperski wrote:

> a) Windows are unsupported

Wrong.

> b) Learning curve is too steep. Unclear relationship git-vs-cogito makes it
> even worse.

Not so wrong. But then, it is clear that git is git is git. If you find it 
too complicated, soon enough somebody says "use cogito instead" and you'll 
find out about that.

> c) Lack of reasonable subproject support (plus detailed permission 
> model).

It is just being introduced into Git.

And we're back to Alex' point: if you want to make a feature a first class 
citizen, you have to invest a little energy in it. But experience shows 
that it _is_ possible to get something completely new into Git quite fast.

BTW the most striking argument pro Git I can think of is showing people 
how fast you can find out things. Like who wrote it, or more importantly 
_where_ the code is for a certain feature. Searching through `git log -p` 
is really fast, and it becomes even faster when you use "-Sblub".

And I really blew my audience away when I imported some CVS tracked 
project into Git, and showed all the features on that repository, 
_without_ much work.

I mean, you can do with CVS, SVN, HG, etc. almost the same as with Git. 
But with Git, I find it faster and easier. BTW much of that does come from 
the scriptable nature of Git. It _is_ much easier to write a short and 
simple script than to work on a plugin.

Ciao,
Dscho
