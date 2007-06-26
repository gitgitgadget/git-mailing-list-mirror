From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: gitweb bug?
Date: Mon, 25 Jun 2007 22:14:42 -0700
Message-ID: <1182834882.3736.19.camel@localhost.localdomain>
References: <905315640706242315v3f649ef5w2a0706d0c4c68d8e@mail.gmail.com>
	 <200706260205.49337.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tarmigan Casebolt <tarmigan@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 07:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I33mP-0001hq-6A
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 07:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbXFZFj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 01:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbXFZFj4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 01:39:56 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:43166 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbXFZFjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 01:39:55 -0400
X-Greylist: delayed 1514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2007 01:39:55 EDT
Received: from [10.255.255.26] (unassigned-114.072.NetSurf.Net [66.135.114.72] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l5Q5EZac017302
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 25 Jun 2007 22:14:36 -0700
In-Reply-To: <200706260205.49337.jnareb@gmail.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: ClamAV 0.88.7/3523/Mon Jun 25 07:30:33 2007 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50949>

I'm not seeing anything horrible per se in what it's doing - If you can
provide a list of the files it should be listing I'd be appreciative.

For instance on a $random machine with a 2.6.9 tree open on it that I
have at work I'm seeing:

[netlink]$ ls
af_netlink.c  af_netlink.o  built-in.o  Makefile  netlink_dev.c
netlink_dev.o
[netlink]$ pwd
..../linux-2.6.9/net/netlink
[netlink]$

So yeah - some further information on the problem your seeing would be
helpful as I don't have a tree checked out either right now.

- John 'Warthog9' Hawley

On Tue, 2007-06-26 at 02:05 +0200, Jakub Narebski wrote:
> On Mon, 25 June 2007, Tarmigan Casebolt wrote:
> >
> > I was looking through the kernel source and noticed a difference
> > between the git version and the gitweb version here:
> > http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=net/netlink
> > on gitweb, I only see 4 files, but in git locally on linux I see 71.
> > 
> > This might be because there are files that differ only in case?  (I'm
> > using OSX, which has problems with case, and in particular that
> > directory of the kernel source.)
> > 
> > Am I missing something, or is this a bug?
> 
> First of all, this question should be asked IMVHO on git mailing list,
> with Cc: sent to Kernel.Org admins or John 'Warthog9' Hawley, author of
> the gitweb modification (caching gitweb) used at kernel.org
> 
> I cannot help you what the contents of net/netlink should look like,
> because I don't have clone of the linux kernel repository. By "in git
> locally on linux" you mean in the working area? Or perhaps result of
> "git ls-tree HEAD:net/netlink"? You should have provided command used
> to get those 71 files, and perhaps even those 71 files list.
> 
