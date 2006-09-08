From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 09:45:18 +1000
Message-ID: <17666.142.886652.667529@cargo.ozlabs.ibm.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 03:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLrHk-0004uz-9x
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 03:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWIIBFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWIIBFW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 21:05:22 -0400
Received: from ozlabs.org ([203.10.76.45]:15750 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751271AbWIIBFU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 21:05:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A21A667B96; Sat,  9 Sep 2006 11:05:19 +1000 (EST)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26727>

Jon Smirl writes:

> gitk takes about a minute to come up on the Mozilla repo when
> everything is in cache. It  takes about twice as long when things are
> cold. It's enough of delay that I don't use the tool.

How long does it take for git rev-list --topo-order to produce its
first line of output, in the cache-hot case?  That is, is it just
gitk's graph layout that is taking the time, or is it git rev-list
(meaning that gitk needs to stop using --topo-order)?

Paul.
