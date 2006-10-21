From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 15:02:33 -0400
Message-ID: <BAYC1-PASMTP0816D1AFF1061427F862A3AE020@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
	<4535345C.6090905@utoronto.ca>
	<20061021185825.GC29927@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 21:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbM7F-0000r0-3q
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWJUTCh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWJUTCh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:02:37 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:38936 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1422792AbWJUTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:02:36 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Oct 2006 12:11:17 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbLB3-0002EI-VE; Sat, 21 Oct 2006 14:02:33 -0400
To: Jan Hudec <bulb@ucw.cz>
Message-Id: <20061021150233.c29e11c5.seanlkml@sympatico.ca>
In-Reply-To: <20061021185825.GC29927@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 19:11:18.0062 (UTC) FILETIME=[AFADC4E0:01C6F544]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Oct 2006 20:58:25 +0200
Jan Hudec <bulb@ucw.cz> wrote:

> In bzr this was already discussed and the storage supports so called
> "ghost" revisions, whose existence is known, but not their data. There
> are even repositories around that contain them (created by converting
> data from arch), but to my best knowledge there is no user interface to
> create branches or checkouts with partial data.

In Git the same functionality can be achieved with so called shallow-
clones.  Unfortunately, they've only been discussed and not yet
implemented.

Sean
