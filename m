From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 18:23:09 -0400 (EDT)
Message-ID: <3993.10.10.10.24.1119997389.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
	<62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
	<3886.10.10.10.24.1119991512.squirrel@linux1>
	<20050628221422.GT12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 00:17:53 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnOOh-0007l4-Db
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 00:17:39 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMOcMc019948;
	Tue, 28 Jun 2005 17:24:39 -0500
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net
	[206.47.199.141])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMNKaQ019747;
	Tue, 28 Jun 2005 17:23:21 -0500
Received: from linux1 ([69.156.137.160]) by simmts12-srv.bellnexxia.net
	(InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
	id <20050628222309.IMDL1005.simmts12-srv.bellnexxia.net@linux1>;
	Tue, 28 Jun 2005 18:23:09 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j5SMN3UT016674;
	Tue, 28 Jun 2005 18:23:03 -0400
Received: from 10.10.10.24 (SquirrelMail authenticated user sean)
	by linux1 with HTTP; Tue, 28 Jun 2005 18:23:09 -0400 (EDT)
In-Reply-To: <20050628221422.GT12006@waste.org>
To: "Matt Mackall" <mpm@selenic.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Tue, June 28, 2005 6:14 pm, Matt Mackall said:
>> You can even have a setup where objects
>> are archived onto write-once media like DVD and still participate in a
>> live repository, where new objects are written to hard disk, but older
>> object are (automatically) sourced from the DVD.
>
> Have fun with that. It's an excellent way to destroy your DVD drive.

Oh come on, stop the FUD.   You pack all the objects up into a single pack
file (see new feature in Git) and you burn it _once_ to dvd or cdrom.

>
> Git's completely structureless filename hashing pretty much guarantees
> that disk layout will degrade to worst-case random access behavior
> over time. Just walking through the 2000 commit blobs in the current
> tree can take minutes cold cache on a fast hard disk. Walking the 1700
> tree blobs in a given version takes quite a while too.
>
> Put that on a DVD and that could easily turn into hours of continuous
> seeking for a simple operation like checking out tip of tree.
>
> And as far as I know, ISO9660 and UDF don't really handle huge
> directories well. So if you try and put the whole kernel history (200k
> files, some huge number of directory blobs, and 30k-60k commit blobs)
> on a DVD, you'll be really hurting.
>
> Meanwhile the whole history (>30k changesets) with Mercurial fits on a
> regular CD, with reasonable directory sizes and I/O patterns.
>
> Not that it's really worth the trouble. It takes longer for me to burn
> an ISO image to disc than to download a complete kernel repo from
> kernel.org.
>

Git is still developing, there will be new ways to seek and cache things
etc eventually that remove any performance issue.  Git gets this right, it
concentrates on what is important, stays flexible and trusts that down the
road as things mature any performance problems can be dealt with.

It already has some tools that are better than BK ever had (gitk, gitweb,
etc..)

Cheers,
Sean
