From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 21:48:04 -0400
Message-ID: <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:48:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fosa9-0000jX-EI
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWFJBsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFJBsG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:48:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:1483 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751426AbWFJBsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 21:48:05 -0400
Received: by nz-out-0102.google.com with SMTP id m7so334007nzf
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 18:48:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OliOGeCVnp4xQ2zQm92f0Pb6kibUjyej1dGXqm2r8w5htTXVj3F21+pfBmIFKMaZsdY8bGxEnd/7WfbKWFGlc9KwLT+Lzq2I0waNDN6j2igc5ghWADSloOKzaySTtgmFwsPydjrL83+urc/4yEOtRqy220CxfCuC/t+FGOl+77M=
Received: by 10.36.250.59 with SMTP id x59mr5071746nzh;
        Fri, 09 Jun 2006 18:48:04 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 18:48:04 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21582>

On 6/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 9 Jun 2006, Linus Torvalds wrote:
> >
> > That's like 20% of the original, with all the obvious distribution
> > advantages.
>
> Btw, does anybody know roughly how much data a initial "cvs co" takes on
> the mozilla repo? Git will obviously get the whole history, and that will
> inevitably be bigger than getting a single check-out, but it's not
> necessarily orders of magnitude bigger.

339MB for initial checkout

> It could be that getting a whole git archive is not _that_ much more
> expnsive than getting a single version, considering how well history
> compresses (eg the kernel git arhive isn't orders of magnitude bigger than
> a single compressed tar-ball of the sources).
>
> At that point, it's probably a pretty usable alternative.
>
> (Although, to be fair, we almost certainly have to improve "git-rev-list
> --objects --all" performance on that thing, since that's going to
> otherwise make it totally impossible to do initial clones using the native
> git protocol, and make git look bad).
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
