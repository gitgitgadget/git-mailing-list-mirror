From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 4 Mar 2007 13:32:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703041321290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 13:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNptD-0005Db-1T
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 13:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXCDMcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 07:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXCDMcY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 07:32:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:33589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbXCDMcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 07:32:23 -0500
Received: (qmail invoked by alias); 04 Mar 2007 12:32:21 -0000
X-Provags-ID: V01U2FsdGVkX1/K4SgR+LvK7dFv0YsN11AYmVllCnm48MQ8zN4auQ
	06LbLk/Ngs9Fwd
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41356>

Hi,

On Sun, 4 Mar 2007, Junio C Hamano wrote:

> * js/attach (Sun Mar 4 00:12:06 2007 +0100) 1 commit
>
> [...]
>
> * js/symlink (Sat Mar 3 20:38:00 2007 +0100) 3 commits

The prefix system is showing its limitation... :-)

> * js/gnucl (Fri Mar 2 15:29:08 2007 +0100) 2 commits
>  - --pretty=gnucl: avoid line wrapping before the comma
>  - Add --pretty=gnucl
> 
> This is to output logs in the GNU ChangeLog format.

FWIW I am opposed to include that. After letting it sink in, Linus' 
remarks convinced me that this format is not as useful as our other log 
formats, and for those people who really want it, there is git2cl.

> * js/revert-cherry (Thu Mar 1 05:26:30 2007 +0100) 1 commit
>  + Make git-revert & git-cherry-pick a builtin
> 
> Will cook for some time.

Yes. I worked with them a bit, but nowhere enough to say that they are 
not introducing regressions.

> * js/diff-ni (Sun Feb 25 23:36:53 2007 +0100) 4 commits
>  + Get rid of the dependency to GNU diff in the tests
>  + diff --no-index: support /dev/null as filename
>  + diff-ni: fix the diff with standard input
>  + diff: support reading a file from stdin via "-"
> 
> I've fixed up this series since it was posted, and I think it is
> in a testable shape now, so it is in 'next'.

Thank you.

> * js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 3 commits
>  . git-fetch: add --quiet
>  + Fixup no-progress for fetch & clone
>  + fetch & clone: do not output progress when not on a tty
> 
> The early parts that have been in 'next' should be ready to go to 
> 'master' now.  The last one I am not sure.

BTW I just added this to my fetches in crontab: ' | sed -e "s/^.*\r//g"' 
This is the workaround Nico proposed, only a little bit more obvious (and 
removable).

Ciao,
Dscho
