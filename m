From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Wed, 24 Oct 2007 10:17:46 +1000
Message-ID: <18206.36650.787899.517514@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
	<18201.34779.27836.531742@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
	<18205.15967.792413.775786@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710231214150.30120@woody.linux-foundation.org>
	<18206.34254.741787.255299@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710231647350.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkTwj-0007rB-Di
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 02:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXJXARy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbXJXARy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 20:17:54 -0400
Received: from ozlabs.org ([203.10.76.45]:40959 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbXJXARx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 20:17:53 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 403B4DDF33; Wed, 24 Oct 2007 10:17:51 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0710231647350.30120@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62174>

Linus Torvalds writes:

> Happened for just a random directory I tested. According to my bash 
> history, it seems to have been
> 
> 	gitk v2.6.23.. drivers/char/

Ahhhh...  It's the slash on the end that does it (it works properly
without the slash).  I just pushed out a fix for that (and a couple of
other bugs I just found).

Paul.
