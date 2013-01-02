From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 11:18:48 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102161848.GA18447@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com>
 <20130102153933.GA30813@elie.Belkin>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqR2o-0004Xz-A7
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab3ABQTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:19:35 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36254
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3ABQTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:19:34 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 7AB9F4415C; Wed,  2 Jan 2013 11:18:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130102153933.GA30813@elie.Belkin>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212517>

Jonathan Nieder <jrnieder@gmail.com>:
> The former is already loudly advertised in the package description and
> manpage, at least lets you get work done, and works fine for simple
> repositories with linear history.

Two of the three claims in this paragraph are false.  The manual page
does not tell you what is true, which is that old cvsps will fuck up
every branch by putting the root point at the wrong place.  And if you
call silently and randomly damaging imports getting work done, your
definitions of "work" and "done" are broken.

> Taking away a command that people have been using in everyday work is
> pretty much a textbook example of a regression, no?

That would be, but we are talking about replacing total breakage with
a git-cvsimport that actually works and that you invoke in pretty much the
same way as the old one.  Nothing is or will be taken away.

In any case, once the distros package cvsps 3.x, old cvsimport will terminate
with an error return, because cvsps-3.x sees an obsolete option that 
git-cvsimport tries to use as a command to treminate after displaying
a prompt to upgrade.

The most we can accomplish by being "conservative" is to lengthen the
window during which people will falsely believe that their conversion
process is working.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
