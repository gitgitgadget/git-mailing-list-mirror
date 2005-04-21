From: duchier@ps.uni-sb.de
Subject: Re: [Gnu-arch-users] Re: [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 13:46:45 +0200
Message-ID: <878y3ce4ii.fsf@star.lifl.fr>
References: <200504201000.DAA04988@emf.net> <877jixfjxw.fsf@star.lifl.fr>
	<1114036849.5880.61.camel@perun.redhat.usu>
	<86d5soa42h.fsf@speedy.lifl.fr>
	<1114078877.5886.37.camel@perun.redhat.usu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gnu-arch-dev@lists.seyza.com, talli@museatech.net, git@vger.kernel.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Thu Apr 21 13:56:24 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOaH4-0001yU-NU
	for gcvad-gnu-arch-dev@gmane.org; Thu, 21 Apr 2005 13:55:15 +0200
Received: (qmail 12065 invoked by uid 110); 21 Apr 2005 11:59:34 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 0.204484 secs); 21 Apr 2005 11:59:34 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 21 Apr 2005 11:59:32 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 12034 invoked by uid 110); 21 Apr 2005 11:59:28 -0000
Received: from duchier@ps.uni-sb.de by hera by uid 102 with qmail-scanner-1.20
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 0.087564 secs); 21 Apr 2005 11:59:28 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 21 Apr 2005 11:59:28 -0000
Received: (qmail 4794 invoked from network); 21 Apr 2005 13:13:39 -0000
Received: from reserv6.univ-lille1.fr (193.49.225.20)
	by a1.mx.alal.us with SMTP; 21 Apr 2005 13:13:37 -0000
Received: from malonne.lifl.fr (malonne.lifl.fr [134.206.10.29])
	by reserv6.univ-lille1.fr (8.13.3/jtpda-5.3.1) with ESMTP id
	j3LBkkk3010456 ; Thu, 21 Apr 2005 13:46:46 +0200
Received: from star.lifl.fr (star.lifl.fr [134.206.10.23])
	by malonne.lifl.fr  with ESMTP id j3LBkj624481
	; Thu, 21 Apr 2005 13:46:45 +0200 (MEST)
To: Tomas Mraz <t8m@centrum.cz>
In-Reply-To: <1114078877.5886.37.camel@perun.redhat.usu> (Tomas Mraz's message
	of "Thu, 21 Apr 2005 12:21:16 +0200")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: duchier@ps.uni-sb.de
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=9.0 tests=BAYES_00,NO_REAL_NAME 
	autolearn=no version=3.0.2
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

Tomas Mraz <t8m@centrum.cz> writes:

>> Btw, if, as you indicate above, you do believe that a 1 level indexing should
>> use [0:2], then it doesn't make much sense to me to also suggest that a 2 level
>> indexing should use [0:1] as primary subkey :-)
>
> Why do you think so? IMHO we should always target a similar number of
> files/subdirectories in a directories of the blob archive. So If I
> always suppose that the archive would contain at most 16 millions of
> files then the possible indexing schemes are either 1 level with key
> length 3 (each directory would contain ~4096 files) or 2 level with key
> length 2 (each directory would contain ~256 files).
> Which one is better could be of course filesystem and hardware
> dependent.

First off, I have been using python slice notation, so when I write [0:2] I mean
a key of length 2 (the second index is not included).  I now realize that when
you wrote the same you meant to include the second index.

I believe that our disagreement comes from the fact that we are asking different
questions.  You consider the question of how to best index a fixed database and
I consider the question of how to best index an ever increasing database.

Now consider why we even want multiple indexing levels: presumably this is
because certain operations become too costly when the size of a directory
becomes too large.  If that's not the case, then we might as well just have one
big flat directory - perhaps that's even a viable option for some
filesystems.[1]

  [1] there is the additional consideration that a hierarchical system
  implements a form of key compression by sharing key prefixes.  I don't know at
  what point such an effect becomes beneficial, if ever.

Now suppose we need at least one level of indexing.  Under an assumption of
uniform distribution of bits in keys, as more objects are added to the database,
the lower levels are going to fill up uniformly.  Therefore at those levels we
are again faced with exactly the same indexing problem and thus should come up
with exactly the same answer.

This is why I believe that the scheme I proposed is best: when a bottom level
directory fills up past a certain size, introduce under it an additional level,
and reindex the keys.  Since the "certain size" is fixed, this is a constant
time operation.

One could also entertain the idea of reindexing not just a bottom level
directory but an entire subtree of the database (this would be closer to your
idea of finding an optimal reindexing of just this part of the database).
However this has the disadvantage that the operation's cost grows exponentially
with the depth of the tree.

Cheers,

--Denys
