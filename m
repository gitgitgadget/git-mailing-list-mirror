From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Attn - repository browser authors] diff-tree combined format.
Date: Sat, 4 Feb 2006 22:23:25 +1100
Message-ID: <17380.36525.368645.768586@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	<7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
	<7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 12:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5LrO-0004rl-0U
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 12:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWBDLpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 06:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBDLpm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 06:45:42 -0500
Received: from ozlabs.org ([203.10.76.45]:38374 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932395AbWBDLpl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 06:45:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1329368A51; Sat,  4 Feb 2006 22:45:40 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15586>

Junio C Hamano writes:

>     (1) keep the index line, but format it like this:

At this stage, I don't think gitk will need the index line.

>     (2) match line numbers in the hunk header to normal diff's
>         order:
> 
> 	@@@ -1,87 -1,3 +1,93 @@@

I think that will look better.

Paul.
