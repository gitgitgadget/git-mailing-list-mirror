From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Yes, SymPy should be LGPL! (please help)
Date: Sun, 16 Nov 2008 03:07:53 +0300
Organization: St.Petersburg State University
Message-ID: <20081116000753.GA9636@roro3>
References: <85b5c3130811121247j753cccf1n6b50b58288381f0a@mail.gmail.com> <20081115114859.GB23252@phare.normalesup.org>
Reply-To: sage-devel@googlegroups.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: sage-devel@googlegroups.com, maxima@math.utexas.edu, ginac-list@ginac.de, linux-kernel@vger.kernel.org, git@vger.kernel.org, mercurial-devel@selenic.com, cairo@cairographics.org, wine-devel@winehq.org
To: sympy@googlegroups.com
X-From: grbounce-60hXnQUAAABFvx7nY45b2TKNb9O83K5M=gcmss-sage-devel-3=m.gmane.org@googlegroups.com Sun Nov 16 01:11:01 2008
Return-path: <grbounce-60hXnQUAAABFvx7nY45b2TKNb9O83K5M=gcmss-sage-devel-3=m.gmane.org@googlegroups.com>
Envelope-to: gcmss-sage-devel-3@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VEA-0005TF-7q
	for gcmss-sage-devel-3@m.gmane.org; Sun, 16 Nov 2008 01:10:58 +0100
Received: by yw-out-2122.google.com with SMTP id 8so97235yws.63
        for <gcmss-sage-devel-3@m.gmane.org>; Sat, 15 Nov 2008 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-transfer-encoding:in-reply-to:organization
         :user-agent:x-google-approved:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=pWAJ/KB3n/VMOpqfbC7u49eQebEQ+D9DEPNV/zfy/mA=;
        b=Pwf5retBhNLCM05UCifP6VcUyZRJg+6HqakMRdyrOaAr1DbDPi8T+7jnjBiH/GFbwY
         Ym0jrRINZl1qbOc9b2Zmnfbg63iHxj+SplyA5VknIstkqZY20ya6FzZAhbZcvuS5Eff9
         Z01Smj6hxJbbtHAkh1KeiAJZDvvV/5P25ePwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:message-id:references:mime-version:content-type
         :content-transfer-encoding:in-reply-to:organization:user-agent
         :x-google-approved:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=P0fi3p5+N+PxXUtVwIV6t4Pjsm70p1+RMwIG+34owHbCkUmxII92BjM23Ai4EiJphd
         HlDErkE4LCvWOBhCkMVKgK1pzqoOiuY676ixzXXTAUzBVhy6cUVwh+K5VPNUwdPN/1ZN
         tCqDcCCVzKRrzAku4JPsC9dQ5iM1ri2FqFb8w=
Received: by 10.90.98.12 with SMTP id v12mr209313agb.27.1226794178244;
        Sat, 15 Nov 2008 16:09:38 -0800 (PST)
Received: by 10.44.190.49 with SMTP id n49gr18626hsf.0;
	Sat, 15 Nov 2008 16:09:26 -0800 (PST)
X-Sender: kirr@landau.phys.spbu.ru
X-Apparently-To: sage-devel@googlegroups.com
Received: by 10.151.147.17 with SMTP id z17mr1652241ybn.28.1226794025988; Sat, 15 Nov 2008 16:07:05 -0800 (PST)
Received: from vs281.server4u.cz (vs281.server4u.cz [81.91.85.31]) by mx.google.com with ESMTP id 22si2132067yxr.1.2008.11.15.16.07.04; Sat, 15 Nov 2008 16:07:05 -0800 (PST)
Received-SPF: neutral (google.com: 81.91.85.31 is neither permitted nor denied by best guess record for domain of kirr@landau.phys.spbu.ru) client-ip=81.91.85.31;
Authentication-Results: mx.google.com; spf=neutral (google.com: 81.91.85.31 is neither permitted nor denied by best guess record for domain of kirr@landau.phys.spbu.ru) smtp.mail=kirr@landau.phys.spbu.ru
Received: from localhost ([127.0.0.1] helo=roro3) by vs281.server4u.cz with esmtp (Exim 4.69) (envelope-from <kirr@landau.phys.spbu.ru>) id 1L1VCT-0001lu-HF; Sun, 16 Nov 2008 01:09:13 +0100
Received: from kirr by roro3 with local (Exim 4.69) (envelope-from <kirr@roro3>) id 1L1VBB-0005yw-R4; Sun, 16 Nov 2008 03:07:53 +0300
In-Reply-To: <20081115114859.GB23252@phare.normalesup.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Google-Approved: wdjoyner@gmail.com via web at 2008-11-16 00:09:25
Sender: sage-devel@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list sage-devel@googlegroups.com;
	contact sage-devel+owner@googlegroups.com
List-Id: <sage-devel.googlegroups.com>
List-Post: <mailto:sage-devel@googlegroups.com>
List-Help: <mailto:sage-devel+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/sage-devel/subscribe>,
	<mailto:sage-devel+unsubscribe@googlegroups.com>
X-BeenThere-Env: sage-devel@googlegroups.com
X-BeenThere: sage-devel@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101101>


[First of all, sorry for off-topic to those lists not related to SymPy]

     This email is posted here in hope to reach people who share my
     point of view, and to ask to please help to

     _____________________________________________________
    /\                                                    \
    \_| Advocate switching SymPy license from BSD to LGPL |
      |                                                   |
      |   ________________________________________________|_
       \_/__________________________________________________/


Start of this thread is here:
http://groups.google.com/group/sympy/browse_thread/thread/b5addd939ee0c803


Introduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Currently SymPy is distributed under new BSD license.

But this was not always so -- originally the project was licensed under
GPL (!), but in the beginning of 2007, after Pearu Peterson has proposed
to switch to LGPL or BSD [1], developers decided to take permissive
approach -- BSD.

I've joined SymPy project later - in 2007 summer, and now I'm
proposing we change SymPy license to LGPL (Lesser GPL) which I
see as a golden median between beeing too permissive (BSD) and too
strict (GPL).     |
                  |
                  v
        BSD ---- LGPL ---- GPL

      +------------------------->
                       strictness


Read below why

[1] http://code.google.com/p/sympy/issues/detail?id=3D138


On Wed, 12 Nov 2008 13:24:39 -0800, Robert Kern wrote:
> FWIW, my vote is for BSD. I, personally, don't work on (weak or
> strong) copyleft projects. Copyleft licenses are intrinsically
> attached to an agenda which I don't share so I don't use them. I'm not
> a fan of agendas.
>=20
> I can see the point for some pieces of software where there is a known
> threat (e.g. the LGPLed work on GMP gets enhanced slightly by a
> proprietary product and resold with lots of bragging about how they're
> better than the open source GMP), but is there an actual threat to
> sympy? Hypothetical threats don't impress me much.

Really?

Even if it is not evident to the casual observer, in the begginning of a
chess play, there is already a threat to your figures, and your king and
queen, so chessplayers usually try to analyze the situation early and
look into the future for at least several turns. And the player, who can
analyze more turns than the other, wins.


My understanding is that SymPy is close to enter "serious CAS" market,
and as Ondrej says below, SymPy has a lot of potential. To me what is
needed to be done for this is to go into compiled mode for core, and to
refine core design and it's data structures. Plus constantly trying to
apply SymPy to real-world problems, so that we could be sure we have
good engine connected to good user interface.

As during the last year I've touched both internal and high-level stuff
quite a bit, I think I'm keeping my hand at pulse here, and my
understanding is that together with all the polishing, assuming the
previous temp of work, this transition should take 6 - 12 months.

And after this transition is done, wouldn't it be like the case with
GMP, in which you say you see the points for LGPL?

Only then it would be late (or much more difficult than today) to protect
SymPy from abuse -- That's why I care *now*.


On Thu, 13 Nov 2008 01:54:23 -0800, Andy Ray Terrel wrote:
> This is something of a tough discussion for me, mostly because I
> disagree and agree with a large number of points made here.  I
> ultimately reject that the 4 freedoms of Richard M. Stallman (RMS) are
> some how fundamental to a computer user.  I prefer the arguments given
> by Lawrence Lessig, that a free culture is a better more productive
> culture.  RMS does make a very nice point that a way to preserve this
> free culture is to practice the 4 freedoms and require those who use
> our software to comply.  Lessig's Creative Commons licenses allow for
> this structure as well as others.  Nevertheless I also hold firmly
> that it is rather the community of developers and not the legal
> structure it stands on that make open source such a great experience.
> I and many friends have developed BSD, GNU, and proprietary licensed
> software with similar goals to promote technology and human progress,
> much less motivated by secret agendas or monetary reward.  A lesson I
> have learned, projects that are *only* about money are never the
> innovators of technology.
>=20
> The debate I do agree with RMS on is in the view of labor rights of
> the computer programmer.  Programmers are not the first community of
> artisans where it is easy to manipulate their works for personal gain
> rather than that of the community.  By following a copyleft license
> the computer programmer is investing in her community and protecting
> that investment from those who would falsely claim the work as their
> own.  Agreeing with Linus Torvalds, this does not mean to me one
> cannot work with proprietary projects but rather the investment in the
> community creates better software.  The BSD license protects the
> developer, the GNU set of licenses protect the community.  I find a
> nice balance in the LGPL license because it does allow proprietary
> development and marketing but still protects the community.

Yes, in essence, this is what I'm advocating for:

    a nicely balanced LGPL license which allows proprietary development
    and marketing but still protects the community

> You are going to lose users for many reasons. Losing them because do
> not wish to conform to policies in place to protect the creative
> investment of the community is not a bad reason.

Yes, users and developers come and go.

A lot of people listed in our README already went away for various
reasons. Some did not fit into team-development and respect-each-other
and dont-break-existing stuff rule, some got afraid of patch review (I
suspect I was the main source of disaster), some got busy with other
stuff, etc...

It is not possible to be good for everyone -- that's why I don't try to
satisfy all the people, but instead try to be good for me myself, and do
whatever I think is better for me and for SymPy code, and if the result
could be somehow useful for others - I don't mind at all.

I hope that the last year shows that this approach worked quite well.

> I think sympy is a great community not because of its license but
> because of the people and I will continue to invest in such a
> community no matter what the license.

Likewise did I.

I've put licensing stuff on shelve in harder times, just to concentrate
on technical bits and defend SymPy. But after that investment (it was in
spare time + several day offs, compare with e.g. 6 months full-time
grant sponsored development of sympycore [1]), it became much more evident
that developers effort have to be protected.

Yes, to me developers effort have to be respected and protected. And if
this could be done in a compromise way, it should be done.

Please read below, where I'm advocating LGPL in more details.

[1] http://code.google.com/p/sympy/wiki/SymPyCore


On Thu, 13 Nov 2008 09:27:29 -0800, Vinzent Steinberg wrote:
> First of all I want to thank you, Kirill, it was great to enjoy your
> support. You are certainly one of the most constructive persons I
> know.

Thank you Vinzent for you kind words. This proposition gives me one more
reason to think that this time, I'm too proposing something
constructive.

> I think the problem is quite fundamental. Many developers are
> investing quite a lot in an open source project, and they don't want
> others to modify it without profiting from their modification. This
> point I perfectly valid.
>=20
> Given that sympy would be picked up by an company and they would turn
> it into a closed source mathematica2, some sympy probably developers
> would say: "Great, this draws much attention to our open source
> project, and we will profit from the research they will do, because we
> can see how they solved problems, even if they don't share their code
> with us. And after all, it's better they invest in this area without
> sharing code than not investing anything (due to restrictive
> licenses)." For this kind of developers, the BSD license is better,
> because they think it's better for the project and the code in their
> opinion.

I'll tell you one story about me and physics:

I was working on some physics research and developed my own routines
pack for this. At seminar, after I've talked about current progress, one
of my collegues asked me:

    "Kirill, you have done nice job with developing you routines pack,
     may I borrow them for my research too?"

Sure, my answer was

    "Yes, please. Here you are."

On the next seminar that collegue was talking about his progress, and he
mentioned my routines, and that he enhanced them a bit.

This time, I've asked him:

    "Nice job, could you please give your versions of my routinse to me?
     I'd like to use them too"

and, the answer was

    "No, I can't. I need the result to be published first, so that I
     have acknowledgment for my research. After I'll publish the
     results, I'll give you your original routines enhanced by me"

I thought.

    "Ok. I was not going to compete with this guy and steal his credits
     in the first place anyway, but it seems he wants to be extra sure
     in this, so even if it is a bit pity, that I can't use the
     enhancements yet, so be it."

Time has passed, and on the next seminar, my collegue was talking about
his new progress, and mentioned his recently published paper with great
results obtained with the help of my routines. It turned out that this
time, they were again enhanced slightly more.

I've asked him:

    "Now you have your paper published, could you please give me my
     enhanced routines, so that I can use them for my research too?"

I was sure, he would say "yes, please", but I've made a mistake:

    "No, if I give you your enhanced routines, this would make us equal,
     and I could not be sure to win this tasty new grant we'll be
     competing for on the next week."

I thought huh!? How is it possible that I've shared my research in the
first place, and now he says he is not going to do the same, even when
his work stood on my basis?

Needles to say, that the next time, when I talked about my progress and
new software which I had to develop along the way, I refused to give it
to my collegue, because I though that he plays unfair:

    "Last time you took my routines and enjoyed using them, but when I
     asked you to share your enhancements, you refused for various
     reasons.

     So why should I give my work to you this time?"

This conflicting situation became known to our management, and they
tried to analyze it and asked me:

    "Kirill, at our department we do different kind of research, and we
     have lots of groups. How we work was always cooperative in spirit -
     we always used to share the results internally and give advices to
     each other.

     Yes, sometimes there is concurency between groups, but this was
     never an obstacle for cooperative research, because everyone is
     aware and confirming to good science ethics - not to publish
     overlapping results before the original author.

     Why are you refusing to share your work with collegue?"

I told them that we used to share codes, but somehow contributing flow
became unidirectional, and that I think this is not fair to only take
and not to give back:

    "I'm ok with my collegues developing their own private codes, even
     if they are using mine, but I'd like them to share back their
     changes to _mine_ code. It's _their_ behaviour which is not
     cooperative."


This story is imaginary, but I think it fairly well illustrates
qualitively the situation I have in mind. You can think of two
physicians, two mathematitians, or sympy development community v.s. some
company which ships locked down sympy to its customers.

And it's this "we only take and locally modify" which I propose to
legally prevent.


---

As to

   "Great, this draws much attention to our open source
    project, and we will profit from the research they will do, because we
    can see how they solved problems, even if they don't share their code
    with us. And after all, it's better they invest in this area without
    sharing code than not investing anything (due to restrictive
    licenses)."   =20

I disagree that in the long run, the original project will profit.

Practice shows that instead, usually it's closed neighbour draw
developers (key developers are usually just hired) and users, but after
this happens, the main project stays with even less resources, and this
strikes back at both open and closed projects. End of story.

Please read below about how this happens.


> But others would mention: "I want my project to be open, closed source
> is completely useless for me. I spent my work to let others share, not
> that someone grabs it to make money with it without giving anything
> back to the community. Freedom is one of the most important things
> about our project, and this company is destroying freedom. Because
> they have more resources they will have a more polished product and
> drawing off our users and contributors. It's ok if they use it to earn
> money, but they have to give something back"
>=20
> These opinions are quite polarized and are probably not well
> formulated by me. Mainly I want to say that both opinions are equally
> right. It's up to everyone to decide which license and use of his very
> work pleases him most and to respect the decisions and motivations of
> developers preferring other licenses. You can't make both groups
> happy.

You *can*. For example glibc being mostly LGPL is used by every program
and every library on Linux system, including e.g. Python which is
BSD-like licensed, and every proprietary program which runs on GNU/Linux.

My point here is that LGPL (Lesser GPL) is a good compromise between
beeing too strict (GPL) and too permissive (BSD).

Actually my license would be the "Fair use of SymPy"

"""
    Fair use of SymPy
    -----------------

    You can use SymPy as you want, and we encourage you to build various
    products on top of SymPy including commercial and closed-source ones.

    Your own code that uses SymPy as a library can perfectly stay
    proprietary.

    But if you change SymPy itself -- you have to share your modifications
    to SymPy, your other code still stays yours.

    To legally state what we think is our "Fair use of SymPy" we adopt LGPL
    license.
"""

As last line says, its simply LGPL who is the closest-in-spirit
translation of this terms which is composed by legal-aware people and is
tested.

> An example for such an scenario is Wine. They switched from MIT to
> LGPL due to a company not contributing changes back to the core
> project.

Yes, Wine is a good example.

And before switching, they were too wanting "Wine to be used as wide as
possible" - that's why they were licensed by MIT (similar to BSD).

But when they started to be abused by TransGaming (who developed closed
WineX and did not contributed back their changes), they decided to
switch to LGPL, because LGPL'ed Wine is still perfectly allowed to be
used by essentially any software (closed and open), but changes to Wine
itself have to be always made shared with whom you distribute Wine.

http://wiki.winehq.org/FAQ#head-72731b215bbd1ce36e3b84ac7ce114925ce16460
http://wiki.winehq.org/WineHistory

So they changed from BSD to LGPL and this is what happened:

"""
The immediate effect was the creation of the ReWind project to further
the X11-licensed codebase. Many key developers agreed to allow their
additions to be used by both the X11 and LGPL Wine code. Most have
decided to focus their efforts on synchronizing with the LGPL'ed Wine
and the vast majority of development and new features appear there
first. Picking a favorite software license is left as an exercise for
the reader.

Shortly after changing the license development began to pick up at a
greater pace. More patches began to appear, Alexandre made more CVS
commits, and more applications were reported to work. By the end of
2003 DLL separation achieved a milestone with the split of the
kernel32/ntdll combination. Most of the architectural changes to
support a beta release were in place. Another developer's conference
was held in January, 2004 in St. Paul Minnesota sponsored by
CodeWeavers. Once again, a roadmap was laid out for tasks that needed
to be completed.
"""

So it seems LGPL also boosted Wine development.


> I would count myself to the first group (I wouldn't mind if a company
> would do such things to sympy), but I comprehend very well others like
> Kirill who do not want this.

Yes, I strongly mind when someone only takes, modifies, and gives
nothing back. As said above, I'm ok if anyone takes SymPy and uses it in
a closed-source proprieary product, but if he changes SymPy itself, I
strongly mind for that SymPy-changes to be closed.


> > "make private modifications to sympy and keep them secret."
>=20
> If I understand the GPL correctly, it won't prevent this. It does not
> force you to give modifications back. It only forces you to distribute
> your program with sources. This means they can keep modifications
> private as long as they don't sell the software. And this practically
> means that modifications won't be secret of course. :)
>
> I don't like that GPL is so viral. It's often incompatible to other
> open source licenses. But it's a great choice if you want to to avoid
> these "private and secret modifications".

Please, why are you talking about GPL here?

I'm proposing LGPL which is a different, "non viral" license [1].

When you mix GPL here, you create confusion, and I think that confusion
is the first step towards creating FUD (Fear, Uncertainty and Doubt)
[2].


As to you statement - yes, I don't care about someone keeping private
modifications without redistributing them -- all I care about is
redistribution, and this is covered by LGPL.


[1] http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License
[2] http://en.wikipedia.org/wiki/Fear,_uncertainty_and_doubt


On Sat, Nov 15, 2008 at 12:48:59PM +0100, Gael Varoquaux wrote:
> On Wed, Nov 12, 2008 at 09:47:18PM +0100, Ondrej Certik wrote:
> > it's a very nice and honest email. Kirr has done a stellar job over
> > the past year and half and we definitely would not be as advanced with
> > sympy without him. I'll reply to his arguments in my next email.
>=20
> I'll use my mail to reply mainly to Kirr (I hope he is still listening)
> because I hugely respect and value a man who has invested a large amount
> of quality time in a community project.
>=20
> Kirr, you have been a fantastic actor of the project. You are now saying
> that you are tired. This is actually a fairly common problem. We all
> fight with lack of time, to many various interests. Software development
> comes with its load of difficulties and disappointments. Too much
> sacrifices ruin private life.
>=20
> I am off course very sad if you quit this project that I follow (without
> contributing, sorry) and in which I believe. However, what I really want
> is to thank you for all your work. I hope you had as much fun as
> possible, and I hope that your will keep good memories of your time with
> sympy, rather than the reasons that made you quit. And besides, no
> decisions is irreversible. I believe that you will have friends in the
> sympy team whether you are contributing or not. Life and friendship are
> more important than software.=20

Thanks Ga=C3=ABl for your words too.

Being friends is one thing, protecting the results of hard work from
abuse is another one. That's why I'm here.

> > But I'd like to use this occasion to make a survey among our
> > developers and users ---- do you think we should stay with BSD, or
> > switch to LGPL?  I am interested in all opinions from anyone. Whenever
> > there is some occasion, I am discussing this with people around sympy
> > and so far my observation is that most people either prefer BSD, or
> > don't mind either, but would like to hear good arguments why LGPL
> > should be better. There are also some who clearly prefer LGPL, for
> > example Kirill or some people from the Sage community, but I think
> > given all the circumstances (i.e. sympy aspiring to become the
> > symbolic manipulation library for Python, and together with numpy,
> > scipy, matplotlib, mayavi and others form a BSD like environment for
> > scientific computing, that people can build on and given the community
> > where sympy belongs), the right license for sympy is BSD.
>=20
> We have discussed this a few times, including over a few beers in Prague,
> you know my point of view. I won't dwell on it long.
>=20
> Briefly. I personally realized that I don't care much about the license
> of the software that I write. I care more that it is used by as many
> people as much as possible. The thing that worries me most with software
> is the amount of wheel reinvention, and lousy, half-complete,
> implementations of a solution to a given problem. This is why I believe
> free software has a future. This is indeed the Lessig point of view. The
> reason I feel a BSD license help is that many companies (especially large
> ones) are not afraid of hiring scores of developers to reinvent the
> wheel, just because they want to possess it and control it. The driver
> for free software adoption in companies is not cost, but control.=20

Yes, usually companies wants control, and usually that control hurts the
project. That's why I think that SymPy should be independent from any
company at any give time.

Please read below about it.

> Of course the license debate changes whether you consider your software
> as a component, that needs to be integrate in a larger infrastructure, or
> as a finished good.

> Linux, (GPL, fantastic example of free software success) is clearly a
> finished good.

You forget that it was not "finished good" from the day0, but it was GPL
from almost the begginning. Also, please note, that in Linux kernel case
GPL works essentially like LGPL -- please read about it below.

So it *evoloved* to "finished good" with the license it carries today. And
even before Linux was _started_, FreeBSD & friends were already there,
right?

How it turned out that today Linux outperforms (my subjective point of
view) FreeBSD with respect to almost all areas? For example FreeBSD had
much better networking stack than Linux some years ago, but today the
situation is different.

Doesn't it points that somehow the license is too mixed into success?

To me, the answer is "yes" - read about below why.

> Wine (now LGPL) may also be a finished good.

The same points as with Linux kernel - it too was not "finished good" from
the start, plus as said above Wine switched to LGPL to protect itself
from abuse back in 2002.


And even today, both Linux and WINE are _not_ finished goods.

They are developing at a very high pace - especially Linux. For example
transition from 2.6.26 to 2.6.27 which lasted for ~ 3 months brought a
lots of new features [1] and had ~ 10000 (ten thouthands) commits (!)
[2]. Compare this with SymPy, which has ~ 2500 commits for _all_ its
history! Roughly saying every new kernel version is like ~ 3-4 man-work
of the *whole* sympy development and this is even more, if you'll bear
in mind, that the kernel patch quality rules are much higher than in
sympy.

I'd not call it as "finished good."

[1] http://kernelnewbies.org/Linux_2_6_27
[2] http://lwn.net/Articles/302061/

> Scientific computing libraries on the other hand, are not
> finished goods. A company, or a research lab, may want to fork them to
> keep a competitive advantage, and maybe not even redistribute the
> resulting binaries. And that's fair enough by me, because I think the
> world is a better place if these people use my software as a start,
> rather than building on crappy bases.

As pointed above "finished good" or not is not an argument for me.

Besides, don't this people constantly reinvent "lousy wheels"? And why
the world is a "better place" with those "louse wheels" forked from your
base.

Wouldn't it be better to cooperate on common playground?

> besides, if they later decide to
> share, it will be possible if the built on common abstraction. Finally, I
> hope that as the world evolve, people (mostly managers and lawyers) will
> understand the gain that there is to share 90% of the code, may it be
> with 10% kept secret for a competitive advantage.

My point is that we should not wait untill those managers understand
something (or not), but create a world in which a manager that does not
understand this something, can't effectively manage, so he/she will just
have to educate him/herself.

Read about this below.

> For me the golden example of successful free scientific software is VTK.
> VTK is a 3D plotting library. 3D plotting is a forever-reinvented
> problem. Each particular application is actually fairly simple, but when
> you try to do something a bit more general, it gets really hard. So
> people (companies, research labs) start out with a specific problem they
> want to solve, and code a quick implementation, then as they evolve,
> their small implementation grows to be a huge one, and most of the time
> lies on crappy abstractions and data structure. VTK was born as a spin
> off of GE: the code used in medical visualization was split off to a
> start up (Kitware) and BSDed. GE still have their own proprietary bunch
> of codes, for their medical devices, but VTK lives on, and unites the
> efforts of many companies and labs with diverging problems and goals. In
> the case of VTK, individual actors have learned that they need to
> contribute back, because the cost of have their own abstraction and
> algorithm to maintain and to impedance-match with the rest of the world
> was very high. They make a careful decision as to what is open-sourced
> and what isn't.
>=20
> This is my model of development, and my 2 cents.

I can't say about VTK, because I don't know this area, and also I admit
there are good projects under BSD license but wouldn't the same work if
VTK would be LGPL'ed?

Let's forget for a moment that some companies are afraid of *GPL, and
try to see -- what would be an obstacle to keep VTK, which is open,
under LGPL, and to keep private additional development private?

For me it's better to have clear rules, what _have_ to be always common
and belong to everyone. When such rules does _not_ force other
not-covered components (e.g. an aplication which uses sympy) into which
license to use, I call it non-intrusive.

And to me, LGPL is non-intrusive (read about glibc, libgcc, and wine
v.s. picassa) and it protects developers. That's why I propose we use
it.


On Wed, 12 Nov 2008 13:59:07 -0800, Ondrej Certik wrote:
> On Wed, Nov 12, 2008 at 8:44 PM, Kirill Smelkov
> <kirr@landau.phys.spbu.ru> wrote:
> > Compared to bad science, or locked down or proprietary software, it is =
a
> > very good thing!
> >
> > I'd like to explain better, but now I'm too sleepy, and I have 10
> > minutes left, and tommorow I have to go to work and concentrate there
> > ...
> >
> > <so from now on it goes unstructured>
> >
> >
> > What is important is that the software should be free as in free speech
> > - one should always be able to:
> >
> > - run it
> > - study it
> > - modify it
> > - share it
>=20
> Yes. You should also be able to compile it (=3Drun it) using only free
> software. E.g. that's what Debian main distribution preserves.
>
> > There are mechanisms to legally make contracts with software users,
> > which protects this freedom, mainly strong copyleft (GPL) and weak
> > copyleft (LGPL).
>=20
> It is important to note, that not even GPL protects all kinds of
> "abuse". In my opinion, the far bigger "threat" are the internet based
> applications, like gmail, that are completely without sources and the
> companies can even run GPLed code behind it --- but you have no chance
> to study/run/modify or share the program.
>=20
> But as long as I am not forced to use such a service, I don't mind.
> And I use gmail, because it's good. But I don't have to, I can
> administer my own email server and use mutt. As long as I have this
> second option, I don't mind using non-free software (I also sometimes
> use google earth and skype and picasa and other things). I just don't
> want to depend on it.

Yes, such kind of thing exists. Let's try to agree on our terms "in
spirit" first -- if we do - we'll work all the technical and wording
details out. Is my "Fair use of SymPy" ok? If so, let's just adopt
closest existing solution on license market which is not-intrusive.

Agree?


NB: Also I think that every time you say "I can" (administer your own
mail server, use mail client, ...), and someday you need to turn some of
this points into reality, multiply the probablility that the whole thing
will happen, say by 0.1 for each 'can'. Then you'll understand, that
when there are too much this "can(s)", what you get in essence is that
you can't.


> > From almost the beggining I was talking to Ondrej that I think it's
> > better to use LGPL for SymPy, that is anyone could be able to build
> > application or other libraries whichever license they choose (including
> > proprietary) on top of SymPy, but SymPy should always stays free as in
> > free speech. Mainly one should be disallowed to "make private
> > modifications to sympy and keep them secret."
>=20
> Here we disagree. For me personally, this right is very important,
> that not only I, but anyone can make any modification and do what he
> wants with it, including keeping it secret.

What's your rationale on this? Why you need the right to keep
modifications of sympy secret? Is there any reason this is good for
sympy?

As I've stated above I strongly mind about secret modification which are
redistribted in closed form, and I think this is not fair.

Read below about my understanding of why you need to reserve such rights
as "keeping modifications secret."

> > LGPL is a good compromise, and it does not force users of a library int=
o
> > any license, so why can't it be used.
>=20
> Well, it depends on your personal point of view, but many people,
> including me view it in a way that it forces, because LGPL is not
> compatible with every license out there. Actually, I think there are
> even some problems with mixing LGPL 2 and LGPL 3 code.

I'm not a lawyer, but as I've said above, isn't GLibc (coverd by LGPL),
which is used by essentially *every* program, is not a problem? What
about libgcc (GPL + linking exception) ?

I insist on that we should settle on "Fair use of SymPy", and if we do,
it would be straightforward to adopt the closest license out there on
the market, and work out all the details to eliminate license
incompatibility out there if any.


> > Why on earth, say I as a hobbyst, spending my spare time, would want th=
e
> > result be used as a starting ground for closed software? BSD allows it
> > explicitly, and this is not ok with me.
>=20
> I respect your point of view and I think it's perfectly consistent.
> But I don't share it --- I am also a hobbyist to some extent, well as
> to sympy I still am, and I just want my code and my work to be used.
> Because I believe it is good for me and the whole community in the
> end. I do sympy because I very strongly believe in its potential and
> that we get to a point (and we are almost there) where I could use it
> regularly for my research. For example our recent work with Brian
> shows, that we could actually do atomic physics using only open source
> software in Python. That's very exciting.
>=20
> And if someone uses it in some commercial product? I believe it will
> help us, not hurt us. I believe it's about the community which is
> around sympy. Commercial product can have a community, but a different
> one --- I am pretty sure we all use sympy exactly because we have the
> source code and because it's opensource.

Commercial !=3D Closed

You can build a commercial product on top of open development. An
example of this is CodeWeavers (CrossOver -- WINE) and RedHat (RHEL --
Fedora)

I think commercial parties are ok, and essential for success, but the
whole thing works well, when there is no control in one hand, and when
parties (commercial or not) play by the same rules.

Also, since I propose we use LGPL, it would be perfectly possible to
build proprietary/closed software on top of sympy.

What's the problem with this?

> > Actually at my work, With one of my collegues, we've made an
> > observation, that usually motivated people, who are interested first in
> > developing interesting things, to achive great result, to care about th=
e
> > project and it's ecosystem in general, and only then in money, usually
> > prefer LGPL to BSD, and on contrary side, people who tend to work for
> > money first, and care less about result, about fitting their developmen=
t
> > with others, about achiving good results, pushing harder when needed,
> > prefer BSD. They usually say that "BSD is the license that companys
> > prefer, and for which they pay money"
>=20
> I think both ways are possible. I believe that Python itself and all
> the BSD like tools around it show that people can do BSD software and
> care about the project.

There are exceptions from the pattern, and examples of both good BSD and
bad LGPL projects.

Every project is somewhat unique with additional balancing forces (e.g.
PostgreSQL - read below), but to mee the tendency is clear.


> > Do you see the pattern?
> >
> > LGPL, being a fair contract, is good for everyone -->
>=20
> Here we disagree. I respect that for you "LGPL is good for everyone".
> But for me, "BSD is just as fair for everyone".

How is it fair, if let's say I've developed sympy for a year in my spare
time at evenings, and someone would just take it, work on it full-time
and enhance it, and sell it, and keep the modifications secret?

It seems we have different understanding of fairness.

And what about GLibc which is LGPL'ed? Any problems in using this
library? I bet 90% of people out there even dont _think_ of this issue
when they run their programs, that they depend on Glibc.

Another news: libgcc (The GCC low-level runtime library) is licensed by
GPL (!) + linking exception [2]  and is used by every program which is
compiled with GCC !. No problem with this???

[1] http://gcc.gnu.org/onlinedocs/gccint/Libgcc.html
[2]
http://git.infradead.org/gcc.git?a=3Dblob;f=3Dgcc/libgcc2.c;h=3D5a82f82f7cd=
2f2e2ff8a19b157ec13529b3d8251;hb=3DHEAD

> > (e.g. GTK+ is LGPL'ed, and there is a lot of free and proprietary
> > software which uses it without a problem)
> >
> > --> is choosen by people who care, whereas BSD is choosen by people who
> > want money first.
>=20
> I understand what you mean. But I don't think that people around
> sympy, or scipy or numpy don't care and want money first. So I
> disagree with that statement.

Actually some people we all know want money first [1], or stop working
on their "babies" after their grant is finished [2], or want to be paid
working for companies which want to keep their modifications secret [3],
...

Other's (usually more young) just don't understand the issue and don't
care about licensing --

-- BSD is essentially a gift, and you know when you are a student you
can afford yourself to give gifts whatever way you like, and also there
was a culture in the university to share things "simply" -- this is all
good. -->

  HISTORICAL REMARK: BSD-like licenses were born in the universities,
  where the research and development were done on taxpayer's money, so
  it was logical that the result belongs to all the taxpayers --
  basically everyone -- commercial and open parties -- all the people.

  That's why BSD-style licenses are so permissive -- actually BSD, MIT
  and the like are very close to Public Domain.


  Today most of the development is not done on taxpayer's money, so
  likewise, there is no obligation for the result to stay close to
  Public Domain -- that's why usually software developers who do the
  actual work in their spare time are those who decide on which terms
  they distribute the software.

--> But we are not in the university where there are > 95% good people, and
why would I want some bad guy to use the code I spent my time on to use
in a bad way? I say - 'use it as you like, but if you enhance it, you
cannot enjoy your advantages alone - you have to share this'. I think
this is 100% fair and thus LGPL is 100% ok with me.



[1] http://code.google.com/p/sympy/issues/detail?id=3D748#c25
[2] http://landau.phys.spbu.ru/~kirr/cgi-bin/hg.cgi/sympycore--hg/
[3] http://groups.google.com/group/sympy/msg/74a5c4bc7506ab68

> > Money is ok, but I even can say that usually who want money first, get
> > _less_ money than people who do care about the project in the first
> > place.
>=20
> Yes, I agree. I believe in american dream which says that you can get
> what you want, but you need to work hard and it may take a long time,
> but you'll get there eventually.
>
> > Also I can say that in our company we use a lot of LGPL'ed software, an=
d
> > this is legally 100% ok, and that we even sponsor some LGPL'ed
> > development, so to me there is just no rational reason why LGPL is not
> > good for SymPy.
>=20
> There are pros and cons to all three BSD and LGPL and BSD. You stated
> the pros of LGPL. The cons is that LGPL creates a barrier of
> contributions, from a lot (but not all) people and also usage, because
> simply LGPL is more restrictive.

1. What is the usage barrier of LGPL? I remind you about GLibc, and
   libgcc. Please answer in details about this barrier - to me it is
   mythical.

2. What is the contribution barrier of LGPL? I know there are people who
   hates GPL (no L) and automatically projects their attitude on LGPL,
   and also that there are companies who like BSD and cultivated this
   (read about it below).

   But what rational is in this barrier?

Also, as you say that LGPL creates barriers, I state that BSD *TOO*
creates barriers:

    Look, they say GPL is viral, and some time ago I undersood that BSD
    is viral *too* -- it forces all to use BSD -- look at scipy -- they are
    reluctant to take LGPL parts even it it is (maybe) legally ok to ship
    combined BSD + LGPL library (part1 is BSD, part2 is LGPL)
   =20
    so BSD creates barriers TOO.

This is also justifed by people like me, Gary from SAGE and others
refusing to contribute to a BSD licensing projects.

> Whenever you put more restrictions (I
> am not saying it is necessarily bad) you lose some users. So while
> LGPL is maybe good for sympy, BSD is imho better.

1. As shown above LGPL does NOT create barrier for _users_,

2. With BSD you loose (at least) some developers (me, Gary, other SAGE
   people)

So why is BSD better, when LGPL being almost the same for users,
protects _developers_? Because companies can't "keep their modifications
secret"?

> > I've failed to win Ondrej's mind, and I think I'll fail to convince mos=
t
> > of you, and it makes me very sad, that so much evident common sence is
> > not accepted, that I stopped thinking to be like at home with sympy
> > recently.
>=20
> I am sorry about that. But I think it is not a common sence.

I insist on it being common sense.


> > either having a rest, going for a walk, for a talk with a human you
> > love, or either to develop sympy, is _precious_.
>=20
> I agree with this too. We all die once, so our time is limited and so
> we should spend it very effectively.

Yes, but effectivness depends on what you trying to achieve. If someone
wants to make money, he is effective in his own way.

I want sympy to be useful for me first, and to protect it from abuse.
Also I think in such a case it should be useful for people like me,
e.g. physicists.

Untill now I think I was effective in makeing SymPy useful, but not
effective in protecting SymPy from abuse.

And now I'm trying.

> > For me I just can't afford to spend that _precious_ spare time without
> > legally protecting the result from abuse.
>=20
> I think I understand how you feel. But as I said above, I think LGPL
> maybe protects some abuse in some situations, but definitely not all
> abuse in all situations (see my example with gmail above) and also
> from the way you look at it, I don't even thinkl it is abuse --
> depends on circumstances of course.

There is no 100% perfect solution, but this does not mean we should not
at least create some protection. and as i've already said LGPL is a
compromise between BSD and GPL.

I've tried to show in every possible detail, that with LGPL in fact
there is just *NO* barrier for users, and (to me) very irrational
barrier for developers + BSD creats its own barriers, while, as Andy
said LGPL protects the community.



Summary
=3D=3D=3D=3D=3D=3D=3D

BSD is bad because weird companies can take the code and eat it and give
nothing back. Big examples are:

Microsoft, who took BSD IP stack,
Apple who took code from FreeBSD to their OSX

http://en.wikipedia.org/wiki/BSD_licenses#Proprietary_software_licenses_com=
patibility


Let's also look at what other developers think:

Linus: =E2=80=9Cmaking Linux GPL'd was definitely the best thing I ever did=
.=E2=80=9D

    http://en.wikipedia.org/wiki/History_of_Linux#Linux_under_the_GNU_GPL

Fernando: "I happen to actually really like the LGPL."

    http://groups.google.com/group/sympy/msg/5f757166b695d35c

Gary:   "I will never contribut to BSD project"

    seen on IRC if I recall correctly


Gael:   "Companies like BSD because they can keep their modifications
         secret"

    http://groups.google.com/group/sympy/msg/74a5c4bc7506ab68


Pearu:  "May I propose something that is more relaxed licence model than
         GPL: LGPL or BSD-like that numpy has?"

    http://groups.google.com/group/sympy/msg/1a1ee12c8c2928c1

Ondrej: "What I like on GPL is that if someone takes it, he needs to
         distribute his changes and code also as GPL, and cannot just
         steal it and used it in a proprietary product without releasing
         his code as opensource. I have nothing against someone taking
         our code and selling it, however, I want him to release it as
         open-source (GPL). I think that's fair."

    http://code.google.com/p/sympy/issues/detail?id=3D138


         but then you conclude that "BSD is better than GPL"


Kirill: "I understand that licensing is only part of the game, and in
         hard times I put the question on the shelve fighting against
         the fork and defending SymPy, but now when I'm almost exhausted
         I just cant afford myself spending _precious_ free time and
         _health_ on SymPy if it is under BSD license, because companies
         like M$ or Apple or someone else can take it and make it
         proprietary.

         I'm 100% ok for someone selling sympy, makeing proprietary
         applications or other libraries on top of it, but I 100%
         request for me that sympy itself must be always free as in free
         speech.

         LGPL is good for both: for me it's sympy protection, for
         other's it's fair use, even if they want to make their products
         proprietary.

         It's fair, and it's a win-win for all!



         Companies who benefit from BSD cultivated that "BSD is better
         than GPL (and automatically LGPL)" mood just to benefit them.


         When you are a student with lots of free time and energy, you
         are "young and naive," and can afford yourself to ignore the
         issue, but

         I think when it boils down to that you have eps free time to
         work on the project and you spend your health on it, you have
         to think very carefully whether you can afford yourself to play
         this game.

         I still love SymPy very much, but the price to play this game
         under BSD rules is just too high for me."


    this mail



Also interesting:

    http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License

    http://www.dwheeler.com/essays/floss-license-slide.html
    http://www.dwheeler.com/essays/gpl-compatible.html
    http://www.dwheeler.com/blog/2006/09/01/#gpl-bsd


In Linux kernel case, GPL effectively works like LGPL!
------------------------------------------------------

That's because we can think of the kernel like of a libary, to which we
make system calls from user space. And since GPL works only at kernel
space, user-space code can use whatever license it finds best, so see,
this

    user-space  |  kernel-space

partitioning works similarly to

    application |  library,

or

    library2    |  library1

partitioning.

And since Linux license don't affect anything beyond that borded I claim
that in practice this works *exactly* like LGPL.

And now:

> Linus: =E2=80=9Cmaking Linux GPL'd was definitely the best thing I ever d=
id.=E2=80=9D
>
>     http://en.wikipedia.org/wiki/History_of_Linux#Linux_under_the_GNU_GPL

and

>     http://www.dwheeler.com/blog/2006/09/01/#gpl-bsd


P.S. in that blog from 2006 dwheeler says that BSD projects can do fine
too, e.g. Apache.

I have news for you that now M$ is actively trying to affect apache
development:

http://lwn.net/Articles/291628/


P.P.S. BSD encourages companies to build on BSD code and hire brightest
developers, but as described in that blog entry from 2006 it's bad for
the project and it's bad for that developers in the long run.

For some time I started to think most of scipy/numpy/sympy developers
are positive about BSD because this opens job opportunities for them at
enthough/etc...

I really hope that Linux example shows that with good managment and
"must cooperate" (i.e. can't keep modifications secret) rules, talaneted
team and bright ideas, it should grow up and

    set _our_ rules for companies instead of being driven by potential
    sponsors wishes and desires.


This all shows that Protected-Freedom and Independence is always good.


And again, this is *weak* copyleft! Anyone can build proprietary things
on top of it!


If there are people, who share my views, please

 __________________
( Vote for LGPL!!! )
 ------------------
        o   ^__^
         o  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||


Thanks beforehand,
Kirill.



Appendix I
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

For the reference here are some excerpts of our internal conversation
with Ondrej which I've edited and extended. I only quote myself so I
think this is ok.

The text is a bit sharp -- that because I call things by their names.


SymPy was already abused
------------------------

SymPy was already abused ("old new core" and [1]), and if i recall
correctly, it was me, who told you what to do ("lets do patch review")
and defended this and made everything possible to not letting the
project split.

Now I'm telling you that when we move forward, sooner or later, there
will be another kind of abuse, but you don't want to listen to me. It's
a pity and makes me sad.

[1] http://code.google.com/p/sympy/wiki/SymPyCore

Community is not weaker
-----------------------

The problem with your approach is that you implicitly assume that
community is always weakier and companies are always stronger, so it's
better to receive at least anything than nothing.

But I say, that is should be that every player plays on a common ground
-- a company, a developer, a community at large, another company -- all
must have equal rights with respect to sympy.


Freedom have to be protected
---------------------------

(1)
And when you are only in university environemtn that's ok, but I think I'm =
not
that dense case who got up almost up to phd in university and also to maybe=
 the
same level in industry.  And being in both this two places i can say for su=
re:
"freedom have to be protected" i think people part to those who know this, =
and
to those who will know this.

(2)
My another topic is that freedom *have* to be protected. BSD was ok in
universities when/where there was already a culture to share scientific
results, (at least after they are published).

But this days we have another situation -- there are a lot of greedy
people/companies, when SymPy matures they could take it as a start, hire
qualified developers, and run it.

We are hobbyst, it would be impossible to compete with full-time gang.

I hope you at least agree with "Fair use of SymPy". If yes, I take the
task to find relatevile easy way to make it legal and try to convince
people. ok?


On John Hunter's License Pitch
------------------------------
(http://www.scipy.org/License_Compatibility)

Grr, I'll sumarize what John pitches about LGPL:

1. many companies are still loath to use it because of their phobias
2. you cannot reuse LGPL code in a proprietary product

That's all.

My answers:

1. If a company does not understand what our license means what could we
  do? All the world understands it, and if we'd put "Fair Use of Sympy"
  before the license to show our spirit I think it would be clear for
  99.9% of people.


2. You *can* reuse LGPL code in a proprietary product in the form of
  library -- look at glibc - it is LGPL an every program reuses it. After
  all good code reuse is not copy-paste, but reuse in form of libraries,
  so what is the problem here??? (Yes, if you want to modify the library,
  you have to share your changes, but only to the library, and other your
  code stays only yours)

We all BSD, Proprietary, LGPL, GPL, DONTCARE *use* LGPL library - at
least glibc (LGPL) and libgcc (GPL + linking exception).

What's the problem?????!

LGPL is the golden median between BSD and GPL
---------------------------------------------

When I first knew about Linux and Free Software, it was a "no question"
for me that it is a good thing, and I just wanted to be part of it. And
I took it the balanced way - LGPL. For me it is absolutely ok when I use
LGPL'ed library at work when we ship proprietary software, and I just
don't understand why it is bad for others. I take BSD and GPL as
extremes in this respect, but why, just oh why the balance can't work?

LGPL examples in common use both in open and closed worlds
----------------------------------------------------------

Yes, and I've shown you other examples recently:

 - winelib(LGPL) + google picassa (?) for linux (proprietary),
 - gtk(LGPL) + lots of written stuff both open and closed,
 - glibc (some small parts BSD, most LGPL) + everything,
 - libgcc(GPL + linking exception) + everything.


On about most of scientific stuff around Python is BSD
------------------------------------------------------

Yes, it turns out most of scientific code around Python is BSD, and some of
the code was _forced_ to change it's license to BSD (IPython was
essentially _forced_ to go LGPL -> BSD [1])

I claim again, that because it benefits some companies, they created
such a pro-BSD athmosphere and they've reached criticall mass.

But again I say -- just open your mind and drop this bullshit -- you
started from fair rules:

"""
What I like on GPL is that if someone takes it, he needs to distribute
his
changes and code also as GPL, and cannot just steal it and used it in a
proprietary product without releasing his code as opensource. I have
nothing against someone taking our code and selling it, however, I want
him
to release it as open-source (GPL). I think that's fair.
"""

Just substitude GPL -> LGPL and this is ok for all.

With LGPL we are _not_ forcing anyone to be of some particular license
-- software B which uses SymPy can be of esenntially _any_ license both
proprietary and open.

All we need then is good team and hard work and if we succeed they will
_have_ to use us.

But I really don;t care about whether we are in EPD.

What I care about is that SymPy is useful and fast for my physicists use
cases, and also I care about other guys problems who ask questions in a
constructive manner.

And I claim that doing so and starting from small set of goals, if we do
everything right we'll achieve greater goals. Success is _never_ planned
-- we should just do what is best for us. And it is _completey_ _fair_
to use some weak protections -- LGPL. By myself and Gary and a lot of
other developers I can say that they actually _care_ to which project to
contribute -- a lot of them tend say "will never contribute something
nontrivial to BSD."

[1]
http://projects.scipy.org/pipermail/ipython-dev/2004-October/001398.html


LGPL says "must cooperate"
--------------------------

Let's ask ourself - to help what?

If it is just used by Mathematica - that's no problem in any case -- in
BSD and in LGPL, because we explicitely allow that both in spirit and in
legal words.

But didn't Wolfram ever hit any bug in gmp? Even a small bug?

I doubt it -- no software is perfect.

So if

a) they are hitting a bug, and
b) they want to ship modified gmp

they _must_ cooperate on gmp.

Even if they don't send patches to gmp itself, they have to provide
sources to their users, and soon they should learn that maintaining lots
of patches could sometimes be problematic.

So they are essentially _forced_ to fix that bugs and contribute back.

In this sense LGPL helps, and BSD don't.


And also, should they wish to enhance gmp non-trivially they will _have_
to cooperate, because gmp is LGPL. I don't know what the probablility
for this is (Wolfram wants to enhance gmp), but I'm sure it is not zero.

And voala, all should benefit for _sure_.


BSD is in fashion
-----------------

(1)
Companies like Enthough and others who benefit from BSD code tought
some developers to "like" BSD. Some really believe BSD is better, some
just want to be in fashion and to have job oportunities.

I want fair use and freedom. (and I'm ok for others to build other
software components on top of SymPy whatever license they want,
including proprietary), so it's not viral!

(2)
I don't see much legal problems with LGPL v2 and LGPL v3 -- all problems
could be overcomed if one want this thing in spirit, but what I see now
is that new generation

 "Does not want to care at all"

And all those viral BSD nature only helps it -- everyone wants to be
BSD, so there are no "legal obstacles and scary things" people could get
afraid of. That's it - most people just don't want to care because they
were taught not to, and the only lesson from history is complete
oblivion of all of its lessons, its only ~ 20 year ago, all the world
was "proprietary"...

Kirr wants protection
---------------------

(1)
Look at me, Fernando, Gary etc.

Initially I was in a shape and could afford myself working on sympy
without protection, but when it started to be very tough, I have to
either have 100% protection or stop risking my health. So you see, at
least from me and Gary "BSD is less patches," and also Fernando says he
likes LGPL very much, so I'm grateful to Pearu that he started his fork
-- I had to overwork myself and feel very strongly that the issue must
be resolved or I have to stop spending my time.

I don't want to force anyone, but also I don't want to force myself to
play by the rules I can't accept.

(2)
Because I don't want SymPy freedom to depend on us always being good
managers and always being full of time and energy etc.

I want protection and insurance, that in no case it goes proprietary.

Why? Becasue I've put and I want to put my energy and my soul into the
project, but I can't afford myself for SymPy to go proprietary or be
forked or be used unfair and I want to be 100% sure.

So not "why not LGPL," but I myself subjectively want a _must_ have
protection. For sure, 100%.

(3)
As I'm telling you all the time, BSD is ok for proprietary closed forks.
LGPL protects and enourage to give back.

Now with good management we'll have better chances to run, but even if
we fail at management, or will run completely out of time, or someone of
us is hired by e.g. Enthough,

    SymPy always stays independent and free as in free speech.


With BSD they could hire some key developer(s) for full-time job and
tell them control SymPy -- _they_ will decide whether SymPy stays open
or closed. Developers are just "engenieers".

I think if I care about the project, I have to protect it from the above
scenario, and so I think you'd better too.

(4)
You ask "why LGPL?", the answer is that

 LGPL does guarantee that something stays free as in free speech always.

In contrast BSD does not provide such guaranties - one can jump to
proprietary at any point.

(5)
But doing things right is always harder than flowing along the stream...

Unfortunately to prove myself right I'd need two things:

1. a lot of time passed to see what way SymPy evolves and how it is used
2. realized probability that SymPy is misused.

I don't have this two, and I admit that good managment could keep BSD
only project out of bad guys too, but this managment should be *really*
good and have to last forever...


Kirr thinks the same as DWheeler
--------------------------------

But isn't the following just my imagination?

Company X hires key developer Y.

Y develops advanced features that go to X's product only. It takes users
from 'open' version of the project and starting from some time you
either have to re-implement what Y did in their private branch or
somehow join them.

This is extreme case, but I think not so impossible.


Why companies like BSD and why LGPL should be good for them too
---------------------------------------------------------------

I know Google prefer BSD or X11 or whatever is equivalent.

They do so here like Enthough -- to have the ability to get the code at
any point and close it and make benefits from it.

I'm not saying they will do so, they try to do it socially first -- to
get momentum and benefit, but when things comes to serious competiotion
they will do so, I'm sure.


My example was that LGPL allowed Google perfectly ok to build its
proprietary product on top of WINE and that's ok for all.

If SymPy was first developed by some company it was that company choice
which license to use, but when it is developed by individauls I think
_we_ choose.

And you know I advocate for choosing for balanced protection.


On PostgreSQL
-------------

As to PostgreSQL - yes, it's BSD, but it was originated first in BSD
environment and now PG core developers team _carefully_ avoid working in
one company -- to keep the balance and independence.

So in PG case they managed to keep it up and running and be independent,
but I think everything would be simpler if it will be LGPL.

Too often I hear from people that they would not contribute to a BSD
licensed project exactly because of the reasons I think, and this is not
only around SciPy.




EPD can ship LGPL
-----------------

So my point is this:

a. for immediate users it is equally both good to have either BSD or
   LGPL

b. but for users starting to be developers, and developers who put their
   soul into a thing, it is important that the software stays free as in
   free speech.


So if LGPL is ok for users, and LGPL protects software, what's wrong
with it?


They usually just compare BSD with GPL, and don't look at the golden
median. Some becase they don't understand the topic, others because they
want to benefit from BSD:

 o companies: they can keep control on the code and release BSD+their
   modifications closed, and tie customers to them

 o developers: some of them want to be hired/contracted by such
   companies, and thus they play by their rules.


I think _we_ should set the rules, not some company, and if _we_ manage
SymPy to be succcessful product, EPD would just be _forced_ to ship it.

It's just bullshit they can't ship LGPL.


--~--~---------~--~----~------------~-------~--~----~
To post to this group, send email to sage-devel@googlegroups.com
To unsubscribe from this group, send email to sage-devel-unsubscribe@google=
groups.com
For more options, visit this group at http://groups.google.com/group/sage-d=
evel
URLs: http://www.sagemath.org
-~----------~----~----~----~------~----~------~--~---
