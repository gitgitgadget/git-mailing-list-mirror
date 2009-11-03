From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb - bare repos integration - owner info in description
 file
Date: Tue, 3 Nov 2009 21:22:11 +0100
Message-ID: <20091103202211.GA17748@machine.or.cz>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
 <m3ab00gr25.fsf@localhost.localdomain>
 <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
 <200910102045.13374.jnareb@gmail.com>
 <alpine.DEB.1.00.0910120201350.4985@pacific.mpi-cbg.de>
 <76c5b8580910121448q67edd935wb189c8a6f9af2f2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 21:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5PtX-0001Iz-CV
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 21:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZKCUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZKCUWL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 15:22:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50223 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbZKCUWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 15:22:10 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id EB8EC86201A; Tue,  3 Nov 2009 21:22:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76c5b8580910121448q67edd935wb189c8a6f9af2f2e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131991>

On Mon, Oct 12, 2009 at 05:48:14PM -0400, Eugene Sajine wrote:
> Hi,
> 
> Somebody from development camp recently complained here that there is
> no many end users "chiming" about issues in the mailing list. Well,
> don't tell i didn't try;)
> 
> First I tried to use gitweb.url, gitweb.description and gitweb.owner
> files and none of them worked... gitweb is unable to pickup the info
> from those files.
> 
> Although it successfully interactively picks up info from description
> and cloneurl files. I didn't find a substitution for gitweb.owner...
> 
> I might be sent to RTFM again, but i would like to bring an attention
> to the fact that setting up bare repo with these simplest parameters
> as well as setting up gitweb is a USABILITY NIGHTMARE for beginners. I
> would even say more: while gitweb is very flexible and powerful, all
> its flexibility and power is hidden behind unusable management
> interface, which IMHO requires a lot of improvements . Rebuilding to
> configure? Perl look-and-feel for configuration variables? I think
> this is not the way to configure web applications no matter how smart
> and flexible application should be. There are some problems with XML,
> I don't care. Let's use simple property file. 1 property file! and let
> gitweb read it. don;t like this solution, propose yours..

I think you got confused by perhaps unclear gitweb/README wording. There
is a single property file, it's called "config" and _that's_ where you
set the gitweb configuration variables, in its gitweb section.

Try running

	git config gitweb.owner "Eugene Sajine"
	git config gitweb.description tralala

within the repository (and optionally marveling at the config file again
afterwards). Is this what you are after?

Perhaps the gitweb/README file doesn't make it clear enough that these
are gitweb configuration variables, not stand-alone files, and maybe it
should provide an example on how to set them. I'm sure that if you will
submit a patch for gitweb/README clarifying this, it will be welcome.

Kind regards,

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
