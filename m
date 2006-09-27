From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 22:41:33 -0400
Message-ID: <BAYC1-PASMTP037BE64D8E979289EE7D68AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745. 15344.qmail@web51005.mail.yahoo.com>
	<BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1 A0@CEZ.ICE>
	<20060926205632.5d487cc9.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.06
	09261746160.22495@qynat.qvtvafvgr.pbz>
	<7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz>
	<7vhcyukpkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Lang <dlang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 04:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPMg-0002eb-UK
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWI0Clg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWI0Clg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:41:36 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:32946 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932283AbWI0Clf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:41:35 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 19:41:34 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSPMc-0004LM-06; Tue, 26 Sep 2006 22:41:34 -0400
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060926224133.714337eb.seanlkml@sympatico.ca>
In-Reply-To: <7vhcyukpkc.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 02:41:35.0149 (UTC) FILETIME=[72CA55D0:01C6E1DE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 19:31:47 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Only when somebody is interested in the particular question
> "when did this commit has become part of this branch" it becomes
> relevant.  And do not get me wrong.  I am in principle agreeing
> with you that this is an extra information for most of the time
> -- I even doubt "when did this commit has become part of this
> branch" is all that useful.

It is interesting information for some people though.  For instance
someone wondering how long ago Linus published a certain security fix.
To be able to say to easily query gitweb and be able to report,
"Linus published that security fix X day ago etc.."

Of course, I agree with you that also knowing the revision number
such a commit appeared in is at least if not more important.  But
still I don't dismiss this date/time based question as completely
as you do.  The very fact that a gitweb user has brought this issue
forward (and this isn't the first time) suggests the information
is at least of casual interest to some people.

Sean
