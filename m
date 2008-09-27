From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Sat, 27 Sep 2008 13:18:04 +1000
Message-ID: <18653.42476.355550.345797@cargo.ozlabs.ibm.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
	<alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
	<BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 05:19:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjQL7-0000cA-Dw
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 05:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYI0DSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 23:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYI0DSO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 23:18:14 -0400
Received: from ozlabs.org ([203.10.76.45]:39352 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbYI0DSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 23:18:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6E93ADDDEA; Sat, 27 Sep 2008 13:18:11 +1000 (EST)
In-Reply-To: <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96898>

Wincent Colaiuta writes:

> It's a shame that tcl/tk regular expressions don't appear to support  
> anchoring matches against word boundaries (ie. "\b").

They do.  From the re_syntax (3tcl) man page:

         \m    matches only at the beginning of a word

         \M    matches only at the end of a word

         \y    matches only at the beginning or end of a word

         \Y    matches only at a point that is not the beginning or end  of  a
               word

Paul.
