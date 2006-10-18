From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 09:02:18 -0400
Message-ID: <BAYC1-PASMTP05B3E4A82F968CA2E22589AE0F0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca>
	<200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca>
	<4535E844.8010604@op5.se>
	<20061018103220.GS75501@over-yonder.net>
	<45360DAE.8000702@op5.se>
	<20061018124320.GT75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 15:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaB41-0002W8-7n
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 15:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWJRNCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 09:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWJRNCW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 09:02:22 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:50024 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030262AbWJRNCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 09:02:21 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 06:02:20 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaA7n-0000wp-C4; Wed, 18 Oct 2006 08:02:19 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061018090218.35f0326b.seanlkml@sympatico.ca>
In-Reply-To: <20061018124320.GT75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 13:02:21.0088 (UTC) FILETIME=[A5C65A00:01C6F2B5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 07:43:20 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> The difference is that bzr ALSO chooses to support and optimize for a
> different case in the default UI presentation, because We[0] consider
> that far and away the common case on the one hand, and that people
> trying to use the more complex case are ipso facto more able to use a
> behavior differing from the norm on the other.
> 
> [0] Note how adroitly I again speak for other people.  Practice,
>     practice!

Just to be clear here, Git is also able to  supports this model if
you so choose.  It's quite easy for a server to generate Git tags
for every commit it gets.

It's just that this is basically a non issue in the Git world.  People
who use Git aren't crying out for salvation from sha1 numbers.  So I
think this entire discussion is a bit overblown.

But just to be clear, there is nothing in the Git model that prohibits
tagging every commit with something you find less objectionable than
sha1's.  They can appear in the log listings and in gitk etc, and
everyone who pulls from the central server will get them.  In fact,
for some imports of other VCS into Git, exactly that is done; so every
commit can be referenced by its sha1 _or_ the "friendly" number it was
known by in its original VCS.

Sean
