From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Tue, 21 Oct 2008 10:20:12 +1100
Message-ID: <18685.4652.287143.717452@cargo.ozlabs.ibm.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:36:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks45x-0001X9-18
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYJTXWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYJTXWO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:22:14 -0400
Received: from ozlabs.org ([203.10.76.45]:48471 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbYJTXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:22:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 00FB4DDE04; Tue, 21 Oct 2008 10:22:04 +1100 (EST)
In-Reply-To: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98743>

Linus Torvalds writes:

> And the thing I wanted to work was to have the abbreviated SHA1's that 
> have started to get more common in the kernel commit logs work as links in 
> gitk too, just the way a full 40-character SHA1 link works.

I just pushed out a commit to gitk that makes this work, and fixes the
other bugs you mentioned.

Paul.
