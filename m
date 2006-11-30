X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Andreas Ericsson <ae@op5.se>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 13:25:19 +0100
Message-ID: <456ECDAF.4050102@op5.se>
References: <45357CC3.4040507@utoronto.ca>
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
	<456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
	<456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de>
	<Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
	<456CB197.2030201@onlinehome.de>
	<Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
	<Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
	<456DD76C.4010902@gmx.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1164889590 3130 80.91.229.2 (30 Nov 2006 12:26:30 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 30 Nov 2006 12:26:30 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Thu Nov 30 13:26:28 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gpkzj-0003fg-2a
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 30 Nov 2006 13:26:27 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gpkz5-0002dd-Mq; Thu, 30 Nov 2006 12:25:47 +0000
Received: from linux-server1.op5.se ([193.201.96.2] helo=smtp-gw1.op5.se)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <ae@op5.se>) id 1Gpkyg-0002c6-Vp
	for bazaar-ng@lists.canonical.com; Thu, 30 Nov 2006 12:25:23 +0000
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1CE5C6BCC1; Thu, 30 Nov 2006 13:25:20 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Marko Macek <marko.macek@gmx.net>
In-Reply-To: <456DD76C.4010902@gmx.net>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19900 gmane.comp.version-control.git:32729
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32729>
X-Mailing-List: git@vger.kernel.org

Marko Macek wrote:
> Linus Torvalds wrote:
>> So most of the time, when you use git, you can ignore the index. It's 
>> really important, and it's used _all_ the time, but you can still 
>> mostly ignore it. But when handling a merge conflict, the index is 
>> really what sets git apart, and what really helps a LOT.
> 
> Actually, people (at least me) dislike the index because in the most common
> operations (status, diff, commit), they have to know that the command 
> doesn't actually
> display all their work but just the 'indexed' part of it.
> For people used to cvs, svn and other systems it would be nicer if diff -a
> and commit -a (and possibly other commands) were the default.
> 

Unless you do "git update-index" (and thus are already using the index) 
on any files, "git diff" shows you exactly the changes between your last 
commit and the working tree. There's nothing magic, odd or confusing 
about it, no matter which scm you come from.


