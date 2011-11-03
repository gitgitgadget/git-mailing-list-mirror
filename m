From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 3 Nov 2011 12:06:05 -0700
Message-ID: <CA+55aFzZgECmCVBeu2+f+DUUpk4TOrvJB0NYeu-5XKSjRZS+xA@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com> <7v62j1gitn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 20:06:31 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RM2cQ-0001r8-5S
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 20:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934397Ab1KCTG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Thu, 3 Nov 2011 15:06:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47249 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886Ab1KCTG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2011 15:06:27 -0400
Received: by wwi36 with SMTP id 36so2331801wwi.1
        for <multiple recipients>; Thu, 03 Nov 2011 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8v5waCrGC21vE3Nf0lt891Xi8bNE+Ul1GmauQD9X1s8=;
        b=mJJTSwjWn1W7WgTdKS3K/LnQqSlUUQV0SqEtU6fSteGIeSS6bvEMLcNiZpTLkb1T1G
         0dmCKpqS0s2cM38Gk5aPHsGkNEUbA0OVX7hBEADa20h2oDvOsV0RgfvYxhcpGHEpBvvJ
         vLeDcDMZ0n271BYEzCXeEYyoSCzRyeqMh5GU4=
Received: by 10.216.133.217 with SMTP id q67mr2112011wei.97.1320347186159;
 Thu, 03 Nov 2011 12:06:26 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Thu, 3 Nov 2011 12:06:05 -0700 (PDT)
In-Reply-To: <7v62j1gitn.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: lk5R-qC8FDw6TsB7KrTFEXqlmpM
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184738>

On Thu, Nov 3, 2011 at 11:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> It is not "Whatever".
>
> =A0$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git v3.0
> =A0fatal: Couldn't find remote ref v3.0
>
> I do not think we ever DWIMmed fetch refspecs to prefix refs/tags/, s=
o it
> is not the naming but fetching tags without saying "git fetch tag v3.=
0"
> (which IIRC was your invention long time ago).

Ahh. Yeah, and not DWIM'ing tags is probably ok. I'd completely
forgotten about the special "tag" shortcut.

Which probably means it was a bad ui decision to begin with. But once
more, the UI is clearly designed for fetching the tags into your own
tag-space (ie it does "refs/tags/<tag>:refs/tags/<tag>") rather than
fetching the tag just for verification.

> If we changed this "git fetch $there v3.0" to fetch tag, it would hel=
p the
> final step in your illustration, and I do not think it would be a hug=
e
> regression---the only case it becomes fuzzy is when they have v3.0 br=
anch
> at the same time, but the owner of such a repository is already playi=
ng
> with fire.

Yeah, extending DWIM for remote repos to do the same thing it does for
local repositories is probably the right thing regardless of any other
issues.

We already have the "tag and branch with the same name" issue for
local repositories, and we have perfectly good disambiguation rules
for when disambiguation is necessary. Making the DWIM rules be the
same for a remote case sounds sane.

That said, I don't think it's a big deal either. I was just confused
by the expansion being different, but having to have the refs/tags/
there isn't a dealbreaker by any means.

>> Quite frankly, I think that's a git bug, but it's a git bug because
>> "git fetch" was designed to get the commit to merge. Fair enough.
>
> And because FETCH_HEAD started as (and probably still is) an internal
> implementation detail of communication between fetch and merge inside
> pull.

Well, I certainly don't consider it to be just "an implementation
detail" personally. I use FETCH_HEAD all the time (the same way I use
ORIG_HEAD and just plain HEAD). It's very useful for "fetch and check
what they have", when you want to look at something but you don't want
all the remote tags and crud. So I consider it a honest-to-goodness
real user feature.

>So I do not have any issue in changing it to store tags unpeeled there=
=2E

In fact, storing the peeled was really surprising to me, especially
since it actually *says* "tag" in the .git/FETCH_HEAD file. So the
=2Egit/FETCH_HEAD file really currently ends up being actively wrogn an=
d
misleading for tags we fetch: it looks something like

  <sha-of-commit>  tag '<tagname>'  of <reponame>

and says it is a tag, but the SHA1 is of the peeled commit. That's
just crazy, and actually made me think the other end (Rusty, in this
case) had done something wrong initially (ie I quite reasonably - I
thought - blamed it on Rusty using a non-signed tag).

>> WTF?
>
> This is not WTF but "fetching a history to store the tip of it in you=
r
> refs/ namespace causes tags pointing into the history line followed
> automatically", and it exactly is what you want to happen if rusty as=
ked
> you to fetch his for-linus branch (which the tag may point at) instea=
d.

Well, yes and no. But mostly no.

If I just fetch his for-linus branch, I don't get (and I don't want)
his tags. It's only because I fetched it into my ref-space.

And I only fetched it into my ref-space, because otherwise the crazy
git peeling happened if I don't do that.

So I didn't want those other tags, and I really normally wouldn't have
gotten them. Only because I had to do that odd work-around to avoid
the peeling did I get it, because then the totally unrelated logic of
"ok, get the tags too" triggered.

So it's a WTF, because this work-around ends up having the special
side effects - and they make sense when you *really* fetch his branch
and make it part of your name-space, but not when you only did the
"part of my namespace" as a workaround for another git issue.

Obviously, you can use "-n" (--no-tags) to fetch the tag, and that
actually fixes the issue, but that is it's own kind of WTF too: in
order to fetch just *one* tag, you have to specify that you don't want
tags? Not exactly a greatly intuitive use case ;)

Anyway, the one-line rpatch I sent basically avoids all these WTF
moments, by just making "git fetch <repo> <tagname>" work (apart from
the DWIMmery on the tag-name, but that's a totally independent small
detail that doesn't really matter)

>> We got three other
>> tags too that we didn't even ask for!
>
> We could change the rule to read "fetching a history to store the tip=
 of it
> in your refs/heads namespace causes autofollow". I am not sure if tha=
t is
> what we really want, though.

No, I think the current "follow tags" rule is fine. It's just that it
didn't really mesh well with "damn, I have to work around this other
git issue".

> We could update three things:
>
> =A0- DWIM $name in "git fetch $there $name" to refs/tags/$name when i=
t makes
> =A0 sense;
> =A0- FETCH_HEAD stores unpeeled object names; and
> =A0- "git pull" learns --verify option.

Yes. I think that would indeed solve everything.

> Then
>
> =A0$ git pull --verify rusty rusty@rustcorp.com.au-v3.1-8068-g5087a50
>
> could integrate the history leading to that tag to your current branc=
h
> while running verify-tag on it.

Agreed. The only remaining issue then would be how that "yes, I
verified the tag" part would be actually saved for posterity. My
suggestion would be to to just punt that question, and let the user
decide, by simply:

 - start the editor by default with "--verify"

 - output the "gpg --verify" result into the end of the commit file,
along with the tag content (which has the original pgp signature, of
course).

 - let the user decide what part of it he wants to use.

In particular, the "gpg --verify" result may well be something that
the user wants to *act* on - maybe the key didn't exist in the key
ring, or maybe it does exist but doesn't have quite enough trust and
gpg complains about that etc etc. But that's all something that "start
the editor and show the user what is up" would let the user decide on.

> For this, disabling the tag-auto-following is not necessary, as you a=
re
> not storing the retrieved tag anywhere.

Exactly,

>> That said, I do think that the "signature in the pull request" shoul=
d
>> also "just work", and I'm not entirely sure which one is better.
>
> I do not think it is necessarily either/or choice.

No, I think we can do both, and it actually ends up being just a
matter of convenience which one a particular project ends up using (or
even use both depending on preferences of particular sub-lieutenants
within the project).

> I wonder if an approach like the following, in addition to the three
> things I listed above, may give us a workable solution:
>
> =A0* "git fetch linus v3.0" called by "git pull --verify linus v3.0" =
fetches
> =A0 the v3.0 unpeeled into FETCH_HEAD, GPG verifies it, creates
> =A0 refs/audit/$u, before running "git merge". $u is derived from v3.=
0
> =A0 (given tag), the identity of the GPG signer, and perhaps timestam=
p to
> =A0 make it both identifiable and unique under refs/audit/ hierarchy.

So far so good, but see above: it may turn out that the user will
*re-verify* the key after having done some gpg action. So..

> =A0* You "git push origin". This causes refs/audit/* refs that point =
at
> =A0 commits in the transferred history to auto-follow, just like the
> =A0 current "git fetch $there $src:$dst" causes refs/tags/* auto-foll=
ow.
> =A0 The refs/audit/* hierarchy in your public repository will be popu=
lated
> =A0 by lieutenant signatures.

So I don't think auto-follow is good here.

I could *easily* see various companies using this for their own
internal audit, without really wanting to expose things outside of the
company. So auto-following sounds like the wrong approach. Make it an
explicit "expose audit checks" thing.

> =A0* (Optional) You may have signed "git tag -s 'Linux v3.2' v3.2 mas=
ter"
> =A0 before you push origin out, or you may have not. Currently, you d=
o have
> =A0 to "git push origin v3.2" separately if you did. The above auto-f=
ollow
> =A0 could be extended to push refs/tags/* hierarchy to eliminate this=
 step
> =A0 as well.

So far I haven't really had any issues with having to do a "git push
--tags" to push things out.

That said, maybe the auto-push could just be a per-repo option, and
then you can have it both ways.

> Note that because of the way "upload-pack" protocol is structured, th=
e
> first response from "upload-pack" after it gets connection is the
> advertisement of refs, and there is no way for "fetch-pack" to ask fo=
r
> customized refs advertisement to it. So for this to work without incu=
rring
> undue overhead for normal users, we would need to exclude refs/audit/=
*
> from the normal ref advertisement (i.e. "ls-remote" does not see it) =
so
> that "git fetch" by casual users will not have to wait for megabytes =
of
> ref advertisements before issuing its first "want" request.

I think that would be a good thing, and make it much more palatable.
After all, th elikelihood is that *nobody* will ever care about the
audit cases at all. They are very much a "..but what if xyz happens"
kind of safety net for the extreme badness, not anything you'd expect
to use.

                         Linus
