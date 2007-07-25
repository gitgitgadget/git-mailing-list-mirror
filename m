From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 00:52:26 +0200
Message-ID: <45446C9F-F33E-4D47-9484-E92D36BB803E@wincent.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>  <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com> <alpine.LFD.0.999.0707251131540.3607@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Cuppett <cuppett@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpil-0002ZL-LJ
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbXGYWwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756987AbXGYWwk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:52:40 -0400
Received: from wincent.com ([72.3.236.74]:47396 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756635AbXGYWwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 18:52:39 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6PMqVOA010749;
	Wed, 25 Jul 2007 17:52:33 -0500
In-Reply-To: <alpine.LFD.0.999.0707251131540.3607@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53732>

El 25/7/2007, a las 20:43, Linus Torvalds escribi=F3:

> I think cygwin may add some overhead, but people should really realiz=
e
> that Linux is quite often an order of magnitude faster (or more) than
> other systems on some very basic operations.
>
> That's especially true for filesystem operations. We really are =20
> just that
> good.
>
> Really simple things like stat/open/read/write/close are just damn =20
> fast on
> Linux. To the point where you really do notice it when you compare to
> other systems. If something takes hours on Linux, and it's very
> filesystem-intensive, I'm not at all surprised that it might take =20
> days on
> Windows.
>
> (OS X is probably better than Windows when it comes to filesystem =20
> ops, but
> their memory management absolutely sucks, and I can pretty much =20
> guarantee
> that their filesystem operation latency doesn't hold a candle to =20
> Linux,
> so while I'd expect git to perform "pretty well" on OS X, it's still
> going to be slower than on Linux)

Would be very interesting to see some "scientific" benchmarks of Git =20
performance on the different platforms.

Anyone got an Intel Mac with Windows and Linux installed on it as well?

Cheers,
Wincent
