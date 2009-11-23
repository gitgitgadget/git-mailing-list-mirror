From: tytso@mit.edu
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What
 does that say about git?
Date: Mon, 23 Nov 2009 08:58:17 -0500
Message-ID: <20091123135817.GB2532@thunk.org>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
 <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
 <alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de>
 <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chromium-discuss@googlegroups.com
To: Adrian May <adrian.alexander.may@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 14:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCZQz-0007dd-6j
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 14:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZKWN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 08:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbZKWN6R
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 08:58:17 -0500
Received: from thunk.org ([69.25.196.29]:60337 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZKWN6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 08:58:16 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1NCZQr-0001FP-ET; Mon, 23 Nov 2009 08:58:21 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1NCZQn-0007bK-Dl; Mon, 23 Nov 2009 08:58:17 -0500
Content-Disposition: inline
In-Reply-To: <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133503>

On Mon, Nov 23, 2009 at 12:11:29PM +0800, Adrian May wrote:
> As for gclient and repo, without pretending to be an expert on what
> they actually do, I'm getting a strong gut feeling that if what I'm
> trying to do is pull or push code, then that's about as close as you
> can get to a definition of source control's central purpose. In the
> days of cvs or svn, I'd expect to use the source control for that. How
> come git needs help?

> > these "bolt-on scripts" give the savvy user freedom
> 
> Actually, I think their purpose is precisely the opposite: to regiment
> the ordinary developer into following their process. So having that
> code under the developer's control is a weakness.

If you don't have bolt-on scripts, and you move that into the the core
SCM, then you force *all* projects to use whatever workflow was
decided as being the One True Way of doing things as seen by the SCM
designer.  So the question is whether the SCM *should* regiment all
projects into following the SCM's designers idea of the One True
Workflow.

Git's approach is to say that it will be fairly flexible about
dictating workflow --- who pushs to whom; whether there is a single
"star" repository topology, or something that is more flexible, etc.

You seem to hate this flexibility, because it makes life harder until
you set up these bolt-on scripts.  But that's what many of us like
about git; that it doesn't force us (the project lead) into a single
way of doing things.

As far as my wanting to impose a particular regimen on my project's
developers, I've never been a big fan of the Bondage and Discpline
school of software engineering.  They can use whatever workflow they
like; they just have to deliver patches that are clean.  If they are,
I'll pull from their repository.  If they aren't, I won't.

     	       	     		     	  	    - Ted
