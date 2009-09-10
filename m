From: Brendan Miller <catphive@catphive.net>
Subject: Re: obnoxious CLI complaints
Date: Wed, 9 Sep 2009 17:09:31 -0700
Message-ID: <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 02:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlXXn-00079R-N9
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 02:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZIJA3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 20:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZIJA3i
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 20:29:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:65448 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbZIJA3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2009 20:29:38 -0400
Received: by qw-out-2122.google.com with SMTP id 9so566226qwb.37
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 17:29:41 -0700 (PDT)
Received: by 10.229.119.7 with SMTP id x7mr588921qcq.22.1252541371757; Wed, 09 
	Sep 2009 17:09:31 -0700 (PDT)
In-Reply-To: <m3fxavvl5k.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128092>

On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Brendan Miller <catphive@catphive.net> writes:
> First question: which git version do you use?

It sounds like a bunch of things have been fixed in yet to be released
versions. That's great.

>>
>> This is what I want to do 90% of the time, so it should just have th=
e
>> proper defaults, and not make me look at the man page every time I
>> want to use it.
>
> You learn those idioms.

I guess. Is that a good thing? Is the goal of interface design to make
it difficult so I need to learn a lot of things, or easy so I can
remain blissfully ignorant but still do what I want?

>
>>
>> 6. Where is the bug tracker? If people users can't find the bug
>> tracker, they can't report issues, and obnoxious bugs go unfixed, or
>> people have to whine on the mailing list. There should be a nice big
>> link on the front page of git-scm.com. A bug tracker is really the
>> only way for the vast majority of a community that use a tool can gi=
ve
>> feedback on the problems the tool has.
>
> Do you offer to maintain and manage such bug tracker? =A0I mean here
> taking care of duplicated bugs, tracking which bugs are resolved and
> which are not, checking if bug is reproductible, etc. =A0Do you?
> Unmaintained bugtracker is worse than useless.
>
> Using mailing list for bug reports and for patches is time-honored
> workflow, which works rather well for smaller projects such as Git.
> Note that git mailing list is free for all; you don't need to
> subscribe to send, and you can watch it via many archives and gateway=
s
> (like GMane).

Bug trackers are a hassle, believe me, I know... but I think they
contribute to the overall quality of the product if used effectively.
Mailing lists seem like a good way to forget about bugs after people
have given up on getting developers to fix them.

>
>>
>> 7. Man pages: It's nice we have them, but we shouldn't need them to =
do
>> basic stuff. I rarely had to look at the man pages using svn, but
>> every single time I use git I have to dig into these things. Frankly=
,
>> I have better things to do than RTFM.
>
> Learn. =A0If you learn the philosophy behind git design, you would ha=
ve
> much easier understanding and remembering git.

I think what you mean by philosophy is the underlying data structures,
which are discussed in the manual (how many apps do you have that do
that!). I have read that. However, that one needs to understand
underlying data structure is just one more hurdle to understanding
git.

If I use GCC, do I need to know that it has a recursive descent
parser? That it is implemented with a garbage collector? No. I just
need to know that I give it C, and it gives me a binary.

Example:
gcc main.c

Think about all the defaults that are specified here! I don't
explicitly tell it how to find libc.so or what path the dynamic linker
is at. I don't even really need to tell it which operation it is
performing, i.e. generating a binary, .o, .so, .os, .a, etc because it
has a smart default.

This an order of magnitude more complex than any git operation in
terms of implementation, but it is dead simple from the users
perspective.

>
> There is "Git User's Manual", "The Git Community Book", "Pro Git" and
> many other references.

Yeah, I've been reading them. I'm saying that the docs are a crutch.
RTFM is the problem not the solution. It makes the user do more work
to avoid fixing usability issues.

A CLI has some inherent limitations in that it doesn't have big
labeled buttons to press. However, that doesn't mean it has to be hard
to use. I think a lot of the strength of the linux CLI is that most of
the utilities have actually pretty well thought out interfaces that
have been refined over time. That one's that aren't like that... well,
no one uses them.

I'm not saying that a unixy approach is wrong, but that most unix
utilities are much easier to use than git, and that git needs
improvement on this front.

Brendan
