From: Tom Lord <lord@emf.net>
Subject: Re: [Gnu-arch-users] Re: [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 12:04:08 -0700 (PDT)
Message-ID: <200504211904.MAA04791@emf.net>
References: <1114037509.5880.62.camel@perun.redhat.usu>
Cc: gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Thu Apr 21 21:00:24 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOguH-0003l8-2d
	for gcvad-gnu-arch-dev@gmane.org; Thu, 21 Apr 2005 21:00:10 +0200
Received: (qmail 14558 invoked by uid 110); 21 Apr 2005 19:04:34 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 3.049208 secs); 21 Apr 2005 19:04:34 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 21 Apr 2005 19:04:30 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 14518 invoked by uid 110); 21 Apr 2005 19:04:22 -0000
Received: from lord@emf.net by hera by uid 102 with qmail-scanner-1.20 
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 4.253263 secs); 21 Apr 2005 19:04:22 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 21 Apr 2005 19:04:17 -0000
Received: (qmail 8220 invoked from network); 21 Apr 2005 20:18:30 -0000
Received: from emf.emf.net (HELO emf.net) (205.149.0.19)
	by a1.mx.alal.us with SMTP; 21 Apr 2005 20:18:28 -0000
Received: (from lord@localhost) by emf.net (K/K) id MAA04791;
	Thu, 21 Apr 2005 12:04:08 -0700 (PDT)
To: t8m@centrum.cz
In-reply-to: <1114037509.5880.62.camel@perun.redhat.usu> (message from Tomas
	Mraz on Thu, 21 Apr 2005 00:51:49 +0200)
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


  > Using your suggested indexing method that uses [0:4] as the 1st level key and
                                                 [0:3]
  > [4:8] as the 2nd level key, I obtain an indexed archive that occupies 159M,
  > where the top level contains 18665 1st level keys, the largest first level dir
  > contains 5 entries, and all 2nd level dirs contain exactly 1 entry.


That's just a mistake in the spec.  The format should probably be
multi-level but, yes, the fanout I suggested is currently quite bogus.
When I write that part of that code (today or tomorrow) I'll fix it.

A few people pointed that out.  Thanks.

-t
