From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 00:06:37 -0700
Message-ID: <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Sep 14 09:07:18 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R3jYy-0003o8-72
	for glk-linux-kernel-3@lo.gmane.org; Wed, 14 Sep 2011 09:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab1INHHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 14 Sep 2011 03:07:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44575 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab1INHG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2011 03:06:58 -0400
Received: by wwf22 with SMTP id 22so1805715wwf.1
        for <multiple recipients>; Wed, 14 Sep 2011 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iIhC6f9BCEnXol9e1+MFggpVWiOgvl/1bM6MSMTa9Tk=;
        b=luHC+SrBV9Q8mdGT1Pda5DhUDKyQ6Icbo2rw1I4xD6YnAr/QA81Pfgwfym2TCIDAHt
         Z/lQsJTBjZUCtI8wBbbugj9rcMUduaLa9PBRUCIWZN3co6xJybFaoizzWAk+cVEJLHzS
         IirEdFk2zqnaFOrMwwhD4ARXhOJgtfOFXamog=
Received: by 10.216.29.200 with SMTP id i50mr3034618wea.91.1315984017231; Wed,
 14 Sep 2011 00:06:57 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Wed, 14 Sep 2011 00:06:37 -0700 (PDT)
In-Reply-To: <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
X-Google-Sender-Auth: bYc-wNpfjE3_oeSv7lMT92AhHCM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181341>

Recovering lost emails. Or maybe you get duplicates. Sorry about that i=
f so,

                   Linus

---------- Forwarded message ----------
=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, Sep 13, 2011 at 10:48 AM
Subject: Re: [Survey] Signed push
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org


On Tue, Sep 13, 2011 at 9:45 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> We have a tentative patch to add an extra line after the "URL branch"=
 line
> that is for your cut & paste that looks like:
>
> =A0 =A0are available in the git repository at:
> =A0 =A0 =A0git://git.kernel.org/pub/flobar.git/ master
> =A0 =A0for you to fetch changes up to 5738c9c21e53356ab5020912116e7f8=
2fd2d428f
>
> I often see you respond to a pull request on the kernel mailing list =
with
> "I see nothing new; forgot to push?", and having this extra line may =
also
> help communication.

I think that would probably be a good idea, although I'd actually
prefer you to be more verbose, and more human-friendly, and actually
talk about the commit in a readable way. Get rid of the *horrible*
BRANCH-NOT-VERIFIED message (that actually messes up pull requests if
mirroring is a bit delayed and throws away more important
information), and instead just have a blurb afterwards saying
something human-readable like

=A0Top commit 1f51b001cccf: "Merge branches 'cns3xxx/fixes',
=A0'omap/fixes' and 'davinci/fixes' into fixes"

=A0and at *that* point you might have a "UNVERIFIED" notice for people
to check if they forgot to push.

So I'd much prefer something like that over:

> An alternative that I am considering is to let the requester say this
> instead:
>
> =A0 =A0are available in the git repository at:
> =A0 =A0 =A0git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5020=
912116e7f82fd2d428f
>
> without adding the extra line.

The extra line in the pull request is cheap - it's not like we need to
ration them. The above format, in contrast, requires that the person
doing the *pull* have a recent enough git client, otherwise the merge
commit message will be just horrible.

And even if you do have a new git client that turns the commit into a
branch name, that's ambigious. What if both 'master' and
'experimental' have the same top commit, because experimental ended up
being tested and was percolated to master? Which branch name would you
pick? And what if the branch was updated since, so *no* branch name
matches - does that mean that you'd disallow the pull entirely?

> 2. Signed pushes.
>
> You tag official releases and release candidates with your GPG key, a=
nd
> everybody who works within the kernel ecosystem trusts the history be=
hind
> the commits pointed by them, but there is no easy way to verify that
> commits and merges between the last tagged commit and the tip of your
> branch(es) are indeed from you, or if an intruder piled fake ones on =
top
> of your commits (until you try to push again and discover that the hi=
story
> does not fast-forward, that is).
>
> We have been discussing an addition of "git push -s" to let people si=
gn
> their pushes (instead of having to sign every commit or add signed
> tag). The implementation alternatives were being bikeshed but not of =
much
> interest in this message, but the user experience would go like this:

Also, if we're adding branch information, I'd say that a description
of the branch is more important than a signature. Right now we lack
even that.

It would be lovely if people could annotate their branches with
descriptions, so that when I pull a "for-linus" branch, if it has a
description, the description of the branch makes it into the merge
message. Our merge messages are often not very informative.

I realize that cryptographic signature sound very important right now,
but in the end, *real* trust comes from people, not from signatures.
Realistically, I checked a few signatures this time around due to the
k.org issues, but at the same thing, the thing that made me trust most
of it was just looking at commits and the email messages. The
unconscious and non-cryptographic "signature" of a person acting like
you expect a person to act.

Technical measures can be subverted, and I think we should also think
about the social side. Every time somebody mentions a signature, I
want to also mention "human readability", because I think that matters
as much, if not more.

So I'm not against signed pushes, but quite frankly, if you add some
per-branch signature, I would argue against it unless that signature
also comes with information that allows us to do a better job of human
communication too. Like a branch description.

Imagine, for example, than when you do a

=A0 git push -s ..

git would *require* you to actually write a message about what you are
pushing. And when somebody pulls it, and creates a merge commit, that
explanation would become part of the merge message. The "signature"
part of the "-s" should be thought of as the *much* less interesting
part - that's just a small detail that git can use to verify
something, but it doesn't actually matter for the contents of the
pull. Not like the actual human-readable message would.

Now *that* would be lovely. No?

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
