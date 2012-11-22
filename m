From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Thu, 22 Nov 2012 17:11:07 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121122221107.GA16069@thyrsus.com>
References: <20121122053012.GA17265@thyrsus.com>
 <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:12:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbf0m-0004G2-T8
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 23:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab2KVWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 17:12:12 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54880
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab2KVWLy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 17:11:54 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id A333F4065F; Thu, 22 Nov 2012 17:11:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210216>

Shawn Pearce <spearce@spearce.org>:
> [Lots of helpful stuff ended by]
> > 4. How does "git help" work?  That is, how is a subcommand expected
> > to know when it is being called to export its help text?
> 
> IIRC "git help foo" runs "man git-foo".

OK, that makes sense.

> > 5. I don't see any extensions written in Python.  Are there any special
> > requirements or exclusions for Python scripts?
> 
> Nope, it just has to be executable. We don't have any current Python
> code. IIRC the last Python code was the implementation of
> git-merge-recursive, which was ported to C many years ago. We avoid
> Python because it is not on every platform where Git is installed. Yes
> Python is very portable and can be installed in many places, but we
> prefer not to make it a requirement.

I find that odd.  You avoid Python but use shellscripts?  *blink*

One would think shellscripts were a much more serious portability problem.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
