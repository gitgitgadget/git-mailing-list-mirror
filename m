From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 21:13:32 -0700
Message-ID: <CA+55aFyG4VuiRN3kcyDVF4sw7b89m-2bOBeQLOGWTcd9o3akzQ@mail.gmail.com>
References: <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
 <CA+55aFyXg32mko8TOGCfGHpr3jHBEgcKiK7HdVwq0Wez0fAs9A@mail.gmail.com> <20111103032205.GA25888@pompeji.miese-zwerge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jochen Striepe <jochen@tolot.escape.de>
X-From: git-owner@vger.kernel.org Thu Nov 03 05:14:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLogu-0005Gs-3N
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 05:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab1KCEN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 00:13:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41234 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1KCENz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 00:13:55 -0400
Received: by wwi36 with SMTP id 36so1237807wwi.1
        for <multiple recipients>; Wed, 02 Nov 2011 21:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jYc0skpye1g9T4Q5iPlhzbZTJC7qVQea0GWIxoA91Pc=;
        b=FRPmFScL9jb2uexcc5q/BRvYXRYpQUF37OpgEABpefOF/fH8DOqS0ljyA46XWRumqH
         +c2c+XHQ6sUZtBfns37YUyrfwKDiQqVo3pxTfitjTODc5MDqtO7izeFnY+DmHSAirI+N
         qK61fB/zrgffVG4I00x9SF+A0+NEFaMZTQmjg=
Received: by 10.216.161.17 with SMTP id v17mr2093421wek.112.1320293633094;
 Wed, 02 Nov 2011 21:13:53 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 21:13:32 -0700 (PDT)
In-Reply-To: <20111103032205.GA25888@pompeji.miese-zwerge.org>
X-Google-Sender-Auth: iU3qoLLX3QG0wf-HSH6UDqaLOvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184704>

On Wed, Nov 2, 2011 at 8:22 PM, Jochen Striepe <jochen@tolot.escape.de>=
 wrote:
>
> It seems quite useless and leading to false conclusions in several ca=
ses
> where the merger's gpg output differs from someone's checking later o=
n,
> e.g. when
>
> =A0- the signing key has been revoked in the mean time (for whatever
> =A0 reasons)
> =A0- the signing key has expired
> =A0- the public part of the signing key is not available for the gene=
ral
> =A0 public.

So I don't think those are *big* issues. Sure, you'd want the public
key to be public for it to make any real sense to save, but on the
other hand, they *are* generally public. Yes, yes, you might have keys
that are only used - and only made public - within some particular
organization, but in that case the source code that gets signed with
those keys would tend to be private to that organization too, so..

And yes, keys get revoked or they expire, but that's still a pretty
rare event, so it doesn't really invalidate the argument that making
the original signed content available can quite often be useful - even
if it's not guaranteed to *always* be useful.

No, my main objection to saving the data is that it's ugly and it's
redundant. Sure, in practice you can check the signatures later fine
(with the rare exceptions you mention), but even when you can do it,
what's the big upside?

And there are much bigger real downsides, imho.

=46or example, let's say that we do eventually end up switching from
SHA1 to SHA256 in git, and we do a full re-import of the tree. Guess
what? All those signatures are now just so much garbage. Sure, you can
recreate them (create some trusted script that you agree does a 1:1
transform, and re-sign everything), but in practice you can't ever
really do that - because all those things are tied to the tree, so you
need to have *everybodys* private keys in one place to do so. And the
people who signed things initially would have to be insane to allow
that.

So I'm actually of the opinion that "internal signatures" are bad
design at a rather fundamental level.

In contrast, the "external signed tags" are fine: it's not just that
there are much fewer of them, it's that they are *independent*. So you
can easily re-generate the signed tags, because each signer can
*individually* decide to validate the newly converted tree, and sign
off on the fact that the conversion was done identically using new
external tags with signatures.

This was one of the reasons I made the signed tags work the way they
do. And it wasn't because I was extremely far-sighted and thought of
all the problems that internal signatures have - it's because monotone
had their internal signatures, and every other email on the monotone
list was about all the problems it caused.

> AFAIK gpg just gives you an error code and a message like e.g. "Key h=
as
> expired" without stating if the key was valid _when signing the commi=
t_.
>
> How do you plan to handle this when keeping the signature in the
> repository? Or am I overlooking something?

So see above - I just wouldn't worry about it. The possible few cases
where it would occur are dwarfed by the cases where it *doesn't*
occur, and those are the ones I'd concentrate on. They are the ones
that need to be important enough that it's even worth carrying the
random noise around.

Are they?

So I do think that there are real upsides at the *process* level where
you can use the signatures to verify that what is pulled is pulled
from the person you thought it was. I don't think anybody disputes
those advantages. But outside of that I think it gets very gray, and
there real disadvantages.

That said, I don't care *that* much. I don't mind polluting the merge
commits with information that I don't think is really worth it. So I'd
be willing to carry the signature information around, although I'd
hope to minimize it and have some sane way to hide it.

            Linus
