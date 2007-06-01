From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Fri, 01 Jun 2007 09:13:57 +0200
Organization: eudaptics software gmbh
Message-ID: <465FC735.C78ACD5@eudaptics.com>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site> <20070531002030.GA15714@spearce.org> <7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net> <20070601030959.GY7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 09:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1Jx-0001vP-4b
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbXFAHNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXFAHNJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:13:09 -0400
Received: from main.gmane.org ([80.91.229.2]:50531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753AbXFAHNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 03:13:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hu1Jm-0007rQ-OX
	for git@vger.kernel.org; Fri, 01 Jun 2007 09:13:02 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 09:13:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 09:13:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48846>

"Shawn O. Pearce" wrote:
> Why cat?  Tcl is so horribly broken that to get data for both stdout
> and stderr through a pipe I have to do something sick like:
> 
>         git fetch 2>&1 | cat
> 
> because in Tcl its actually:
> 
>         set rdr [open "| git fetch |& cat" r]
> 
> The |& means 2>&1| in normal shell.  But that means I have to have
> a process after it to receive the data.  Normally that's cat.
> But MinGW doesn't have cat.  (Nor do they have dog, but neither
> does Linux...).  So I need a way to redirect output.

Are you planning for the future? Currently, the MinGW port works only
with MSYS installed and $MSYS/bin in your PATH because the shell scripts
need an assorted set of POSIX tools. MSYS does ship 'cat', of course.

-- Hannes
