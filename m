From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Is this an appropriate list for general git questions
Date: Sun, 21 Mar 2010 20:36:52 -0400
Message-ID: <32541b131003211736t823ea8cye7ab4075fa8ccdd5@mail.gmail.com>
References: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Scott Haneda <talklists@newgeo.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 01:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtVe1-0001mK-9B
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 01:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0CVAhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 20:37:15 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:50163 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0CVAhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 20:37:14 -0400
Received: by yxe12 with SMTP id 12so1526842yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4aXphHbDXBCjsqiHuZXaJT8T94k8R2J1td8Hl+xQEFY=;
        b=kTKN/IaPQiLQ6EhjGtrBptcp9KMRJUoI1Ha430h1BxZVluE0G6Dyj7FS+bveCB1qeY
         eKbEMMi9ncNv1TRbT3Ycncr03i7GPV5ned+cxBNV3fBYjDrP7zx19rAbpVGnNTlyW/ga
         25dWEfXmMirWcbclItl2ambKybbRdQOhQTNNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Pt9uOyABopVjV9SAL9eBXn8aaJ6k2Cb19mHl3ekStruDYjTWRD/D1gAqpZO+YVvIq6
         7Xtb7Y/wVabjYxT2frRJuDHbjmY4alQnFhaIva1DTUpUirCNl9YzkzgYLxnWnPyfPFHJ
         IhZDBdm56sa1kcP+EDYoRKaDQ/SyI90efGCTc=
Received: by 10.150.1.7 with SMTP id 7mr3944595yba.320.1269218232113; Sun, 21 
	Mar 2010 17:37:12 -0700 (PDT)
In-Reply-To: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142878>

On Sun, Mar 21, 2010 at 6:59 PM, Scott Haneda <talklists@newgeo.com> wr=
ote:
> I have seen there are a lot of patches, diffs, and what appear to be
> development related posts on this list. =A0Am I in the correct place?
>=A0If not, can someone point me in the right direction?

There's only one official git mailing list, so that's what you get.  I
think the rule of thumb for mailing lists is: if you can't answer your
questions in ten seconds using a Google search, then you're pretty
safe asking on a mailing list.  It looks like you're safe.

By the way, this mailing list accepts posts from non-subscribers, and
it's the policy on the list to always cc: everyone who has replied to
a message in that thread so far, including the original poster.  The
idea is that you can ask a question about git without *having* to
subscribe to read all the other stuff.  But of course, reading some of
the other stuff will make you a more competent git user pretty fast,
so it might be worth it anyway.

> ** - My question if appropriate - **
> My needs are simple. =A0I do some scripting, some coding, web
> development etc. =A0I try my best to take what I have done and
> release it back out to the public. =A0This has become something
> that takes too much effort.

Yup, sounds like you need version control.

> At that point, I have to make a decision. =A0Pack it all up, tar it, =
and put
> it online, perhaps on my website, or perhaps announce it on twitter, =
or
> a relevant mailing list. =A0Of I make a change, even a one character =
change,
> I have to update the distribution that is on my website. =A0There cou=
ld be
> links to it I forgot about that would contain an older broken version=
=2E =A0It may
> also be a simple 30 line bash script, it may not even get a version n=
umber, it is a quick hack.

I think you're right to consider Github for this choice.  It's about
100x more sane than sourceforge, and you can go from start to
release+tarball in one step: it gives viewers the ability to create
tarballs from any version automatically.  If you use 'git tag' (to tag
specific versions as "done") then it'll be even easier for people to
find later.

> I am thinking github is going to be where I put all this stuff, but I=
 am
> completely lost on where to even begin with all this. =A0I watched a =
few
> of the videos on the kernel.org website, and will continue with the
> git tutorials and documentation.

You should probably look at getting a good book on version control.
You can find *these* using Google, including free online ones, now
that you know this is what you should do :)

> The second reason I came to this list is that I am a Mac user,
> and some of the tools I have created are resource fork dependent.
> If they are ftp'd they will be broken. =A0Rsync is the only tool I kn=
ow
> of that can accurately transfer the files without destroying them.
> However, this requires a custom patched version of rsync, and
> must be equal on both ends. =A0I am not sure git hub is going to
> have that patch applied. =A0I may be getting into git hub specifics
> here, and going outside of the lists scope being focussed on git,
> if I am, plesae let me know and I can find a git hub resource.

github just does what git does, only with a friendly web interface.
git doesn't support fancy xattrs or resource forks, at least without
using add-on tools.  This is because source code almost never *needs*
these resource forks: only finished products do, and those are usually
built *from* the source code.  As part of the build process, you add
the resource forks and xattrs onto the completed files.

Also, your repository wouldn't work on non-Mac computers if git stored
that kind of stuff internally.

Your best bet is to have a simple Makefile or build script that does
everything that's necessary.  There are a couple of tools out there
that claim to support attrs and xattrs (for example, metastore), but
at least in metastore's case I don't see any evidence that it supports
resource forks.

Have fun,

Avery
