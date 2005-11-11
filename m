From: Petr Baudis <pasky@suse.cz>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 11:58:20 +0100
Message-ID: <20051111105820.GN30496@pasky.or.cz>
References: <200511111313.27273.lan@ac-sw.com> <20051111102857.GM30496@pasky.or.cz> <200511111642.25908.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 12:01:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaWdt-0006vi-U8
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKKK6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 05:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKKK6Y
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 05:58:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:26852 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932318AbVKKK6X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 05:58:23 -0500
Received: (qmail 25124 invoked by uid 2001); 11 Nov 2005 11:58:20 +0100
To: Alexander Litvinov <lan@ac-sw.com>
Content-Disposition: inline
In-Reply-To: <200511111642.25908.lan@ac-sw.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11583>

Dear diary, on Fri, Nov 11, 2005 at 11:42:25AM CET, I got a letter
where Alexander Litvinov <lan@ac-sw.com> said that...
> On Friday 11 November 2005 16:28, Petr Baudis wrote:
> > Well, what exactly is the problem with just having multiple
> > repositories?
> 
> 1. The problem with checkout - single checkout should checkout all needed 
> modules to build project. Update should also update all modules. The same 
> with commit.
> 2. Tags should be done on all modules. All modules should be able to be in the 
> same branch.

Then just have only a bunch of directories in your project root, and
that shall be your modules. :-)

(CVS modules don't work like that either, do they?)

> And in the same time one module should be able to exists in two or more 
> projects !

But this is troublesome, and doesn't fit into GIT's model at all. Do you
have any concrete example of a scenario where something like this would
be useful?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
