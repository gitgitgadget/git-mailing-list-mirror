From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use diff* with --exit-code in git-am, git-rebase and git-merge-ours
Date: Sun, 25 Mar 2007 01:49:53 +0100
Message-ID: <20070325004953.GC11507@steel.home>
References: <20070325004256.GB11507@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 01:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVGw5-00032Z-TR
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 01:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXCYAt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 20:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXCYAt4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 20:49:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56969 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbXCYAtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 20:49:55 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Mar 2007 20:49:55 EDT
Received: from tigra.home (Fc89f.f.strato-dslnet.de [195.4.200.159])
	by post.webmailer.de (klopstock mo35) (RZmta 5.4)
	with ESMTP id E074f8j2P06Zbq ; Sun, 25 Mar 2007 01:49:54 +0100 (MET)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D423F277B6;
	Sun, 25 Mar 2007 01:49:53 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AF47CBF79; Sun, 25 Mar 2007 01:49:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070325004256.GB11507@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a4mM=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43024>

Alex Riesen, Sun, Mar 25, 2007 01:42:56 +0100:
> This simplifies the shell code and reduces memory footprint, speeds
> things up. The performance improvements should be noticable by
> git-rebase, when it is used to rebase big commits.

Please ignore, I forgot about "--quiet implies --exit-code" again.
Just documented the option. Will resend.
