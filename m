From: Sean <seanlkml@sympatico.ca>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 20:01:48 -0500
Message-ID: <20061221200148.ac6e39b4.seanlkml@sympatico.ca>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061221182102.906ad046.seanlkml@sympatico.ca>
	<7vvek492q1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:01:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYnK-0004Yz-CF
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423174AbWLVBBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423172AbWLVBBw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:01:52 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:42265 "EHLO
	BAYC1-PASMTP04.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423174AbWLVBBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:01:51 -0500
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 21 Dec 2006 17:01:50 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GxXr8-0007rw-KI; Thu, 21 Dec 2006 19:01:46 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvek492q1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Dec 2006 01:01:50.0706 (UTC) FILETIME=[C34F4D20:01C72564]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35109>

On Thu, 21 Dec 2006 16:46:46 -0800
Junio C Hamano <junkio@cox.net> wrote:

> You can always say "git log refs/heads/next" even though you are
> allowed to say "git log next".  Maybe we should remove that
> shorthand to make it consistent?   I think not.

Of course not.  But why not add the shorthand to the other case
to make it consistent?

> The remote side can add things without your knowing, so
> insisting on the exact match makes sense in a weird sort of
> way.

I'm sure there are technical reasons why things are they way they
are, nothing weird about that.  But looking in from the outside
and not knowing what those reasons are, leads to an honest
question if it's absolutely necessary for a user to have to learn
about the internal "refs/heads" directory structure of Git.
It would be nicer if they could just think in terms of branches
and tags.
 
> And this is a config file you would set once and then can forget
> about it.  I do not see a big deal about having to spell it
> fully.

It's not a huge deal, it's just one more slightly unexpected thing
for a user to have to deal with in learning Git.  It seems reasonable
for a user to be able to refer to a remote branch as "remote/branch",
and not  "remote/refs/heads/branch".  But if that simply can't be
accommodated, so be it.

Sean
