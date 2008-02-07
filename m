From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 10:42:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org>
 <20080207142322.GC18497@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNBj1-0006jJ-EJ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 19:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYBGSnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYBGSnV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 13:43:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37928 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861AbYBGSnU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2008 13:43:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17IgGm5031435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2008 10:42:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17IgFxb016060;
	Thu, 7 Feb 2008 10:42:15 -0800
In-Reply-To: <20080207142322.GC18497@mail-vs.djpig.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72985>



On Thu, 7 Feb 2008, Frank Lichtenheld wrote:
> 
> Since git has no OpenSSL link exception the resulting binary wouldn't be
> distributable AFAIK.

For crazy people who think that regular libraries can change the copyright 
status of a program (not so), you can always decide to build without 
OpenSSL and use the included Mozilla-based SHA1 implementation for git.

Performance will probably suffer, and maybe something else breaks too (I 
doubt many people test the build that way very often), but I assume Debian 
people don't care.

After all, if you're a Debian person, it's likely more important to you to 
be difficult and anal and argue about theoretical license details than 
actually be *usable*.

		Linus
