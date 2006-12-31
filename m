From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 31 Dec 2006 16:04:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612311602160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 16:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H12F9-0007FX-Jt
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 16:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189AbWLaPEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 10:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933190AbWLaPEz
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 10:04:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:37117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933189AbWLaPEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 10:04:54 -0500
Received: (qmail invoked by alias); 31 Dec 2006 15:04:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 31 Dec 2006 16:04:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35698>

Hi,

On Sun, 31 Dec 2006, Junio C Hamano wrote:

> * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
>  + git-merge: preserve and merge local changes when doing fast
>    forward
> 
> A few people wanted to have this in v1.5.0, but I am a bit reluctant to 
> do so --- I think the behaviour of its failure mode is rather nasty, 
> even though it tries to help the user by dropping the local diff in 
> .git/LOCAL_DIFF file.

I am not urging the inclusion in 1.5.0, but how about storing not the 
diff, but the _state_ in .git/UNCOMMITTED_TREE? This would work with all 
the git tools without any problem, and git-gc would eventually clean up 
older intermediate stages.

Ciao,
Dscho
