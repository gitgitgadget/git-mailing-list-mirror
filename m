From: Paul Mackerras <paulus@samba.org>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 21:19:54 +1100
Message-ID: <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntwA-0008VL-0q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbXKBKjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbXKBKjX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:39:23 -0400
Received: from ozlabs.org ([203.10.76.45]:59041 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbXKBKjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:39:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1E0F7DDE18; Fri,  2 Nov 2007 21:39:20 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63100>

Linus Torvalds writes:

> If that's the only reason for using it, then please stop, and use 
> "--first-parent" instead.

How would that help?  That doesn't list about 2/3 of the commits at
all.

In any case, no that's not the only reason.  The main reason is that
it (i.e. --topo-order) spits out the commits in exactly the order that
gitk wants to display them (of which the bit about parents coming
after all their children is a part), and thus reduces the amount of
processing I need to do in Tcl.

Paul.
