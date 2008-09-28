From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 28 Sep 2008 23:18:53 +0200
Message-ID: <20080928211853.GH10360@machine.or.cz>
References: <200809251230.11342.jnareb@gmail.com> <200809281201.04161.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 23:20:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk3gX-0006N3-86
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 23:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYI1VS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYI1VS7
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 17:18:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33399 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbYI1VS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 17:18:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A6FA93939B56; Sun, 28 Sep 2008 23:18:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809281201.04161.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96987>

On Sun, Sep 28, 2008 at 12:01:03PM +0200, Jakub Narebski wrote:
> On Thu, 25 Sep 2008, Jakub Narebski wrote:
> 
> > This is yet another series of planned gitweb features. It expands more
> > on new user-visible features than on improving gitweb code (therefore
> > for example using Git.pm/Git::Repo, gitweb caching, and list form of
> > open for pipelines are not mentioned here).
> 
> Below there are a few more features which were missing from the list:
> 
> * Support for invoking gitweb.cgi (the compiled version) from command
>   line to easy generate projects list in format used by gitweb,
>   perhaps also to generate web feeds (RSS, Atom, OPML). It would
>   probably require adding support for CLI parameters.

Or, for starters, just document the existing one. ;-)

	REQUEST_METHOD=GET QUERY_STRING=a=opml gitweb/gitweb.cgi

> * gitweb-admin or gitwebmin; I guess best as separate script.
>   
>   Allow to set gitweb configuration, gitweb-related per-repository
>   configuration (visibility, access, description, README, URLs,...).
>   Perhaps also allow to set access permissions, delete/create
>   branches, change denyFastForward, rename project, set alternates,
>   etc.

I don't see this very useful for gitweb administrator, but more for
owners of particular projects shown by gitweb. That would be very
useful, yes!

> * Make gitweb use less dependent on understanding git terminology, like
>   'tree' -> 'browse' etc. (proposed by Pieter de Bie (Pieter) on #git,
>   as "simplified interface", 2008-09-27T14:56+0200).
> 
>   'tree' -> 'browse', 'blob' -> 'file' or 'show', 
>   'snapshot' -> 'archive' or 'download', 'heads' -> 'branches'
>   'commit | commitdiff | tree | snapshot' -> 'show | browse' for heads
>   
>   Unfortunately there is no consensus on how such simpler terminology
>   should look like...

Yes, I would be very careful here. I personally agree with 'snapshot' ->
'archive' and 'heads' -> 'branches', but I'm not comfortable with the
others at all.

> * Possibly: fallback to "user.name <user.email>" for repository owner

That would be good.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
