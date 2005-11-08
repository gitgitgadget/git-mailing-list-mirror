From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Notes on http-push
Date: Tue, 8 Nov 2005 07:50:21 -0800
Message-ID: <20051108155021.GB5830@reactrix.com>
References: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de> <20051108084620.GA5830@reactrix.com> <7vy83zjz0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 16:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZVkG-0001WT-Bo
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 16:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVKHPui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 10:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVKHPui
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 10:50:38 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:52180 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030228AbVKHPuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 10:50:37 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA8FoLfP014381;
	Tue, 8 Nov 2005 07:50:21 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA8FoLZP014379;
	Tue, 8 Nov 2005 07:50:21 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy83zjz0e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11333>

On Tue, Nov 08, 2005 at 12:59:45AM -0800, Junio C Hamano wrote:

> Pushing git commit history into SVN server --- this must be a
> sick joke ;-).  Can you pull over http from there?

I rather felt like I'd violated some law of nature or something.  Pulls
work fine from there - it's feasible to put an entire GIT repo behind a
DAV server, assuming there's a way to run all the non-push/pull git
commands.  If you're using mod_dav_fs, that could just mean having
shell/filesystem access to the server.  If you're using mod_dav_svn, it
could either mean using something like Davfs2 or putting intelligence
into the git commands to handle GIT_DIR=http://dav.serv.er/path by using
HTTP GET/PUT instead of read/write system calls.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
