From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:15:22 +0200
Message-ID: <20050628151522.GO5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <42BC112C.1040009@qualitycode.com> <20050628150752.GC1275@pasky.ji.cz>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Smith <yarcs@qualitycode.com>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Tue Jun 28 17:23:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHvA-0002it-8n
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 17:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVF1P3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 11:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVF1P3u
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 11:29:50 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:49811 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262061AbVF1P3q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 11:29:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id ECC8A4BF7B
	for <git@vger.kernel.org>; Tue, 28 Jun 2005 17:29:44 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 799684BF5C
	for <git@vger.kernel.org>; Tue, 28 Jun 2005 17:29:42 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 64837AED87
	for <git@vger.kernel.org>; Tue, 28 Jun 2005 17:29:42 +0200 (CEST)
Received: (qmail 16094 invoked by uid 500); 28 Jun 2005 15:15:22 -0000
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Kevin Smith <yarcs@qualitycode.com>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Disposition: inline
In-Reply-To: <20050628150752.GC1275@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 05:07:52PM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Jun 24, 2005 at 03:57:00PM CEST, I got a letter
> where Kevin Smith <yarcs@qualitycode.com> told me that...
> > - Can run on (native) MS Windows
> >   (necessary for me because I often work on cross-platform projects)
> 
> I'd expect everything to work fine with Cygwin (or with only minor
> problems easy to fix) or just any working bash + GNU coreutils
> installation. Any issue with that?

The code is full of Unixisms.  You'd almost think that the authors
of git have some kind of affinity towards Unix.

i386-mingw32-gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-cache.o read-cache.c
In file included from read-cache.c:6:
cache.h:14:22: sys/mman.h: No such file or directory
cache.h:16:24: netinet/in.h: No such file or directory
In file included from read-cache.c:6:
cache.h: In function `create_ce_mode':
cache.h:104: warning: implicit declaration of function `S_ISLNK'
cache.h:105: warning: implicit declaration of function `htonl'
cache.h:105: error: `S_IFLNK' undeclared (first use in this function)
cache.h:105: error: (Each undeclared identifier is reported only once
cache.h:105: error: for each function it appears in.)
[..]
read-cache.c:376: warning: implicit declaration of function `mmap'
read-cache.c:376: error: `PROT_READ' undeclared (first use in this function)
read-cache.c:376: error: `PROT_WRITE' undeclared (first use in this function)
read-cache.c:376: error: `MAP_PRIVATE' undeclared (first use in this function)
read-cache.c:376: warning: assignment makes pointer from integer without a cast
read-cache.c:399: warning: implicit declaration of function `munmap'
[..]

skimo
