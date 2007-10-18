From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 21:17:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710172102020.26902@woody.linux-foundation.org>
References: <1192565900.6430.16.camel@athena>
 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net> <Pine.LNX.4.64.0710172002020.10276@asgard.lang.hm>
 <20071018030055.GA7218@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710172017020.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: david@lang.hm, Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiMpJ-0004iJ-7M
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbXJRER3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbXJRER3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:17:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55446 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbXJRER2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 00:17:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I4H89S019139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 21:17:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I4H3pi024848;
	Wed, 17 Oct 2007 21:17:05 -0700
In-Reply-To: <alpine.LFD.0.999.0710172017020.26902@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61461>



On Wed, 17 Oct 2007, Linus Torvalds wrote:
>
> [..] and if you're a vi user, you can do a ':set tabstop=4'

btw, don't get me wrong. I think 8-char tabstops are much better, and 
would much prefer to really teach people not to indent too deeply (because 
six-deep indents really look ugly as hell with 8-char indents).

So setting tabstops to smaller values is not something I think is good 
practice, but at least that way you can keep your dirty perversions to 
yourself, and don't have to admit to the world that you molest dogs and 
small children and use an inferior tab-stop.

The rest of the world might notice occsionally when you don't hide your 
non-indentation tab-uses well enough, of course, but keep to block 
comments and spaces for non-indentation, and you'll be reasonably safe.

However, if I see people actually having indentations six+ deep, I'll know 
that (a) you're likely a small-tab-misusing-deviant and (b) a horrible 
programmer. And then the tab-deviancy is the smaller problem.

(Yes, we do have some cases of six+ deep indentations in the kernel. I'm 
happy to say that they are fairly rare, and yes, I'm personally convinced 
that the 8-wide indent level is part of it. It really *does* end up 
encouraging people to split things up and write nested cases as separate 
functions etc, because it simply becomes so obvious when things are going 
south..)

			Linus
