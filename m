From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 13:01:09 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de>
 <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org> <20080207204026.GA2550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDuX-0004YL-DE
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934686AbYBGVCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934680AbYBGVCG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:02:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50606 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934679AbYBGVCD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2008 16:02:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17L19xZ004770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2008 13:01:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17L19r2021988;
	Thu, 7 Feb 2008 13:01:09 -0800
In-Reply-To: <20080207204026.GA2550@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73002>



On Thu, 7 Feb 2008, Jeff King wrote:
> 
> FWIW, this is not about OpenSSL for SHA1; it is about the underlying
> library used by curl to do SSL (gnutls vs openssl).

My comment was about claiming "not distributable". That was simply not 
true. It's perfectly distributable, it's just Debian that has issues with 
OpenSSL (but then they shouldn't link it against curl either, so there 
seems to be some _other_ problem there too).

> And the problem is that curl linked against gnutls seems _broken_, so 
> Anand has asked if Debian can ship a binary git linked against a curl 
> that is linked against openssl (and the answer is probably "no, Debian 
> people think that is wrong").

Sure. And you can probably fix it by using NO_OPENSSL, which uses the 
Mozilla SHA1 library. As I also pointed out.

In short - I just wanted to make sure that we do not make the insane 
Debian policies somehow official git ones.

			Linus
