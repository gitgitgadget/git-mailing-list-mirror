From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 10:08:24 +0200
Message-ID: <85bqce7v9j.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<85ejhb7yzw.fsf@lola.goethe.zz>
	<200709070841.33057.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYtV-0007nx-R3
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbXIGIIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbXIGIIg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:08:36 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:34408 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964963AbXIGIIe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 04:08:34 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 38C2F4C593;
	Fri,  7 Sep 2007 10:08:33 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 1507C2D3BBD;
	Fri,  7 Sep 2007 10:08:33 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id ADD8325D2E3;
	Fri,  7 Sep 2007 10:08:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 425D01CAD71B; Fri,  7 Sep 2007 10:08:24 +0200 (CEST)
In-Reply-To: <200709070841.33057.andyparkins@gmail.com> (Andy Parkins's message of "Fri\, 7 Sep 2007 08\:41\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4176/Fri Sep  7 08:46:21 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58002>

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2007 September 07, David Kastrup wrote:
>
> (Disclaimer: I'm certainly not joining the "C++ for git" chant; this reply is 
> merely to the statements made about C++ in David's message).
>
>> The problem with C++ is that every C++ developer has his own style,
>> and reuse is an illusion within that style.  Take a look at classes
>> implementing matrix arithmetic: there are as many around as the day is
>> long, and all of them are incompatible with one another.
>
> One could say the same about any API.  "Take a look at that C
> library libXYZ - it does exactly the same thing as libPQR but all
> the function calls and structures are different.  Conclusion: C is
> shit".  Obviously nonsense.

The difference is that you can pass structures from one library into
another with tolerable efficiency.  Because there are only basically 2
ways to lay out a two-dimensional array of floats.

>> With regard to programming styles, C++ does not support multiple
>> inheritance.  For a single project grown from a single start, you
>> can
>
> Multiple inheritance is the spawn of the devil, but C++ _does_
> support it.

What about "With regard to programming styles" did you not understand?
I was not talking about a technical feature at class level, but about
code merging from multiple sources.

> I would imagine the reason people often turn up wanting to rewrite
> Linux and git in C++ is because they are so object oriented in
> nature already and it's natural to think "wouldn't this be even
> better if I wrote it in an object oriented language"?  Maybe, maybe
> not, but why bother?

Maintainability and extensibility certainly are valid arguments for
rewrites.  But C++ does not really shine in that regard.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
