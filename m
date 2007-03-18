From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 13:18:10 +0100
Message-ID: <20070318121810.GA17807@moooo.ath.cx>
References: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 13:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSuL1-0007kU-HL
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 13:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXCRMSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 08:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXCRMSO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 08:18:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:45877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751473AbXCRMSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 08:18:13 -0400
Received: (qmail invoked by alias); 18 Mar 2007 12:18:11 -0000
X-Provags-ID: V01U2FsdGVkX19GHDki/uNGCLS/WTBv3Bv6M2KHd0AEqb22HwUm+F
	pDkedGjH/5+qY3
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42492>

Junio C Hamano <junkio@cox.net> wrote:
> A	B	Outcome
> ----------------------------------------------------------------
> D	D	No problem.
> 
> D	F	This should result in refusal when there are
>                 local modification to paths in "foo" directory,
> 		or there are untracked (but unignored) paths in
>                 "foo/".

What about ignored configuration files like config.mak?
Let's say there is an ignored configuration file in a subdirectory.
If this subdirectory is replaced by a file git would delete the
ignored configuration file?
