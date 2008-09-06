From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Git Community Book
Date: Sat, 6 Sep 2008 02:48:31 +0200
Message-ID: <20080906004831.GA8984@leksak.fem-net>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 02:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbm1r-00078U-Mi
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 02:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYIFAsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 20:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbYIFAsr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 20:48:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:34924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbYIFAsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 20:48:46 -0400
Received: (qmail invoked by alias); 06 Sep 2008 00:48:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp003) with SMTP; 06 Sep 2008 02:48:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+Z1KYZskOZKKBrYePOI7OhXvhvadBdECb8h6neDS
	perDlicYmepy8F
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KblyZ-00035G-M9; Sat, 06 Sep 2008 02:48:31 +0200
Content-Disposition: inline
In-Reply-To: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95053>

Hi,

Scott Chacon wrote:
> I just wanted to let those of you who are interested know that I've
> been making a lot of progress on the Git Community Book
> (http://book.git-scm.com)  I was wondering if anyone was interested in
> helping me with a few parts.

I just had a very quick look over the PDF, meaning only looking at
pictures and headlines.

Just nitpicking about one thing:
I was wondering if "Stash Queue" is the right headline, because I
usually use

	git stash save	# oh, an interrupt, have to do something else now

and after this is done:

	git stash pop	# back to the real work

And if you are interrupted in an interrupt, you want the last stash
being the first one to pop, which is a stack-like (last in, first out)
behavior.

Of course, there may be cases where you want the queuing behavior that
you advertise in the book.
I use it rather seldomly. But perhaps it is just me :-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
