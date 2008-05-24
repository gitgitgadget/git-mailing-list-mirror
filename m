From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Sat, 24 May 2008 20:51:17 +1000
Message-ID: <18487.62245.59892.442935@cargo.ozlabs.ibm.com>
References: <20080523012857.acce6457.chriscool@tuxfamily.org>
	<7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 24 12:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzrOG-0002uA-SX
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 12:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbYEXKxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 06:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbYEXKxH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 06:53:07 -0400
Received: from ozlabs.org ([203.10.76.45]:35688 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459AbYEXKwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 06:52:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B84EADE0FB; Sat, 24 May 2008 20:52:45 +1000 (EST)
In-Reply-To: <alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82807>

Linus Torvalds writes:

> This is a general problem in gitk. 
> 
> It's worse than not showing a label, btw. If it doesn't realize what the 
> HEAD is (and it won't), it also doesn't show the fake "uncommitted 
> changes" commit(s).

I could make it show "HEAD" in a green box for a detached head easily
enough.  That could be ambiguous if you had a branch called HEAD, I
suppose, but having a branch called HEAD would be deeply confusing
anyway. :)  Do you have any alternative suggestion for how to display
a detached head?

Paul.
