From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and GCC
Date: Sat, 8 Dec 2007 12:24:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712081223070.27959@racer.site>
References: <998d0e4a0712071821o520a75c4lbcaae92256071f48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 13:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0yjt-0005pZ-85
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXLHMYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXLHMYj
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:24:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:36429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751001AbXLHMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 07:24:38 -0500
Received: (qmail invoked by alias); 08 Dec 2007 12:24:36 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp017) with SMTP; 08 Dec 2007 13:24:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+McNVZs8uMdIl6S9kgRZYdt0S/84OykFgrM7kbkv
	2TUuwoqEeLVJmG
X-X-Sender: gene099@racer.site
In-Reply-To: <998d0e4a0712071821o520a75c4lbcaae92256071f48@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67550>

Hi,

On Sat, 8 Dec 2007, J.C. Pizarro wrote:

> On 2007/12/07, "Linus Torvalds" <torvalds@linux-foundation.org> wrote:
>
> > SHA1 is almost totally insignificant on x86. It hardly shows up. But 
> > we have a good optimized version there.
> 
> If SHA1 is slow then why dont he contribute adding Haval160 (3 rounds) 
> that it's faster than SHA1? And to optimize still more it with SIMD 
> instructions in kernelspace and userland.

He said SHA-1 is insignificant.

> > zlib tends to be a lot more noticeable (especially the uncompression: 
> > it may be faster than compression, but it's done _so_ much more that 
> > it totally dominates).
> 
> It's better
> 
> 1.   "Don't compress this repo but compact this uncompressed repo
>       using minimal spanning forest and deltas"
> 2.   "After, compress this whole repo with LZMA (e.g. 48MiB) from 7zip before
>       burning it to DVD for backup reasons or before replicating it to
>	internet".

Patches? ;-)

Ciao,
Dscho
