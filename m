From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] t3404: extra checks and s/! git/test_must_fail git/
Date: Sat, 21 Jun 2008 03:46:36 +0200
Message-ID: <20080621014636.GG7369@leksak.fem-net>
References: <20080620190037.GE7369@leksak.fem-net> <alpine.DEB.1.00.0806201407230.6439@racer> <1213986614-19536-1-git-send-email-s-beyer@gmx.net> <X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil> <20080620190037.GE7369@leksak.fem-net> <20080621071812.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: nanako3@lavabit.com
X-From: git-owner@vger.kernel.org Sat Jun 21 03:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9sD3-0007FZ-47
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 03:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbYFUBqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 21:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYFUBqr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 21:46:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:54962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751238AbYFUBqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 21:46:46 -0400
Received: (qmail invoked by alias); 21 Jun 2008 01:46:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 21 Jun 2008 03:46:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/wqghb6PLwzv/MbqLpBXvyaGBFjMvvK6w1jkt+BI
	HVktatPcjPjc3q
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9sBY-00022K-4w; Sat, 21 Jun 2008 03:46:36 +0200
Content-Disposition: inline
In-Reply-To: <20080621071812.6117@nanako3.lavabit.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85687>

Hi,

> > Perhaps I'm not consequent, but I thought that it's not worth it ;-)
> 
> Doesn't that logic make the other s/!/test_must_fail/ changes
> also not worth it?  What is the reason behind the change?

The s/!/test_must_fail/ is just an "extra" like
 "Hey, you're currently standing, can you bring me some tea?"

In this case:
 "Oh, I'm currently adding some tests, so I can s/!/test_must_fail/"

> I think your subject line and the message is worse than your
> previous one.  You are saying *HOW* you changed it,

Not exactly.
In the previous one I said, what my patch does: improve t3404.
The latter one said it, too, but a little more specific.

> without saying *WHY* nor *WHAT FOR*.

That's right.

The s/!/test_must_fail/ is, as I said, just an "extra".
And one that does no harm at all.

The others are tests that were useful during git sequencer prototype
development, because once a test in the middle of the test suite failed
because the branch was not correctly reset in one of the invocations of
rebase-i in the first tests.

Well, but I wonder if a long explanation is always necessary.
It is on feature patches and bugfix patches.  But here?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
