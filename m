From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git 1.5.3.5 error over NFS
Date: Sat, 10 Nov 2007 00:21:06 +0100
Message-ID: <20071109232106.GA3435@steel.home>
References: <18228.32091.865519.312011@lisa.zopyra.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdBg-0000RD-OS
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757746AbXKIXVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759086AbXKIXVN
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:21:13 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32786 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbXKIXVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:21:12 -0500
Received: from tigra.home (Fc883.f.strato-dslnet.de [195.4.200.131])
	by post.webmailer.de (fruni mo37) (RZmta 14.0)
	with ESMTP id 4021f5jA9HuBHW ; Sat, 10 Nov 2007 00:21:07 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 06D90277AE;
	Sat, 10 Nov 2007 00:21:06 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7CB7D56D22; Sat, 10 Nov 2007 00:21:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18228.32091.865519.312011@lisa.zopyra.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+cUM8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64275>

Bill Lear, Fri, Nov 09, 2007 16:31:39 +0100:
> I've brought this up before, but I don't recall a resolution to it.
> 
> We have an NFS-mounted filesystem, and git pull is choking on it.
> 
> % uname -a
> Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux
> 
> % git --version
> git version 1.5.3.5
> 
> % git pull
> remote: Generating pack...
> remote: Done counting 998 objects.
> remote: Result has 836 objects.
> remote: Deltifying 836 objects.
> remote:  100% (836/836) done
> Indexing 836 objects...
> remote: Total 836 (delta 526), reused 688 (delta 380)
>   100% (836/836) done
> Resolving 526 deltas...
> fatal: cannot pread pack file: No such file or directory

Could you please strace it? With strace -ff?

> fatal: index-pack died with error code 128
> fatal: Fetch failure: git://source/repo
> 
> I looked through the archives of this list and did not see a final
> resolution, other than a suspected bug in the OS NFS code.

Strace, just to be on the safe side
