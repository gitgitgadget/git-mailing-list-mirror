From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: [ANNOUNCE] git-svnconvert: YASI (Yet Another SVN importer)
Date: Sun, 9 Apr 2006 23:15:05 +0200
Organization: M38c
Message-ID: <20060409211505.GA30567@nospam.com>
References: <20060409163426.GA22103@nospam.com> <e1bdjq$qf6$1@sea.gmane.org>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 23:15:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FShFb-0002Cs-Or
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 23:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWDIVPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 17:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDIVPJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 17:15:09 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:65011 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750858AbWDIVPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 17:15:08 -0400
Received: from wingding.demon.nl ([82.161.27.36]:36689)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FShFT-0004rm-9v; Sun, 09 Apr 2006 21:15:07 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FShFT-0008LM-2C; Sun, 09 Apr 2006 23:15:07 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e1bdjq$qf6$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18565>

On Sun, Apr 09, 2006 at 06:43:53PM +0200, Jakub Narebski wrote:
> Rutger Nijlunsing wrote:
> 
> > Since I didn't succeed in importing a (private) SVN repo into git, I
> > wrote a new converter to handle more cases like:
> 
> Both git-svn[*1*] and git-svnimport failed? Have you tried Tailor tool:
>   http://www.darcs.net/DarcsWiki/Tailor

git-svn and tailor can only track one branch (or trunk). As the
git-svn page states, it is for contributing to such a branch /
trunk. git-svnconvert is for converting a whole repository
incrementally of which branches (IMHO) are important to keep and
convert.

git-svnimport does handle multiple branches, but could not cope with
proxy + repo authentification, the weird repo layout I've had to cope
with (branches not only in /branches, several trunks) and some
revisions which contain non-sensical actions.

> >   - use command line svn instead of some perl library to have less
> >     dependancies and to support proxy + repo authentification.
> >     Might even work on MacOSX ;)
> 
> Instead adding dependence on Ruby, eh?

Take some, lose some ;)

Seriously, though, a dependancy on a mainstream language like
Python/Perl/Ruby/.. isn't a problem since a package is available for
all distributions. However, packages for mainstream languages are
quite often out-of-date or are not supported at all. Seeing a program
being dependant on a non-packaged module is enough for a truckload of
people to not even try it.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
