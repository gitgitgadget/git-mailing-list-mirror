From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Stashing untracked files
Date: Sun, 30 Sep 2007 10:41:47 +0200
Message-ID: <E505AC4A-FDCB-4D9D-9CF7-C68CBC20BFFD@zib.de>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site> <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr> <46FEC799.30803@theory.org> <Pine.LNX.4.64.0709292259070.28395@racer.site> <46FF1F1E.2050000@theory.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Neil Macneale <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 10:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbuLj-0005sn-Ep
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 10:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbXI3IkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbXI3IkS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 04:40:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:39420 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbXI3IkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 04:40:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8U8eCDX022149;
	Sun, 30 Sep 2007 10:40:13 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db10737.pool.einsundeins.de [77.177.7.55])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8U8eBqf012242
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 30 Sep 2007 10:40:11 +0200 (MEST)
In-Reply-To: <46FF1F1E.2050000@theory.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59530>


On Sep 30, 2007, at 5:59 AM, Neil Macneale wrote:

> git stash is an acknowledgment that not everything needs to be  
> committed, and sometimes working source trees are messy. Prior to  
> the stash command, I just accepted that I'd need to commit  
> everything and do  some maintenance to un-commit those changes.  
> stash is awesome for me and the realities of the way I need to  
> work. IMHO, it would be the best thing since sliced bread if it  
> handled untracked files.

I agree, it could be a great tool. Even only to make me feel better
before running 'git clean' on a larger source tree when I was to
lazy to scan 'git clean -n' in detail.

BTW, I don't have results of the builds in my work tree but keep
them in a separate directory. Nearly everything in the work tree
is 'real' source code, maybe cluttered with some backups or tmp files.


> If this is really just a problem for me, I can write a shell script  
> to do the dirty work. I just wonder if it is a common enough use  
> case that it merits support in the tool itself.

I think it would be useful. Here is a problem I ran into last week:

A merge failed because it wanted to add a file not tracked by
the current branch. At first I didn't fully appreciate this fact
and thought that 'git stash' could help. But to do so, it would
need to store the _untracked_ file and remove it from the work tree.
This would allow the merge to succeed. Current stash didn't really
help.

	Steffen
