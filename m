X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: David Rientjes <rientjes@cs.washington.edu>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 13:12:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<vpq4ptz2uh8.fsf@ecrins.imag.fr>
	<453DAC87.8050203@research.canon.com.au>
	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: sea.gmane.org 1161720824 8686 80.91.229.2 (24 Oct 2006 20:13:44 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Tue, 24 Oct 2006 20:13:44 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 24 22:13:38 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcSe7-0005Y5-Cv
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 24 Oct 2006 22:13:11 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GcSe2-0000rB-64; Tue, 24 Oct 2006 21:13:06 +0100
Received: from mx4.cs.washington.edu ([128.208.4.190])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <rientjes@cs.washington.edu>) id 1GcSdq-0000oX-MD
	for bazaar-ng@lists.canonical.com; Tue, 24 Oct 2006 21:12:55 +0100
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu
	[128.208.1.140])
	by mx4.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id
	k9OKCr9w023924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Oct 2006 13:12:53 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id
	k9OKCqV1008930; Tue, 24 Oct 2006 13:12:52 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process
	doing -bs
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18712 gmane.comp.version-control.git:30010
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30010>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Oct 2006, Linus Torvalds wrote:

> Yes. However, from a portability (to Windows) standpoint, shell is just 
> about the worst choice.
> 
> Not that perl/python/etc really help - unless the _whole_ program is one 
> perl/python thing. Windows just doesn't like pipelines etc very much.
> 
> So I'd like all the _common_ programs to be built-ins..
> 

And I would prefer the opposite because we're talking about git.  As an 
information manager, it should be seen and not heard.  Nobody is going to 
spend their time to become a git or CVS or perforce expert.  As an 
individual primarily interested in development, I should not be required 
to learn command lines for dozens of different git-specific commands to do 
my job quickly and effectively.  I would opt for a much more simpler 
approach and deal with shell scripting for many of these commands because 
I'm familiar with them and I can pipe any command with the options I 
already know and have used before to any other command.

As a developer on Linux based systems, I should not need to deal with 
code in a revision control system that is longer and less traceable 
because the authors of that system decided they wanted to support Windows 
too.  Moving away from the functionality that the shell provides is a 
mistake for a system such as git where it could be so advantageous because 
of the inherent nature of git as an information manager.

This is the reason why I was a fan of git long ago and used it for my own 
needs before tons of unnecessary features and unneeded complexity was 
added on.

		David



