From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 06:26:56 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100329102656.GA10925@thyrsus.com>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com>
 <201003291100.13043.trast@student.ethz.ch>
 <20100329091056.GC10538@thyrsus.com>
 <201003291132.53415.trast@student.ethz.ch>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 29 12:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwCBT-0004R4-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 12:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab0C2K06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 06:26:58 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:50128
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab0C2K05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 06:26:57 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id BCCCD475FEF; Mon, 29 Mar 2010 06:26:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201003291132.53415.trast@student.ethz.ch>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143452>

Thomas Rast <trast@student.ethz.ch>:
> I suppose I was never bothered by the lack of automatic tagging
> because I rarely found a git-svn import to be immediately fit for
> publishing.  Usually it took some grafting and other filtering to
> bring the history into shape anyway.  Maybe now that the svn:mergeinfo
> support obviates the need for grafting, it's worth thinking about the
> rest.

Can't argue your first point at all, because my only large migration
so far did in fact need filtering - to fix up artifacts from the Emacs
VC front end that were fossilized in the Subversion history. And that
was all my own fault; I was the original author of VC back in the
early 1990s, and should have rewritten it to be changeset-aware years
sooner than I did. Alas, I was kind of busy being Mr. Famous Geek for
about a decade in there, and the VC rewrite was one of several
projects that got seriously sidetracked.  I finally got it done in
2008-2009, and git is one of the backend systems that benefits from
that.

Still. Even conceding that point, built-in support to further reduce
the amount of hand-work required in SVN conversion would be no bad
thing.  Tag conversion was unequivocally the biggest pain in the ass
when I migrated GPSD; I'm not claiming that will always be true, but I do
think it's the largest pain that could be *reliably mechanized
away*. That makes it a logical target.

One of the reasons this is still on my mind after the GPSD migration
is Battle For Wesnoth <http://www.wesnoth.org/>. I'm one of the senior
devs on that project, and it is becoming clear to all that we have
reached Subversion's limits there.  I'm the project's tools and
toolsmithing expert, and I've pretty much got the other devs convinced to
switch to a DVCS when we can screw up our courage to move to a forge
that supports one. 

This means I'm probably going to be the guy on the spot doing yet
another big ugly conversion away from SVN sometime within the next
year.  The state of conversion tools at that time might end up
determining whether Wesnoth goes with git or Mercurial.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
