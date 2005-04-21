From: Tomas Mraz <t8m@centrum.cz>
Subject: Re: [Gnu-arch-users] Re: [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 09:49:18 +0200
Message-ID: <1114069758.5886.9.camel@perun.redhat.usu>
References: <200504202304.QAA17069@emf.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Thu Apr 21 09:46:08 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOWN3-0000ek-BL
	for gcvad-gnu-arch-dev@gmane.org; Thu, 21 Apr 2005 09:45:09 +0200
Received: (qmail 24416 invoked by uid 110); 21 Apr 2005 07:49:32 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 0.115338 secs); 21 Apr 2005 07:49:32 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 21 Apr 2005 07:49:31 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 24386 invoked by uid 110); 21 Apr 2005 07:49:27 -0000
Received: from t8m@centrum.cz by hera by uid 102 with qmail-scanner-1.20 
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 0.085337 secs); 21 Apr 2005 07:49:27 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 21 Apr 2005 07:49:27 -0000
Received: (qmail 22839 invoked from network); 21 Apr 2005 09:03:37 -0000
Received: from admin.kkcable.cz (213.29.14.23)
	by a1.mx.alal.us with SMTP; 21 Apr 2005 09:03:34 -0000
Received: by admin.kkcable.cz (Postfix, from userid 1007)
	id 930EE61282; Thu, 21 Apr 2005 09:49:20 +0200 (CEST)
Received: from admin.kkcable.cz (admin.kkcable.cz [213.29.14.23])
	by admin.kkcable.cz (Postfix) with SMTP id BF68C61273;
	Thu, 21 Apr 2005 09:49:19 +0200 (CEST)
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504202304.QAA17069@emf.net>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=9.0 tests=BAYES_00 autolearn=ham 
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

On Wed, 2005-04-20 at 16:04 -0700, Tom Lord wrote:

> I think that to a large extent you are seeing artifacts
> of the questionable trade-offs that (reports tell me) the
> ext* filesystems make.   With a different filesystem, the 
> results would be very different.
Tom, please stop this ext* filesystem bashing ;-) Even with filesystem
which compresses the tails of files into one filesystem block it
wouldn't make a difference that there are potentially (and very probably
even with blob numbers in order of 100000) 65536 directories on the
first level. This doesn't help much in fast reading the first level.

> I'm imagining a blob database containing may revisions of the linux
> kernel.  It will contain millions of blobs.
> 
> It's fine that some filesystems and some blob operations work fine
> on a directory with millions of files but what about other operations
> on the database?   I pity the poor program that has to `readdir' through
> millions of files.

Even with milions of files this key structure doesn't make much sense -
the keys on the first and second levels are too long. However you're
right that the original structure proposed by Linus is too flat.

-- 
Tomas Mraz <t8m@centrum.cz>
