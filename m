From: Tom Lord <lord@emf.net>
Subject: Re: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 16:04:00 -0700 (PDT)
Message-ID: <200504202304.QAA17069@emf.net>
References: <877jixfjxw.fsf@star.lifl.fr>
Cc: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Thu Apr 21 01:01:46 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOOC8-00049p-28
	for gcvad-gnu-arch-dev@gmane.org; Thu, 21 Apr 2005 01:01:20 +0200
Received: (qmail 11137 invoked by uid 110); 20 Apr 2005 23:05:38 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 3.356656 secs); 20 Apr 2005 23:05:38 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 20 Apr 2005 23:05:34 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 11086 invoked by uid 110); 20 Apr 2005 23:05:26 -0000
Received: from lord@emf.net by hera by uid 102 with qmail-scanner-1.20 
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 3.540126 secs); 20 Apr 2005 23:05:26 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 20 Apr 2005 23:05:22 -0000
Received: (qmail 28310 invoked from network); 21 Apr 2005 00:19:34 -0000
Received: from emf.emf.net (HELO emf.net) (205.149.0.19)
	by a1.mx.alal.us with SMTP; 21 Apr 2005 00:19:32 -0000
Received: (from lord@localhost) by emf.net (K/K) id QAA17069;
	Wed, 20 Apr 2005 16:04:00 -0700 (PDT)
To: duchier@ps.uni-sb.de
In-reply-to: <877jixfjxw.fsf@star.lifl.fr> (duchier@ps.uni-sb.de)
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=9.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.2
X-BeenThere: gnu-arch-dev@lists.seyza.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: a mailing list for GNU Arch developers <gnu-arch-dev.lists.seyza.com>
List-Unsubscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=unsubscribe>
List-Archive: <http://lists.seyza.com/pipermail/gnu-arch-dev>
List-Post: <mailto:gnu-arch-dev@lists.seyza.com>
List-Help: <mailto:gnu-arch-dev-request@lists.seyza.com?subject=help>
List-Subscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=subscribe>
Sender: gnu-arch-dev-bounces@lists.seyza.com
Errors-To: gnu-arch-dev-bounces@lists.seyza.com
X-Broken-Reverse-DNS: no host name found for IP address 207.166.200.220




   From: duchier@ps.uni-sb.de

Thank you for your experiment.  I'm not surprised by the 
result but it is very nice to know that my expectations
are right.

I think that to a large extent you are seeing artifacts
of the questionable trade-offs that (reports tell me) the
ext* filesystems make.   With a different filesystem, the 
results would be very different.

I'm imagining a blob database containing may revisions of the linux
kernel.  It will contain millions of blobs.

It's fine that some filesystems and some blob operations work fine
on a directory with millions of files but what about other operations
on the database?   I pity the poor program that has to `readdir' through
millions of files.

That said: I may add an optional flat-directory format to my library,
just to avoid issues such as those you raise over the next couple 
years.

-t
