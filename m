From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 01:09:25 +0200
Message-ID: <20060919230925.GG8259@pasky.or.cz>
References: <20060919225522.GB13132@pasky.or.cz> <eept0r$5d0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 01:09:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoiY-0006nQ-DQ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWISXJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWISXJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:09:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63928 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752103AbWISXJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 19:09:27 -0400
Received: (qmail 28746 invoked by uid 2001); 20 Sep 2006 01:09:25 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eept0r$5d0$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27313>

Dear diary, on Wed, Sep 20, 2006 at 01:04:50AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > This adds very simple support for per-project setting of the owner string
> > (in an environment where the actual owners won't have access to the
> > repositories accessed by gitweb, so faking identity is not an issue).
> 
> Is it really needed? If $projects_list is a _file_, you can set correct
> ownership information there.
> 
> Now $projects_list being a directory (usually $projectroot) support
> hierarchy of repositories; generating appropriate projects' index file
> is as easy as unsetting $projects_list (so it is by default set to
> $projectroot), going to summary view, clicking [TXT] link on the left of
> [OPML] link at the bottom, copy the result to projects' index file, correct
> ownership information (and perhaps remove some projects), and set
> $projects_list to this file.

Which is not really easy at all. I would have to do some ugly script to
autogenerate the text file while this way I can just throw the data to
the hierarchy and having everything still working magically.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
