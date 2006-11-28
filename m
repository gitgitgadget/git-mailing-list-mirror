X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Hyphens and hiding core commands
Date: Mon, 27 Nov 2006 16:42:14 -0800
Message-ID: <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 00:42:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87ac2cwha4.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	27 Nov 2006 16:23:31 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32474>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gor3D-0007Ft-KB for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934176AbWK1AmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934223AbWK1AmQ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:42:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2017 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S934176AbWK1AmP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:42:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128004215.WYME97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 19:42:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s0hi1V0171kojtg0000000; Mon, 27 Nov 2006
 19:41:43 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> Yes, there is a learning curve. There's the "once you grok the index"
> stuff you just mentioned. And it's really backwards to have to teach
> people that the "basic" way to do something is with a command line
> that looks more complex, ("commit -a"), and that "once you learn more
> you'll understand what that -a is all about and you'll know when not
> to use it".

I think you are teaching backwards.  Couldn't you start like this?

	"git commit" takes the list of paths you want to commit.
	Editing hello.c and saying "git commit hello.c" would
	commit your changes to hello.c.  It is cumbersome to
	list everything when your edit is all over the place,
	and in such a case you can say "git commit -a" to mean
	"everything I changed".

Later you can enhance that experience by teaching them index,
saying:

	You might want to tell git that your change to this file
	is more or less complete, even when you are not ready to
	commit the whole thing.  You could use update-index to
	mark them and then later say "git commit" will make a
	commit from the state you used update-index on, without
	having you list them on the command line.  When you do
	this, the commit template would list three classes of
	files and here are what they mean...


