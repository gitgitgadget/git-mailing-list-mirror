From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 3 Jan 2007 18:31:06 +0100
Message-ID: <8aa486160701030931mfc14c85tb6815002cac8c6fd@mail.gmail.com>
References: <sbejar@gmail.com> <87fyastgoo.fsf@gmail.com>
	 <200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
	 <8aa486160701030609g22eadf0brf8743dad5701f315@mail.gmail.com>
	 <7vejqcoz7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Jan 03 18:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H29xJ-0001id-HD
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 18:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbXACRbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 12:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXACRbK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 12:31:10 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:29298 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbXACRbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jan 2007 12:31:09 -0500
Received: by wr-out-0506.google.com with SMTP id 68so683405wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 09:31:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYTXoCdLZvuL+ReASneL3sxNK5xS+kLKU+nhx9omI+RQTVgTmlO7th7ZNZQrBc0YyKw70TQh+VpoflnWwnqqI3XpSMpWxYcxNdyOQmg6ztgm4BiNxtFYhJHvRZS19ZCw6eVIdvcLP78LtAoB7UOT/BSMxFzG7Zn/R+hIYD7JY48=
Received: by 10.78.185.16 with SMTP id i16mr6058901huf.1167845467470;
        Wed, 03 Jan 2007 09:31:07 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 3 Jan 2007 09:31:06 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejqcoz7s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35881>

On 1/3/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > On 1/3/07, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> >> Santi B=E9jar <sbejar@gmail.com> wrote:
> >> >
> >> > -Every commit has at least one "parent" commit, which points to =
the
> >> > -previous state of the project:
> >> > +Every commit has at least one "parent" commit (except the first=
),
> >> > +which points to the previous state of the project:
> >>
> >> And how can it have more than one parent? If you mention it, bette=
r come
> >> clean about merges (can be explained in detail later).
> >
> > I have not mentined it, I've just added the exception that the
> > firt/root commits have zero parents.
>
> Well, it does not matter who originally is at fault ;-).

Sure, we all try to make git better and better.

>
> Let's just do this.
>
> diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
> index f0a5526..0cc234f 100644
> --- a/Documentation/tutorial.txt
> +++ b/Documentation/tutorial.txt
> @@ -400,7 +400,7 @@ $ git show HEAD             # the tip of the curr=
ent branch
>  $ git show experimental        # the tip of the "experimental" branc=
h
>  -------------------------------------
>
> -Every commit has at least one "parent" commit (except the first),
> +Every commit usually has one "parent" commit
>  which points to the previous state of the project:
>
>  -------------------------------------
>
> After this paragraph, we say "merge has more than one", so it's
> all consistent and presented in the right order.  By the time
> the reader starts wondering about the initial commit, we've
> shown the use of HEAD^^^^ and HEAD~$n enough that the reader can
> experiment on his/her own.

OK here.

Santi
