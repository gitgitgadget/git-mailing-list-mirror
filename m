From: Giovanni Bajo <rasky@develer.com>
Subject: Re: Git and GCC
Date: Sat, 08 Dec 2007 00:14:58 +0100
Organization: Develer S.r.l.
Message-ID: <1197069298.6118.1.camel@ozzu>
References: <20071206.193121.40404287.davem@davemloft.net>
	 <20071207063848.GA13101@coredump.intra.peff.net>
	 <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
	 <20071207.045329.204650714.davem@davemloft.net>
	 <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
	 <4759AC8E.3070102@develer.com>  <m3hciutaoq.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, jonsmirl@gmail.com,
	peff@peff.net, nico@cam.org, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 00:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0mOw-0004SP-6G
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 00:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbXLGXOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 18:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbXLGXOL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 18:14:11 -0500
Received: from trinity.develer.com ([89.97.188.34]:47438 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbXLGXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 18:14:10 -0500
Received: (qmail 26558 invoked from network); 7 Dec 2007 23:14:00 -0000
Received: from unknown (HELO ?192.168.1.3?) (rasky@27.244.106.158)
  by trinity.develer.com with ESMTPA; 7 Dec 2007 23:14:00 -0000
In-Reply-To: <m3hciutaoq.fsf@roke.D-201>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67486>

On Fri, 2007-12-07 at 14:14 -0800, Jakub Narebski wrote:

> > >> Is SHA a significant portion of the compute during these repacks?
> > >> I should run oprofile...
> > > SHA1 is almost totally insignificant on x86. It hardly shows up. But
> > > we have a good optimized version there.
> > > zlib tends to be a lot more noticeable (especially the
> > > *uncompression*: it may be faster than compression, but it's done _so_
> > > much more that it totally dominates).
> > 
> > Have you considered alternatives, like:
> > http://www.oberhumer.com/opensource/ucl/
> 
> <quote>
>   As compared to LZO, the UCL algorithms achieve a better compression
>   ratio but *decompression* is a little bit slower. See below for some
>   rough timings.
> </quote>
> 
> It is uncompression speed that is more important, because it is used
> much more often.

I know, but the point is not what is the fastestest, but if it's fast
enough to get off the profiles. I think UCL is fast enough since it's
still times faster than zlib. Anyway, LZO is GPL too, so why not
considering it too. They are good libraries.
-- 
Giovanni Bajo
