From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to resume broke clone ?
Date: Wed, 4 Dec 2013 22:50:27 -0800
Message-ID: <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net> <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 07:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoSm0-00017O-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 07:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab3LEGuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 01:50:51 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:58312 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab3LEGus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 01:50:48 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so5016292wib.12
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 22:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pC81gByvFE4/TCXBSvWMNZ+6h6vZGwo51dCJqQ33sR8=;
        b=GMHlQE3e5MxiOg8cyvGum1uTmUjXu16pZDEZAnlDve9aTgdP1H11n+8PWOeODpRLPa
         KMQxjr5vfdU5q92YEF/q0f5YysTti/DxA4PyTeCininaAxD3ELmOIdxCvnXC9hdRBsEy
         EgvF0D9vGDvVpw7cWO/yuZ4mZa7ITw3Amc8xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pC81gByvFE4/TCXBSvWMNZ+6h6vZGwo51dCJqQ33sR8=;
        b=eNNMcfckvwZKr9vVzFaGgsJXTcuKRc6XX2wLPSLcNf4iekiHDD3TsjE22j3o0mpIHs
         jKx90XqYYU/N1nw4cd6wA7RY51wfU2GH09QTtK8AyS0Y5kgVJjGw1Ci3+oKIwzqWfIYM
         EREfA6KmlTjd0M/4C3OQ5shFYQ60vk4qerALrjAj/Yd1YIJc/xK47Wf3sP2/QpX8BqXN
         LCxZ0X7k6b6v+FhWVr8BxEXI0ay11cBSThCfqlDT4lCZJaRy7Gs8ZEho6/KYRcFqPGH/
         z3PPydPOchsA/bjhHFEFLKggWsqcOrl6LJBmLWIy6FPDpzRqpzIW42CN7N2y0kpgNRlY
         YJEg==
X-Gm-Message-State: ALoCoQnWh6pXjTLqcWJ/Lec2IF1TskLj463hlv7y2y+TfZ58R2vRb661CbnmnfGQnhgxNOjxMrkA
X-Received: by 10.180.10.74 with SMTP id g10mr10605352wib.11.1386226247307;
 Wed, 04 Dec 2013 22:50:47 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Wed, 4 Dec 2013 22:50:27 -0800 (PST)
In-Reply-To: <20131204200850.GB16603@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238844>

On Wed, Dec 4, 2013 at 12:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 28, 2013 at 11:15:27AM -0800, Shawn Pearce wrote:
>
>> >>  - better integration with git bundles, provide a way to seamlessly
>> >> create/fetch/resume the bundles with "git clone" and "git fetch"
>>
>> We have been thinking about formalizing the /clone.bundle hack used by
>> repo on Android. If the server has the bundle, add a capability in the
>> refs advertisement saying its available, and the clone client can
>> first fetch $URL/clone.bundle.
>
> Yes, that was going to be my next step after getting the bundle fetch
> support in.

Yay!

> If we are going to do this, though, I'd really love for it
> to not be "hey, fetch .../clone.bundle from me", but a full-fledged
> "here are full URLs of my mirrors".

Ack. I agree completely.

> Then you can redirect a non-http cloner to http to grab the bundle. Or
> redirect them to a CDN. Or even somebody else's server entirely (e.g.,
> "go fetch from Linus first, my piddly server cannot feed you the whole
> kernel"). Some of the redirects you can do by issuing an http redirect
> to "/clone.bundle", but the cross-protocol ones are tricky.

Ack. My thoughts exactly. Especially the part of "my piddly server
shouldn't have to serve you a clone of Linus' tree when there are many
public hosts mirroring his code available to anyone". It is simply not
fair to clone Linus' tree off some guy's home ADSL connection, his
uplink probably sucks. But it is reasonable to fetch his incremental
delta after cloning from some other well known and well connected
source.

> If we advertise it as a blob in a specialized ref (e.g., "refs/mirrors")
> it does not add much overhead over a simple capability. There are a few
> extra round trips to actually fetch the blob (client sends a want and no
> haves, then server sends the pack), but I think that's negligible when
> we are talking about redirecting a full clone. In either case, we have
> to hang up the original connection, fetch the mirror, and then come
> back.

I wasn't thinking about using a "well known blob" for this.

Jonathan, Dave, Colby and I were kicking this idea around on Monday
during lunch. If the initial ref advertisement included a "mirrors"
capability the client could respond with "want mirrors" instead of the
usual want/have negotiation. The server could then return the mirror
URLs as pkt-lines, one per pkt. Its one extra RTT, but this is trivial
compared to the cost to really clone the repository.

These pkt-lines need to be a bit more than just URL. Or we need a new
URL like "bundle:http://...." to denote a resumable bundle over HTTP
vs. a normal HTTP URL that might not be a bundle file, and is just a
better connected server.


The mirror URLs could be stored in $GIT_DIR/config as a simple
multi-value variable. Unfortunately that isn't easily remotely
editable. But I am not sure I care?

GitHub doesn't let you edit $GIT_DIR/config, but it doesn't need to.
For most repositories hosted at GitHub, GitHub is probably the best
connected server for that repository. For repositories that are
incredibly high traffic GitHub might out of its own interest want to
configure mirror URLs on some sort of CDN to distribute the network
traffic closer to the edges. Repository owners just shouldn't have to
worry about these sorts of details. It should be managed by the
hosting service.

In my case for android.googlesource.com we want bundles on the CDN
near the network edges, and our repository owners don't care to know
the details of that. They just want our server software to make it all
happen, and our servers already manage $GIT_DIR/config for them. It
also mostly manages /clone.bundle on the CDN. And /clone.bundle is an
ugly, limited hack.

For the average home user sharing their working repository over git://
from their home ADSL or cable connection, editing .git/config is
easier than a blob in refs/mirrors. They already know how to edit
.git/config to manage remotes. Heck, remote.origin.url might already
be a good mirror address to advertise, especially if the client isn't
on the same /24 as the server and the remote.origin.url is something
like "git.kernel.org". :-)

>> For most Git repositories the bundle can be constructed by saving the
>> bundle reference header into a file, e.g.
>> $GIT_DIR/objects/pack/pack-$NAME.bh at the same time the pack is
>> created. The bundle can be served by combining the .bh and .pack
>> streams onto the network. It is very little additional disk overhead
>> for the origin server,
>
> That's clever. It does not work out of the box if you are using
> alternates, but I think it could be adapted in certain situations. E.g.,
> if you layer the pack so that one "base" repo always has its full pack
> at the start, which is something we're already doing at GitHub.

Yes, well, I was assuming the pack was a fully connected repack.
Alternates always creates a partial pack. But if you have an
alternate, that alternate maybe should be given as a mirror URL? And
allow the client to recurse the alternate mirror URL list too?

By listing the alternate as a mirror a client could maybe discover the
resumable clone bundle in the alternate, grab that first to bootstrap,
reducing the amount it has to obtain in a non-resumable way. Or... the
descendant repository could offer its own bundle with the "must have"
assertions from the alternate at the time it repacked. So the .bh file
would have a number of ^ lines and the bundle was built with a "--not
..." list.

>> but allows resumable clone, provided the server has not done a GC.
>
> As an aside, the current transfer-resuming code in http.c is
> questionable.  It does not use etags or any sort of invalidation
> mechanism, but just assumes hitting the same URL will give the same
> bytes.

Yea, our lunch conversation eventually reached this part too. repo's
/clone.bundle hack is equally stupid and assumes a resume will get the
correct data, with no validation. If you resume with the wrong data
while inside of the pack stream the pack will be invalid; the SHA-1
trailer won't match. But you won't know until you have downloaded the
entire useless file. Resuming a 700M download after the first 10M only
to find out the first 10M is mismatched sucks.

What really got us worried was the bundle header has no checksums, and
a resume in the bundle header from the wrong version could be
interesting.

> That _usually_ works for dumb fetching of objects and packfiles,
> though it is possible for a pack to change representation without
> changing name.

Yes. And this is why the packfile name algorithm is horribly flawed. I
keep saying we should change it to name the pack using the last 20
bytes of the file but ... nobody has written the patch for that?  :-)

> My bundle patches inherited the same flaw, but it is much worse there,
> because your URL may very well just be "clone.bundle" that gets updated
> periodically.

Yup, you followed the same thing we did in repo, which is horribly wrong.

We should try to use ETag if available to safely resume, and we should
try to encourage people to use stronger names when pointing to URLs
that are resumable, like a bundle on a CDN. If the URL is offered by
the server in pkt-lines after the advertisement its easy for the
server to return the current CDN URL, and easy for the server to
implement enforcement of the URLs being unique. Especially if you
manage the CDN automatically; e.g. Android uses tools to build the CDN
files and push them out. Its easy for us to ensure these have unique
URLs on every push. A bundling server bundling once a day or once a
week could simply date stamp each run.

>> > I posted patches for this last year. One of the things that I got hung
>> > up on was that I spooled the bundle to disk, and then cloned from it.
>> > Which meant that you needed twice the disk space for a moment.
>>
>> I don't think this is a huge concern. In many cases the checked out
>> copy of the repository approaches a sizable fraction of the .pack
>> itself. If you don't have 2x .pack disk available at clone time you
>> may be in trouble anyway as you try to work with the repository post
>> clone.
>
> Yeah, in retrospect I was being stupid to let that hold it up. I'll
> revisit the patches (I've rebased them forward over the past year, so it
> shouldn't be too bad).

I keep prodding Jonathan to work on this too, because I'd really like
to get this out of repo and just have it be something git knows how to
do. And bigger mirrors like git.kernel.org could do a quick
grep/sort/uniq -c through their access logs and periodically bundle up
a few repositories that are cloned often. E.g. we all know
git.kernel.org should just bundle Linus' repository.
