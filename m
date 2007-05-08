From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 15:16:32 +1200
Message-ID: <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	 <vpqbqgxak1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 05:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGBr-0007ID-0I
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967645AbXEHDQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbXEHDQe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:16:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:20185 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbXEHDQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:16:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1603515wxd
        for <git@vger.kernel.org>; Mon, 07 May 2007 20:16:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SuvbPsieZeRhq+spfuhU/A5rhCZAdtPtmRWWBV0ERLIdrU9LxXn6HzK/OMrKm2MFBjna2SjCf9lbftwR49z8OUIyaZcMhQvKK0vmfGp4i5mTqzqdl3nesXRz0CAYqEF83H5Z8AkmBSkhiI9WiL/Y4sREvuMylSGGsEwE1rY5wbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F1qIcyqf1r2e7XBZor8N7w1RVEciKND281tVFOBZqzp9zY/X1+MLcvfh1vC5TQMvt3V9loV5tSkFPZ/vvpHwTddIAn6kKsBcXF9VyeQdnhROcynSi+p2WWi4bio+fN0CKz+2T6EzvVKnVM9Xem0qHMx/y1SPY31AYF+r8BALrAY=
Received: by 10.90.49.19 with SMTP id w19mr5863202agw.1178594192751;
        Mon, 07 May 2007 20:16:32 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Mon, 7 May 2007 20:16:32 -0700 (PDT)
In-Reply-To: <vpqbqgxak1i.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46522>

On 5/7/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Sun, 6 May 2007, Matthieu Moy wrote:
> >>
> >> But the fact that git actually remembers the _content_ of files in the
> >> index, and that the default behavior for "commit" is to commit only
> >> the content that is explicitely "git add"ed is something I've never
> >> seen outside git.
> >
> > Yeah. You'd better get used to it, because it's fundamental.
>
> Thanks a lot for the detailed explanations.

Heh. Making the index very visible makes sense when you are merging,
Linus and Junio are both integrators and spend a lot of time merging.
Hence the default is for git-commit to observe the index.

I agree with Linus' other points too, but at the end of the day, it
makes life easier and saner mainly when merging, at the expense of
having to pay a bit more attention in common commits. The tradeoff
makes sense _specially_ if you are the integrator.

So I do git-commit -a, and typing that '-a' is small price to pay for
the best SCM I've ever used ;-)

cheers,


martin
