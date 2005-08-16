From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Importing from CVS issues
Date: Tue, 16 Aug 2005 17:09:13 +0100
Message-ID: <1124208553.7444.47.camel@okra.transitives.com>
References: <1124188894.7444.9.camel@okra.transitives.com>
	 <46a038f90508160426450eff12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 18:12:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E541D-0000J2-9s
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 18:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVHPQKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVHPQKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 12:10:16 -0400
Received: from smarthost3.mail.uk.easynet.net ([212.135.6.13]:41481 "EHLO
	smarthost3.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S1030212AbVHPQKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 12:10:14 -0400
Received: from [217.207.128.220] (helo=mx.transitive.com)
	by smarthost3.mail.uk.easynet.net with esmtp (Exim 4.10)
	id 1E540z-000JCk-00; Tue, 16 Aug 2005 17:10:13 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508160426450eff12@mail.gmail.com>
X-Mailer: Evolution 2.2.1 
X-TL-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-08-16 at 23:26 +1200, Martin Langhoff wrote:
> I haven't seen this problem myself. There are some recent patches
> Junio merged that handle some oddities better. Give the 'pu' branch a
> go if you can.

I'll look at that in a bit. I already picked up a few of the patches
mentioned on the list.

> I take it that the repo is not public. I'd like to try and reproduce
> the problem. Can you get it to happen with a public repository?

I'm afraid not. However I think I've found a problem when I tried
running cvsps on its own to generate the patchset. It seems that
REV_STR_MAX (cvsps-2.1/cvsps_types.h) wasn't big enough to contain some
of our version strings.

This will be a feature of our development process which means all
changes are based of branches, some of which branch multiple times and
live for a long time before code is merged into the mainline. I don't
know if any open source projects use CVS in such a way.

My import seems to be getting a lot further now. I now just need to
clean out the corrupted files that are breaking cvs log.

--
Alex, homepage: http://www.bennee.com/~alex/
New systems generate new problems.
