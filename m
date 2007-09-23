From: David Kastrup <dak@gnu.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 20:30:16 +0200
Message-ID: <85hcllmdzb.fsf@lola.goethe.zz>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	<46F55E03.2040404@krose.org>
	<5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	<20070923020951.GF24423@planck.djpig.de>
	<20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	<e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	<20070923104525.GC7118@artemis.corp>
	<e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	<alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
	<e5bfff550709231105h94d08e2n9b1234e7c1a7e6a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 20:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZWDx-00046X-Gf
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 20:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXIWSa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbXIWSa0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 14:30:26 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:50422 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184AbXIWSaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 14:30:25 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 0BF56303454;
	Sun, 23 Sep 2007 20:30:24 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id F27ABABE0E;
	Sun, 23 Sep 2007 20:30:23 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id B62C01CB832;
	Sun, 23 Sep 2007 20:30:18 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 61AF51C1F3DC; Sun, 23 Sep 2007 20:30:16 +0200 (CEST)
In-Reply-To: <e5bfff550709231105h94d08e2n9b1234e7c1a7e6a8@mail.gmail.com> (Marco Costalba's message of "Sun\, 23 Sep 2007 20\:05\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4369/Sun Sep 23 16:16:26 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58973>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 9/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> There are a few features of C++ that I really really like. For example, I
>> think the C preprocessor is absolutely horrid, and a preprocessor that is
>> built into the language - and integrates with the syntax - would be
>> wonderful. And while C++ doesn't improve on that, at least templates are
>> an example of something like that. Not perfect, but that's the kind of
>> feature that C really would like.
>>
>
> Yes, I really agree. IMO templates are the thing that more resembles
> procedural programming, a common way of using them is to split data
> structures (containers) from functions that operates on them
> (algorithms). I find them very similar to the struct + functions
> classical approach of C.
>
> And BTW
>
> template <typename T>
>
> is the thing in C++ that more remembers me of opaque pointers and
> their use in C, the difference is that the first is fully type
> checked.

Not really.  The difference is that the first generates new (and
optimized) code for every type which is something you can only do
using macros in C.  Class programming is similar to opaque pointers
(in particular concerning the generated code) but templates are really
more like macros, as their instantiation generates specialized code,
not at all like the handling of opaque pointers.

While I tend to agree that templates are probably the one thing
actually worth having, it was stupid to lift the restrictions syntax
along with the concept of generics from the Ada shop.  Borrowing
syntax along with features is such a Perlesque approach.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
