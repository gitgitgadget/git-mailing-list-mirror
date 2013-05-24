From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 19:24:40 +0200
Message-ID: <20130524172440.GC9448@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <20130523192512.GR9448@inner.h.apk.li> <519F32DC.0@ira.uka.de> <20130524134214.GA26617@inner.h.apk.li> <519F81B6.4010807@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 24 19:25:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfvkR-0003wb-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab3EXRZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:25:40 -0400
Received: from continuum.iocl.org ([217.140.74.2]:41320 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210Ab3EXRZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:25:36 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4OHOeV02589;
	Fri, 24 May 2013 19:24:40 +0200
Content-Disposition: inline
In-Reply-To: <519F81B6.4010807@ira.uka.de>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225384>

On Fri, 24 May 2013 17:05:26 +0000, Holger Hellmuth (IKS) wrote:
> Am 24.05.2013 15:42, schrieb Andreas Krey:
...
> >The branch name is almost completely meaningless. I could just
> >do my feature in my local master and never have a different name.
> 
> In which case parent switching in the commit wouldn't help you either.

Oh, it does; I tried. Names are meaningless, the parent ordering
isn't. ( [And at least, it's already in there.]

> But even you could keep your master always on the left side of gitk if 
> you deem it special. And you could keep longer running cooperative 
> branches (the main develop and the release branch of your project for 
> example) in a seperate lane.

I need gitk (or similar) to do it. Will take some time to understand
the code (and triggers the 'I can write it (the interesting part) faster
than I can grok gitk').

...
> Without additional information about the commit history gitk can do 
> exactly what it does now.

Most definitely not. There are quite some situations where the graph
deteriorates pretty heavily, even when not expecting it to pay attention
to first parent. When you have two branches, of which one regularly
gets merge into the other, it sometimes manages to display first the
one, then the other branch, with a log of merge edges going upwards
in parallel, for example.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
