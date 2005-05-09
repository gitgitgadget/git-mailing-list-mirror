From: Paul Mackerras <paulus@samba.org>
Subject: Re: Prototype git commit viewer
Date: Tue, 10 May 2005 08:12:13 +1000
Message-ID: <17023.57405.35272.46557@cargo.ozlabs.ibm.com>
References: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
	<20050509071341.GA3599@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:06:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGNS-0005au-A2
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVEIWM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVEIWM2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:12:28 -0400
Received: from ozlabs.org ([203.10.76.45]:30426 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261542AbVEIWMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 18:12:16 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 123AB679F5; Tue, 10 May 2005 08:12:14 +1000 (EST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050509071341.GA3599@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis writes:

> What are its advantages to git-viz?

As a kernel developer, when I do a pull from Linus' tree, the question
I want to ask is "who has been making what changes?"  That's why gitk
shows the headline and author of each of 30 commits in one screenful.
AFAICS from the screenshots, git-viz doesn't give me that density of
information (and neither did bk revtool, for that matter).

It seems to me that git-viz makes the graph topology the primary thing
and the details of the commits the secondary thing.  I want it the
other way around.

Paul.
