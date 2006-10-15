From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 14:39:56 -0400
Message-ID: <BAYC1-PASMTP036D3F961BC92DC72FAEF9AE080@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egrgqe$1i9$1@sea.gmane.org>
	<9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	<20061015182303.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 20:40:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZAu4-00088z-5T
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWJOSj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJOSj7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:39:59 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:26788 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751161AbWJOSj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 14:39:59 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 15 Oct 2006 11:39:58 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZ9xt-0000O6-4U; Sun, 15 Oct 2006 13:39:57 -0400
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20061015143956.86db3a8b.seanlkml@sympatico.ca>
In-Reply-To: <20061015182303.GW20017@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Oct 2006 18:39:58.0271 (UTC) FILETIME=[50C1ECF0:01C6F089]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Oct 2006 20:23:03 +0200
Petr Baudis <pasky@suse.cz> wrote:

> (BTW, yes, grafting the old history could help this time, but it is a
> hack and not a good long-term solution - it is just putting the real
> solution away until the project history will re-grew. Periodical
> regrafting is even worse hack, since at that moment you break
> fast-forwarding and this kind of "restarting the history" breaks deep
> into the Git distributiveness.)

But is there a better practical solution he can use today?  I don't think
there is.  And the experience of the Linux kernel has shown that it's not
really all that big a problem.  You even made a nice script to help people
do it! ;o)

It's probably not the solution that should be used _next_ time the repository
grows too big, but it sure seems like the correct solution this time around.
Not many people will want all that old history anyway (10+ years as i recall?).

Sean
