From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sat, 12 Sep 2009 14:31:56 +0400
Message-ID: <20090912103156.GA30385@dpotapov.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 12:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmPyy-0003ld-VX
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 12:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbZILKhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbZILKhP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 06:37:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:37271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZILKhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 06:37:13 -0400
Received: by fg-out-1718.google.com with SMTP id 22so564262fge.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DHb9L2DH+3AIqXBxGuB57HUvotBRau6S7nlRfAxKJcQ=;
        b=JcQNJcJFa3ry0a/hZHcwnVqbe8TJtgZIEPLlV06h3F0E6eDPTsUANK4aFQP5ossbY2
         AbJZExYSR+7cB8utxPSsCya5gjeBdIu1d07j0BXfloHYFvTXMHgOd3fVTNuGd9okJj61
         toPD22rqXQ0bjWKIvam8/fPLse/80BJYdH+wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oROgAXuPEG8mwG0lJ1SRaAIhghTXiVeILUPqk9Fjg2pthrwlw9s9gv3InyF3G2RusQ
         qxtJEIZqf5JzcgAMgn0IoOr79BqpDifjI1QBsFhUpQqnHvQ8zsDQTKkFAkEzTlvyoadY
         y7bJMjjT3PVZGAB90CdKoJ6mEBqGmU23ir2BE=
Received: by 10.86.238.30 with SMTP id l30mr3035241fgh.75.1252751835767;
        Sat, 12 Sep 2009 03:37:15 -0700 (PDT)
Received: from localhost (ppp91-77-226-194.pppoe.mtu-net.ru [91.77.226.194])
        by mx.google.com with ESMTPS id e20sm983572fga.20.2009.09.12.03.37.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 03:37:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128246>

On Wed, Sep 09, 2009 at 05:09:31PM -0700, Brendan Miller wrote:
> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> > Brendan Miller <catphive@catphive.net> writes:
> >>
> >> This is what I want to do 90% of the time, so it should just have =
the
> >> proper defaults, and not make me look at the man page every time I
> >> want to use it.
> >
> > You learn those idioms.
>=20
> I guess. Is that a good thing?

In general, yes, because most of them exist for a good reason.

> Is the goal of interface design to make
> it difficult so I need to learn a lot of things, or easy so I can
> remain blissfully ignorant but still do what I want?

Neither. You cannot get what unless you have specified what you want,
and for that you have to learn how to say that. Having good defaults is
very important, but the problem with choosing them is that people have
different preferences about them. For instance, you wanted the default
prefix for git-archive to be $myproject. For me, a good default would b=
e
either $tag_name, or $myproject-$tag_name, or empty (as it is now!). So=
,
what you propose is *never* a good default for me. Moreover, changing
any default will cause a lot of pain for other people who use Git now.
Besides, writing something like --prefix=3D'' is very ugly. So, the
current default makes perfect sense.

> >>
> >> 7. Man pages: It's nice we have them, but we shouldn't need them t=
o do
> >> basic stuff. I rarely had to look at the man pages using svn, but
> >> every single time I use git I have to dig into these things. Frank=
ly,
> >> I have better things to do than RTFM.
> >
> > Learn. =A0If you learn the philosophy behind git design, you would =
have
> > much easier understanding and remembering git.
>=20
> I think what you mean by philosophy is the underlying data structures=
,
> which are discussed in the manual=20

I think I have read them a lot, but I do not remember any underlying
data structures described in them. What are you reading?

> If I use GCC, do I need to know that it has a recursive descent
> parser? That it is implemented with a garbage collector? No. I just
> need to know that I give it C, and it gives me a binary.
>=20
> Example:
> gcc main.c

The fallacy in your logic is that you compare two completely different
things thinking about them as almost identical. In case of GCC, the fil=
e
contains a program written in the C language. If you do not learn the C
language, you will not be able to use GCC. On the other hand, for Git
any file is just bytes, but the command-line interface describes what
you want to do with them. There is no single action that would make
sense in all cases, you have to specify what you want. Even with simple
tools like sed or awk, you have to learn something before you can use
them.

> >
> > There is "Git User's Manual", "The Git Community Book", "Pro Git" a=
nd
> > many other references.
>=20
> Yeah, I've been reading them. I'm saying that the docs are a crutch.
> RTFM is the problem not the solution. It makes the user do more work
> to avoid fixing usability issues.

A usability issue exists when a person knows how to do that, but it is
inconvenient or error-prone; or when a learning curve is too steep.
But when someone cannot use, let's say, a compiler, because he or she
refuses to read to learn the language, it is not a usability issue.


Dmitry
