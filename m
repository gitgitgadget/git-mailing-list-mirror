X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Linus Torvalds <torvalds@osdl.org>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 10:00:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611280944580.4244@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
	<ekhaeg$etk$1@sea.gmane.org>
	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	<456C6CBB.70702@utoronto.ca>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: sea.gmane.org 1164736894 27633 80.91.229.2 (28 Nov 2006 18:01:34 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Tue, 28 Nov 2006 18:01:34 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
Original-X-From: bazaar-ng-bounces@lists.canonical.com Tue Nov 28 19:01:28 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gp7GZ-0007hx-Ll
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 28 Nov 2006 19:01:11 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gp7GT-00033g-6v; Tue, 28 Nov 2006 18:01:05 +0000
Received: from smtp.osdl.org ([65.172.181.25])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gp7GN-00033H-Ee
	for bazaar-ng@lists.canonical.com; Tue, 28 Nov 2006 18:00:59 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASI0lix020506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Nov 2006 10:00:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASI0jQC018930;
	Tue, 28 Nov 2006 10:00:46 -0800
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <456C6CBB.70702@utoronto.ca>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19788 gmane.comp.version-control.git:32556
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32556>
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Nov 2006, Aaron Bentley wrote:
> 
> I notice that blame has an option to limit the annotation to recent
> history.  I can only assume that is for performance reasons.

You'd assume wrong.

Trust me, if you talk about performance, bzr will lose. I can pretty much 
guarantee you that you perform worse. The mozilla discussion pointed to a 
performance test between hg and bzr, and hg in that test tended to perform 
better by a factor of 2-10. And git tends to be another factor faster than 
_that_.

Performance is important to git, but it's important not in the sense of 
"let's not do it because it performs badly", but in the sense of "things 
should be so fast that people don't even realize that they are done". You 
guys may count commit times in seconds. I still want to commit multiple 
patches _per_second_ to the kernel tree. THAT is performance.

So no, performance wasn't the reason.

The reason is simple: be logical. The original blame/annotate semantics 
were

	git blame filename

which is what people traditionally use, but then to specify which version 
to _start_ with (in case you wanted to go backwards in time), you had an 
optional revision argument at the end.

Which is totally against how all the other git programs work, and I 
complained, because I had actually wanted to see the blame at a particular 
release version, and what my fingers typed didn't work. I want to be able 
to do

	git blame [revno] [--] filename

the same way I can ask for a git log, git whatchanged, gitk, and any 
other such history tool.

And once you do the same command line parsin as the other log-related 
commands, you pretty much automatically get the revision limiting. So now 
you can do

	git blame v2.6.17..v2.6.18 filename

on the kernel archive to see who is to blame for certain lines in a 
certain _range_ of commits. It just fell out of using the same syntax 
everywhere.

It's also happens to be useful. Quite often, you know something broke 
after a particular known-good release, so you're interested in the blame, 
but anything older than that known-good release is simply noise, and 
actually takes AWAY from the information, by just making things more 
cluttered.

			Linus



