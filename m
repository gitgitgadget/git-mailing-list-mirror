From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: force focus to main window
Date: Thu, 18 Dec 2008 15:09:44 +1100
Message-ID: <18761.52488.206887.985268@cargo.ozlabs.ibm.com>
References: <4948E771.4050705@viscovery.net>
	<18761.29020.237388.687560@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.00.0812180413240.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 05:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDAEK-0004Pr-S2
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 05:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYLREKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 23:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYLREJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 23:09:59 -0500
Received: from ozlabs.org ([203.10.76.45]:50824 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbYLREJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 23:09:59 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 43CFCDDF28; Thu, 18 Dec 2008 15:09:58 +1100 (EST)
In-Reply-To: <alpine.DEB.1.00.0812180413240.14632@racer>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103431>

Johannes Schindelin writes:

> > At least put a if {[tk windowingsystem] eq "win32"} in there. (msysGit 
> > is a windows thing, isn't it?)
> 
> Yeah, because on other platforms, when you start gitk, you don't want it 
> to take focus.  Yeah, right.

No - on other platforms I have a window manager that gives focus to
new applications automatically.  Or, if I don't want new applications
to grab the focus, I tell the window manager that that's what the
policy should be.  Either way the application shouldn't forcibly and
unilaterally grab the focus.

I'm prepared (predisposed, even :-) to believe that windows sucks, so
I'll take the patch if it only affects windows.

Paul.
