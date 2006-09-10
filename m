From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 08:41:20 +1000
Message-ID: <17668.38032.20688.991295@cargo.ozlabs.ibm.com>
References: <20060910190332.17667.qmail@science.horizon.com>
	<Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, jonsmirl@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 00:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMXzd-00043p-Cp
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWIJWl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIJWl1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 18:41:27 -0400
Received: from ozlabs.org ([203.10.76.45]:61324 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932164AbWIJWl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 18:41:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 243A367B93; Mon, 11 Sep 2006 08:41:26 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26820>

Linus Torvalds writes:

> So we may do a fork/exit in a millisecond, but on the other hand, we can 
> generally open a file in a microsecond. So we're definitely talking about 
> several orders of magnitude difference..

Unless the file isn't in memory, in which case it's probably around a
millisecond or more...

Do you think there is any way to speed up the cold-cache case for
git-ls-remote and git-rev-parse with thousands of heads and tags?

Paul.
