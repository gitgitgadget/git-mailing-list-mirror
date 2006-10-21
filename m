From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 14:47:04 -0400
Message-ID: <BAYC1-PASMTP05955CD84D4736EAEBB89AAE020@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<20061017073839.3728d1e7.seanlkml@sympatico.ca>
	<20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	<20061021102346.9cd3abce.seanlkml@sympatico.ca>
	<20061021183428.GB29927@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 20:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLsH-00070A-7p
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766633AbWJUSrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766576AbWJUSrJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:47:09 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:40177 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1423368AbWJUSrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:47:07 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Oct 2006 11:47:06 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbKw4-0002DC-TP; Sat, 21 Oct 2006 13:47:04 -0400
To: Jan Hudec <bulb@ucw.cz>
Message-Id: <20061021144704.71d75e83.seanlkml@sympatico.ca>
In-Reply-To: <20061021183428.GB29927@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 18:47:06.0425 (UTC) FILETIME=[4E6F8A90:01C6F541]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Oct 2006 20:34:28 +0200
Jan Hudec <bulb@ucw.cz> wrote:

> For one think I, like others already expressed, think difference should
> be made between 'centralized' and 'star-topology'. Subversion is
> centralized -- I don't think bzr is biased towards that kind of
> centralization, though it provides tools (bound branches) to make it
> easy.

A star-topology assumes there is a central server from which the points
of the start emerge.  It is very much a centralized model and one that
bzr is clearly optimized for.  The difference between bzr and say
cvs is that bzr provides offline abilities where checkins to the
central server can be deferred by checking them in locally first.

The bzr bias towards this model is implicit in its affection for
revnos, which depend on a central repository to syncronize them for
all the points of the star.

[...]
> On the other hand git is biased away from centralized (as in subversion
> is centralized) in that it takes extra work to make sure you are always
> synchronized (while bzr has bound branches to do the checking for you).
> For open-source development, centralized is a wrong way to go, but
> people use version control tools for other purposes as well and for some
> of them staying synchronized is important.

Please reconsider this point, Git can be configured to push every commit
to a central server immediately.  It's just that such a model is so inferior
in almost every way, that it's not typically done.

Sean
