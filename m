From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 08:47:47 +0200
Message-ID: <85ejhb7yzw.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXfJ-0006P7-SK
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXIGGt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbXIGGt5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:49:57 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:42888 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932721AbXIGGt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 02:49:56 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id BEBE11E4F8E;
	Fri,  7 Sep 2007 08:49:53 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id A9A3D28EC4D;
	Fri,  7 Sep 2007 08:49:53 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id E17378C467;
	Fri,  7 Sep 2007 08:49:40 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8CEF21CAD71B; Fri,  7 Sep 2007 08:47:47 +0200 (CEST)
In-Reply-To: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> (Dmitry Kakurin's message of "Thu\, 6 Sep 2007 17\:21\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4175/Thu Sep  6 22:16:54 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57989>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> On 9/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> In other words: the choice of C is the only sane choice. I know
>> Miles Bader jokingly said "to piss you off", but it's actually
>> true. I've come to the conclusion that any programmer that would
>> prefer the project to be in C++ over C is likely a programmer that
>> I really *would* prefer to piss off, so that he doesn't come and
>> screw up any project I'm involved with.
>
> As dinosaurs (who code exclusively in C) are becoming extinct, you
> will soon find yourself alone with attitude like this.

As long as TeX, Emacs and vi are around, I would not worry too much
about dinosaurs in general.  But C++ is a cancerous dinosaur.  It has
growths that just don't belong on a C body.

> I was coding in Assembly when there was no C.  Then in C before C++
> was created.  Now days it's C++ and C#, and I have never looked
> back.  Bad developers will write bad code in any language. But
> penalizing good developers for this illusive reason of repealing bad
> contributors is nonsense.

The problem with C++ is that every C++ developer has his own style,
and reuse is an illusion within that style.  Take a look at classes
implementing matrix arithmetic: there are as many around as the day is
long, and all of them are incompatible with one another.

With regard to programming styles, C++ does not support multiple
inheritance.  For a single project grown from a single start, you can
get reasonable solutions.  But combining stuff is creating maintenance
messes.

With C, the situation is not dissimilar, but you spent less time
fighting the illusion that you don't need to reimplement, anyway.

> I just wanted to get a sense of how many people share this "Git
> should be in pure C" doctrine.

What nonsense.  Large parts of git already are shell scripts, so
obviously there is no such doctrine.  Just because C++ is not a sane
proposition does not mean that others might not work.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
