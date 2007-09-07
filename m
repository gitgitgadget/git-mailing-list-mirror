From: alan <alan@clueserver.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 18:40:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709061833040.2526@blackbox.fnordora.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>
  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
 <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITSqC-0007F9-Hq
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 03:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbXIGBk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXIGBkz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 21:40:55 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:57880 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932551AbXIGBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 21:40:55 -0400
Received: by clueserver.org (Postfix, from userid 500)
	id 79244F50395; Thu,  6 Sep 2007 18:40:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 75865F50279;
	Thu,  6 Sep 2007 18:40:54 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57962>

On Fri, 7 Sep 2007, Linus Torvalds wrote:

> IOW, C++ is in that inconvenient spot where it doesn't help make things
> simple enough to be truly usable for prototyping or simple GUI
> programming, and yet isn't the lean system programming language that C is
> that actively encourags you to use simple and direct constructs.

Not to mention try finding two C++ compilers that support the same 
language features.  C is a known quantity. C++ depends on whos compiler 
you use and what class libraries you use.  Trying to make those things 
work crossplatform is not an easy task.  (Harder than it is in C at 
least.)

A number of years ago, a programmer who will not be named (and is not me), 
tried to port Perl to C++.  It was a disaster.  He found that every 
compiler handled something differently.

If you stuck to one compiler, it might work.  But trying to get GCC to 
work like MS C++ or Borland C++ or whatever is just asking for pain.

-- 
Refrigerator Rule #1: If you don't remember when you bought it, Don't eat it.
