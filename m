From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 11:16:53 +0200
Message-ID: <200909101116.55098.jnareb@gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 11:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlfm6-00057Z-KX
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 11:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbZIJJQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 05:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZIJJQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 05:16:56 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:33647 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbZIJJQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 05:16:54 -0400
Received: by fxm28 with SMTP id 28so3245598fxm.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=63wNc9EKW2YT+FZ9n9yAR8ef2McnePGmgFQRimrWMNY=;
        b=dyWbzJiPunNp2aTtmH/poqMRErANTulDQG0xXAxF7/1CwgIBcXkYgwUQeTo9MUk6oI
         G5ZviSh9/R/FxGrfBl+bUd8nqxUlaa8lgCyzGyccFEhbksdOVMegDY6qqJ9X/sWXu3kX
         Dq7NaZyl67h8goikR6Odf0VHiiOeQPb/ZjUco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KOYjvE0/7vg8YClKA+P0loayUntSo0GitlzVNwWumsq9koFsHK70ZHlnECZEWZCF/Z
         SMHr6Uiel99JV3TeJUE1TmeLAPPSF+XLJblM+ouNp8IOZB/1lgzroRrTshw86l/WA1XD
         v6QQ7k0vfZsFOQTHc7X8M6JsPFTH9h4dLOzkk=
Received: by 10.86.20.8 with SMTP id 8mr940092fgt.44.1252574216764;
        Thu, 10 Sep 2009 02:16:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwt218.neoplus.adsl.tpnet.pl [83.8.243.218])
        by mx.google.com with ESMTPS id d4sm1010587fga.15.2009.09.10.02.16.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 02:16:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128101>

On Thu, 10 Sep 2009, Brendan Miller wrote:
> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:

>> Brendan Miller <catphive@catphive.net> writes:
>> First question: which git version do you use?
>=20
> It sounds like a bunch of things have been fixed in yet to be release=
d
> versions. That's great.

Both "git init --bare" and cloning empty repository are in _released_
versions.
=20
>>> This is what I want to do 90% of the time, so it should just have t=
he
>>> proper defaults, and not make me look at the man page every time I
>>> want to use it.
>>
>> You learn those idioms.
>=20
> I guess. Is that a good thing? Is the goal of interface design to mak=
e
> it difficult so I need to learn a lot of things, or easy so I can
> remain blissfully ignorant but still do what I want?

There are at least two issues:
1. What you want to do 90% of time might be not what other people want
   to do 90% of time.
2. Some thing are due to git philosophy (like e.g. "git commit -a").
=20
As to git-archive example: first, git-archive _has_ default format, and
it is tar.  Second, compression is better left to separate program, but
I guess we can follow GNU tar example and add equivalents of -Z/-z/-j
and --use-compress-program options when using --output=3D<file>.  Third=
,
when using e.g. tar you have to specify files to compress, so I don't
know why you complain that git-archive requires equivalent, HEAD in you=
r
example.

>>> 6. Where is the bug tracker? If people users can't find the bug
>>> tracker, they can't report issues, and obnoxious bugs go unfixed, o=
r
>>> people have to whine on the mailing list. There should be a nice bi=
g
>>> link on the front page of git-scm.com. A bug tracker is really the
>>> only way for the vast majority of a community that use a tool can g=
ive
>>> feedback on the problems the tool has.
>>
>> Do you offer to maintain and manage such bug tracker? =A0I mean here
>> taking care of duplicated bugs, tracking which bugs are resolved and
>> which are not, checking if bug is reproductible, etc. =A0Do you?
>> Unmaintained bugtracker is worse than useless.
>>
>> Using mailing list for bug reports and for patches is time-honored
>> workflow, which works rather well for smaller projects such as Git.
>> Note that git mailing list is free for all; you don't need to
>> subscribe to send, and you can watch it via many archives and gatewa=
ys
>> (like GMane).
>=20
> Bug trackers are a hassle, believe me, I know... but I think they
> contribute to the overall quality of the product if used effectively.
> Mailing lists seem like a good way to forget about bugs after people
> have given up on getting developers to fix them.

This is a good way to separate important from unimportant bug reports
and feature requests ;-)

>>> 7. Man pages: It's nice we have them, but we shouldn't need them to=
 do
>>> basic stuff. I rarely had to look at the man pages using svn, but
>>> every single time I use git I have to dig into these things. Frankl=
y,
>>> I have better things to do than RTFM.
>>
>> Learn. =A0If you learn the philosophy behind git design, you would h=
ave
>> much easier understanding and remembering git.
>=20
> I think what you mean by philosophy is the underlying data structures=
,
> which are discussed in the manual (how many apps do you have that do
> that!). I have read that. However, that one needs to understand
> underlying data structure is just one more hurdle to understanding
> git.

No, I didn't mean understanding underlying data structures, but=20
understanding philosophy: graph of revisions; tracking contents; refs
as pointers to graph of revisions; the trifecta of working area,=20
the index and repository, etc.

> If I use GCC, do I need to know that it has a recursive descent
> parser? That it is implemented with a garbage collector? No. I just
> need to know that I give it C, and it gives me a binary.

Better example would be using "make".  You need to understand 'make'
philosophy to write all but most simple of Makefiles.

>=20
> Example:
> gcc main.c
>=20
> Think about all the defaults that are specified here! I don't
> explicitly tell it how to find libc.so or what path the dynamic linke=
r
> is at. I don't even really need to tell it which operation it is
> performing, i.e. generating a binary, .o, .so, .os, .a, etc because i=
t
> has a smart default.

And if you are smart, you never use this form, but "gcc -o main main.c"=
=2E
And you have to specify '-lm' if you use math routines.  Not that simpl=
e,
isn't it?

> This an order of magnitude more complex than any git operation in
> terms of implementation, but it is dead simple from the users
> perspective.

When git (or the concept of DVCS) is as old as gcc (or C compiler) is
now, then we can talk.
=20
>> There is "Git User's Manual", "The Git Community Book", "Pro Git" an=
d
>> many other references.
>=20
> Yeah, I've been reading them. I'm saying that the docs are a crutch.
> RTFM is the problem not the solution. It makes the user do more work
> to avoid fixing usability issues.

When the tool is more complicated (like DVCS), you can't use it in all
but simplest cases without understanding it.

> A CLI has some inherent limitations in that it doesn't have big
> labeled buttons to press. However, that doesn't mean it has to be har=
d
> to use. I think a lot of the strength of the linux CLI is that most o=
f
> the utilities have actually pretty well thought out interfaces that
> have been refined over time. That one's that aren't like that... well=
,
> no one uses them.
>=20
> I'm not saying that a unixy approach is wrong, but that most unix
> utilities are much easier to use than git, and that git needs
> improvement on this front.

I'm not saying that git doesn't need UI (and documentation) improvement=
s.
But first, your attitude is a bit grating, and second, your examples
are not it.

On the other hand there is inherent problems that serious git=20
contributors use git for a long time and are used to (and perhaps even
attached to) git UI warts, and newbies which start to use git not alway=
s
can distinguish between things that can be changed and things that cann=
ot
be changed.

--=20
Jakub Narebski
Poland
