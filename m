From: wa1ter@myrealbox.com
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Mon, 14 Nov 2005 05:09:40 -0800
Organization: none
Message-ID: <Pine.NEB.4.63.0511140458110.17527@x9.ybpnyarg>
References: <86acg9ijwa.fsf@blue.stonehenge.com> <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
 <1131926492.14637.5.camel@k9.localnet> <Pine.LNX.4.64.0511131625490.32662@x2.ybpnyarg>
 <20051114010940.GQ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 14 14:18:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbeBb-0007bq-Hu
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 14:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVKNNPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 08:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVKNNPT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 08:15:19 -0500
Received: from main.gmane.org ([80.91.229.2]:31127 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751117AbVKNNPS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 08:15:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ebe8n-0006X9-VY
	for git@vger.kernel.org; Mon, 14 Nov 2005 14:12:58 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 14:12:57 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 14:12:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <20051114010940.GQ30496@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11795>

On Mon, 14 Nov 2005, Petr Baudis wrote:

> Date: Mon, 14 Nov 2005 02:09:40 +0100
> From: Petr Baudis <pasky@suse.cz>
> Cc: git@vger.kernel.org
> Newsgroups: gmane.comp.version-control.git
> Subject: Re: http protocol, cloning git.git, fails (too many open files)
>
> Dear diary, on Mon, Nov 14, 2005 at 01:42:33AM CET, I got a letter
> where wa1ter@myrealbox.com said that...

> > So, what does cogito do differently...

> Cogito uses the same logic and underlying GIT fetching commands for
> cloning as well as for fetching, while git-clone uses some custom logic
> for cloning ("dumb http clone")...

BTW, I just noticed one big difference between git clone and cg-clone:

git clone stores the URL in .git/remotes/origin while cg-clone puts
it in .git/branches/origin.  When I do a cg-update after a git clone
then cg-update can't find the URL.
