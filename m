From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Sat, 4 Feb 2006 16:38:36 +1100
Message-ID: <17380.15836.61062.401906@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:39:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5G8X-00056R-5t
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 06:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946303AbWBDFis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 00:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946304AbWBDFis
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 00:38:48 -0500
Received: from ozlabs.org ([203.10.76.45]:61404 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946303AbWBDFis (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 00:38:48 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 52B0A68A46; Sat,  4 Feb 2006 16:38:47 +1100 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15569>

Linus Torvalds writes:

> In fact, git-diff-tree now gets the subtle cases right for things that 
> "gitk" for some reason gets wrong. I haven't figured out what's wrong with 
> gitk, but I don't think it's even worth it: it would be better to just 
> teach gitk to use git-diff-tree --cc.

Working on it now.  That will let me cut out about 500 lines of pretty
hairy Tcl code from gitk, which is nice.

Paul.
