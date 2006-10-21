From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:06:53 -0400
Message-ID: <BAYC1-PASMTP03CB0610A4C02971F3CE7FAE020@CEZ.ICE>
References: <45357CC3.4040507@utoronto.ca>
	<87irie1wvv.wl%cworth@cworth.org>
	<20061021130111.GL75501@over-yonder.net>
	<200610211608.18895.jnareb@gmail.com>
	<20061021181149.GM75501@over-yonder.net>
	<20061021191949.GA8096@coredump.intra.peff.net>
	<20061021214629.GO75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 00:07:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbOzc-000072-S7
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 00:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWJUWG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 18:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJUWG5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 18:06:57 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:64262 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161129AbWJUWG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 18:06:56 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Oct 2006 15:06:56 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbO3S-0002TL-0C; Sat, 21 Oct 2006 17:06:54 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061021180653.d3152616.seanlkml@sympatico.ca>
In-Reply-To: <20061021214629.GO75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 22:06:56.0562 (UTC) FILETIME=[391D4120:01C6F55D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Oct 2006 16:46:29 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> Obviously, this is a totally foreign mentality to git, and that's
> great because it seems to work for you.  I can see advantages to it,
> and I can conceive of situations where I might want that behavior.
> But, in my day-to-day VCS use, I don't hit them, which is why I keep
> typing 'bzr' instead of 'git' when I annoyingly need to type 'cvs'.

It's not completely foreign, it's one of the things you can use the
git reflog feature to record.  It's just that it's utterly clear in
Git that this is a local feature and is never replicated as part
of the distributed data.

> Depends on what you're fetching.  You can always tell 'bzr pull' a new
> URL to look from.  If it's a later version of the 'same' branch, it'll
> just update.  If it's a 'different' branch (a branch that's a superset
> of your current branch/set-of-revisions, but with a different
> 'mainline' path through the revisions counts as 'different' here),
> pull will complain and require a --overwrite to do the deed.

This is where the git model is clearly superior and allows a true
distributed model.  Because there is no concept of a "mainline"
(except locally via reflog) you can always merge with anyone
participating in the DAG without having to overwrite or lose ordering.

Sean
