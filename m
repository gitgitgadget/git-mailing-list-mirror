X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Andreas Ericsson <ae@op5.se>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 15:49:46 +0200
Message-ID: <453F6B7A.60805@op5.se>
References: <45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<vpq4ptz2uh8.fsf@ecrins.imag.fr>
	<453DAC87.8050203@research.canon.com.au>
	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
	<20061025084810.GA26618@coredump.intra.peff.net>
	<Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
	<20061025094900.GA26989@coredump.intra.peff.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1161784219 25230 80.91.229.2 (25 Oct 2006 13:50:19 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 25 Oct 2006 13:50:19 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, David Rientjes <rientjes@cs.washington.edu>
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 25 15:50:15 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gcj8z-0003Ti-Uq
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 25 Oct 2006 15:50:10 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gcj8y-0005bL-RV; Wed, 25 Oct 2006 14:50:08 +0100
Received: from linux-server1.op5.se ([193.201.96.2] helo=smtp-gw1.op5.se)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <ae@op5.se>) id 1Gcj8g-0005ZY-UA
	for bazaar-ng@lists.canonical.com; Wed, 25 Oct 2006 14:49:54 +0100
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id A1C796BCF0; Wed, 25 Oct 2006 15:49:50 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3C1596BCE4; Wed, 25 Oct 2006 15:49:47 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Jeff King <peff@peff.net>
In-Reply-To: <20061025094900.GA26989@coredump.intra.peff.net>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18768 gmane.comp.version-control.git:30058
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30058>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Oct 25, 2006 at 02:19:15AM -0700, David Rientjes wrote:
> 
>> No, my criticism is against the added complexity which makes the 
>> modification of git increasingly difficult with every new release.  It's a 
> 
> OK, you seemed to imply problems for end users in your first paragraph,
> which is what I was responding to.
> 
>> _current_ needs.  For any experienced shell programmer it is so much 
>> easier to go in and change an option or pipe to a different command or 
>> comment out a simple shell command in a .sh file than editing the C code.  
> 
> Yes, it's true that some operations might be easier to play with in the
> shell. However, does it actually come up that you want to modify
> existing git programs? The more common usage seems to be gluing the
> plumbing together in interesting ways, and that is still very much
> supported.
> 

Indeed. I still use my old git-send-patch script whenever I want to send 
patches, simply because I don't like git-send-email and its defaults 
much. The interface hasn't changed one bit since I wrote it. That's 
pretty stable, since send-patch was created couple of hours before git.c 
was submitted to the list, as I wrote the "send-patch" script to send 
the patch that did the rewriting.

I'm personally all for a rewrite of the necessary commands in C 
("commit" comes to mind), but as many others, I have no personal 
interest in doing the actual work. I'm fairly certain that once we get 
it working natively on windows with some decent performance, windows 
hackers will pick up the ball and write "wingit", which will be a log 
viewer and GUI thing for 
fetching/merging/committing/reverting/rebasing/sending patches and 
whatnot. Possibly it will have hooks to Visual C++ or some other IDE. I 
don't know how that sort of thing works, but I'm sure someone clever and 
bored enough will want to investigate the possibilities.


