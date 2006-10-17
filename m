From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:16:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 01:16:58 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyB8-0004bO-6q
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 01:16:58 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZyAw-0003b1-Ry; Wed, 18 Oct 2006 00:16:46 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GZyAs-0003aw-Ts
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 00:16:44 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HNGKaX008063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 16:16:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HNGF8W010219;
	Tue, 17 Oct 2006 16:16:17 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610180057.25411.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
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
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29134>



On Wed, 18 Oct 2006, Jakub Narebski wrote:
> 
> Perhaps it would be nice to have "bundles" in git too. As of now
> we can save arbitrary part of history in a pack, but it is binary
> not textual representation.
> 
> Some of git workflow stems from old, pre-SCM Linux kernel workflow
> of sending _patches_ via email.

Actually, the reason to _not_ have bundles very much stems from the fact 
that BK did have bundles, and they were pretty horrid.

It would be easy to send the exact same data as the native git protocol 
sends over ssh (or the git port) as an email encoding. We did that a few 
times with BK (there it's called "bk send" and "bk receive" to pack and 
unpack those things), and after doing it about five times, I absolutely 
refused to ever do it again. There's just no point, except to make your 
mailbox grow without bounds, and it was really annoying. 

So sending things as patches is just a lot more convenient if you want 
emails.  And if you want to sync two repos directly, I think we've gotten 
sufficiently past the old UUCP days when you want to use email as a 
packetization medium.

That said, "bundles" certainly wouldn't be _hard_ to do. And as long as 
nobody tries to send _me_ any of them, I won't mind ;)

		Linus
