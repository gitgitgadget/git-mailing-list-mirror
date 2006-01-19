From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 17:51:28 -0500
Message-ID: <20060119225128.GA8702@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <81b0412b0601190242m4792e73bg181172e478b6e0c2@mail.gmail.com> <20060119183143.GB27888@trixie.casa.cgf.cx> <20060119220843.GA3601@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 23:51:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezicu-0003Gm-Br
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 23:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWASWv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 17:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWASWv3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 17:51:29 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:11704 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161359AbWASWv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 17:51:28 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 26D174A8571; Thu, 19 Jan 2006 17:51:28 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060119220843.GA3601@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14943>

On Thu, Jan 19, 2006 at 11:08:43PM +0100, Alex Riesen wrote:
>Christopher Faylor, Thu, Jan 19, 2006 19:31:43 +0100:
>>Hmm.  I thought we'd already dispelled the myth that cygwin is
>>unsupported in this very mailing list.  That is an odd impression given
>>the fact that you were complaining about behavior in a version of
>>cygwin which was released on Monday but, apology accepted.
>
>It was my first update since a long time (which BTW broke some programs
>like cp: they missed symbols in cygwin1.dll).

Detailed bug reports are always welcome on the cygwin mailing list:
cygwin at cygwin dot com .  I should point out that the existence of
bugs in a product does not indicate a lack of support of the product,
however.

>Maybe it'd be a good idea just to remove the definitions? Or, as
>__INSIDE_CYGWIN__ implies, move them into cygwin internal sources.
>Would be less confusion and no chance of someone defining one of the
>macros and getting a binary-incompatible object?

I sincerely doubt that anyone in this mailing list wants to get into a
discussion of cygwin design.  If you really want to discuss this, the
cygwin mailing list is a much better place for that.

cgf
