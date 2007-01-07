From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Hello all, I am using git-svn and have some question
Date: Sat, 6 Jan 2007 22:31:01 -0800
Message-ID: <20070107063101.GA23429@mayonaise.dyndns.org>
References: <7d73e7d80701060124t16850e8ob8fbd202d230dd90@mail.gmail.com> <20070107002317.GC10933@localdomain> <7d73e7d80701062206y34db9d06k3c871c7e83a8aa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 07:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3RYj-0005Ae-O4
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 07:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXAGGbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 01:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAGGbE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 01:31:04 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33781 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932423AbXAGGbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 01:31:03 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 302627DC094;
	Sat,  6 Jan 2007 22:31:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 22:31:01 -0800
To: Songmao Tian <kingkongmao@gmail.com>
Content-Disposition: inline
In-Reply-To: <7d73e7d80701062206y34db9d06k3c871c7e83a8aa4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36132>

Songmao Tian <kingkongmao@gmail.com> wrote:
> I have made a mistake, while use 1.4.4.1, exec git-svn multi-fetch
> will find possible parent for each branch, but 1.4.4.3 will not.
> 
> with parent found, git-rebase between branches will result in less
> conflict. I wonder if I have made another mistake while using
> 1.4.4.3:), for i like the way 1.4.4.1's multi-fetch did

I don't see anything regarding multi-fetch changed between
v1.4.4.1..v1.4.4.3.  Did you forget the --follow-parent flag?
No worries though, you can use 'git-svn graft-branches' to
connect a branch to its parent; and if that doesn't work automatically;
you can edit the .git/info/grafts file with parent info (it's
documented in Documentation/repository-layout.txt.

-- 
Eric Wong
