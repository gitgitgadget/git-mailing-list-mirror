Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA42C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719D6610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJUL7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:59:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:43303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhJUL7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817420;
        bh=aDcxvNVdvdR+zKWUXWTSWLh8RDQDnT1aU7SUzxpIwU0=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=WY/G9npXuGn9+nsZc1aK7u+EiCHAWHgskZcmZhlAQuANhE3rXYOhscrD7NPrac56F
         n+4VdEnuU0qcXBBeEmdF9fU6085Mx1/1hkJ7LLpQeZzy3z0RopIk3xVDicMgrh3v+k
         aGGCU0S+bd7eBcXnSFMdQxIhuOTSnIrzAMoXSXUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1mGfr92t6l-00Ua95 for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:57:00 +0200
Date:   Thu, 21 Oct 2021 13:56:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Increasing diversity & inclusion (transition to
 `main`, etc)
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211149530.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-46107303-1634817035=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356540.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:pu2rbHMt+dQ9eh77x8MS5Gm+6ihsZkeIfGoOeVpx95HtKYHMk6k
 PwuX5wC8RMBo43Nnph9ho0QP8BkoQOBz1RNG56zccCyDXfcx/MSzBlTQ/n91uJyaEjrS1FT
 hJpl3a4NaGlf/vunnFPcfsIDbIZrmxNgh3evhnAU6yJ7i7L+bvn4Ysfo2qidTBIG9GtZ0BB
 FPnl6+GfRKKjVdt1qKnWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyY6Eti7TCI=:DYja8F/RY+cZ187F4kOX5M
 cj4QD3+sl+8rhjDlAaH83e6MVOpIo2VD4tL9uSdAXLFcesgdWpu0piAzl4CawmZagFtIK7xwx
 4xytx8Tf/bMJxYYONmgGzjwGwu4r2myMMxVDw2RLP+MFOH5SqTpuI16IDflX8YaqCoGejrw6M
 K59CTehoKcJ+7qGMt3Fff4D0W8X2tQRVUkVcbtdSZfW3sIUDOl62nvkfYp423LFuw88aWi41w
 lZD32VFeIv417s1iQr0VwiYOPJ/XUyX4XRAzxVQEXhp85Vi9LNrfC7KmiUKqv9uLzUkZBwpIU
 1mbH2HdYxjmtXAbCYwGxXBoDiF1qHgXFDjhX/YmHYM68S7TOr6PX+eCnC8s2N1dHtmF1nIILG
 wdlH2VyzqixBZkUc/E4NbnERWvY9r5ho4vkLJdd1/QVXcjvdqLB+e61C2rCoQzmehB3nkqV5Z
 bYjQH+5DR4/zPkG/mkDCWjpOT93wKzCx5XTc/HvM1KuwkZ3PR/tZev0qC9lCHfD7/YqeUDxfo
 U6i64kbW5a6lTNvvyfAgegBktazoTZVPFU5fBERrSWy1zmWxSaNbLTCZN7RXu4P3wauWV2pWp
 1keAKBr6woaml7BlSbP2V7q20UrU+hoMxHxI/wTTGqgHiGlrwjR8hPNXjP9pZd9FhWGAGE2p8
 1qPY6IcBIk9uyBazqxdbBcd0NBXYiHFqLe18vvw/dgockX2ybN7UV+ooipNKpFH4HsVyfjGIN
 cMMfcK6isIu3OhVfI4FgRvFRiFXjzjbpzq6nNIx6svDF1xrc+z6sMCOxQfP0WQtepWGcCrHA3
 +uccAEraNtVCK9TCd1gYHINSJh4tY0NV44YDr6ClsJJTg7VX/XTef7pviNo0TPGLHI38h95uY
 Uc/o8W1ONQ1cW09/BdN5zd2+yQIpM2JEDLcH2fNVjdnU0Om9BYGcHV7xz0rYJAfSpgV8nL6He
 igL5jf6PybRLzGgSOdm31Kn9CDVM67crTmCxo20tIZ8BBqmzvCTZIEZHvaO4wuyav2wiVbPJL
 SMbeENV0DsIC3EyhDfCMQYVvgYukzlRSVVWdHqGVh1qg7Q5voOS7gHLfIlS8jCqJ2Y9tqgl1c
 2hCkg4k5MGfZ7Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-46107303-1634817035=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356541.56@tvgsbejvaqbjf.bet>

This session was led by Johannes "Dscho" Schindelin. Supporting cast:
brian "Bmc" carlson, Jeff "Peff" King, Taylor Blau, CB Bailey, =C3=86var
Arnfj=C3=B6r=C3=B0 "Avarab" Bjarmason, Jonathan "Jrnieder" Nieder, Derrick=
 Stolee,
Lessley Dennington, Glen Choo, Philip Oakley, Victoria Dye, and Jonathan
"Jonathantanmy" Tan.

Notes:

 1.  Dscho: Background. If you look into archives, I myself have made a ch=
ange
     in communication style. Used to do a lot of judgmental code reviews, =
but
     noticed that interactions which are respectful and collaborative can =
be
     much more productive and enjoyable. I learned this from management he=
lp at
     $dayjob; it helps a lot to strengthen the team & product. Two people =
with
     different points of view working together make a better result than o=
ne
     person

 2.  Lately noticing more places Git can improve, for example default bran=
ch
     name =E2=80=98master=E2=80=99, which has huge impact on a lot of popu=
lation, esp. USA.
     =E2=80=98main=E2=80=99 is a very good alternative adopted by most hos=
ters (GitLab, GitHub,
     BitBucket, etc)

 3.  There is still work to do in documentation, other places. Some of the=
se
     changes can be wide-reaching so dscho trying to contribute them in a =
less
     painful way; soon hopefully we can switch the default without this op=
tion
     workaround. A lot of work, but the impact is worth it

 4.  Still, a tiny first step - let=E2=80=99s go further, both with Git th=
e tool and
     Git the community/list. Easy to forget there is someone on the other =
end
     of the email address who could feel discouraged

 5.  Git the community is still overwhelmingly male, white - what can we d=
o?

 6.  Bmc: the note about conversational tone is important. I=E2=80=99ve he=
ard from
     others, especially women that a confrontational review style is a tur=
noff;
     that=E2=80=99s true for me too. No longer interested in a 20-email de=
bate about
     something. Let=E2=80=99s look for a more collaborative approach on li=
st; when I
     point this out I don=E2=80=99t see a bunch of help backing me up, usu=
ally.

 7.  Peff: I like that bmc points out when folks aren=E2=80=99t behaving w=
ell; I often
     consciously don=E2=80=99t jump in to support you, because a pile-on i=
s a bad
     experience for someone who=E2=80=99s usually ok, and if it=E2=80=99s =
someone who=E2=80=99s truly
     awful, I don=E2=80=99t want to feed the troll - they=E2=80=99re prone=
 to escalate instead.
     Understandable that you could wonder on your end how your pushback is
     being received - we should be better about showing support.

 8.  Bmc: the goal is to make the list more positive; if I should do somet=
hing
     differently please tell me

 9.  Taylor: I=E2=80=99ve had conversations off-list with people who are s=
peaking up
     on-list. Stolee: +1, I reply (not reply-all) to say =E2=80=9Cyes than=
k you=E2=80=9D

 10. Dscho: Firstly, bmc, you=E2=80=99re a great example and I appreciate =
that you push
     back when you do. When I see just bmc=E2=80=99s reply and nobody else=
, it seems
     the offender is feeling validated and continues behaving that way (be=
cause
     nobody agreed with bmc publicly).

 11. Dscho: maybe we could be quicker to ask for a video chat when someone=
 is
     being harsh on list. Often when I point it out the quick response is =
=E2=80=9Cwell
     I thought it was fine=E2=80=9D and escalates.

 12. CB: I would be intimidated being invited into a private video call wi=
th
     someone on the mailing list when I=E2=80=99m a brand new contributor.=
 I have
     experience helping moderate the #include<c++> discord which tries har=
der
     to moderate aggressively and make inclusive environment. Moderation t=
akes
     a lot of load, but it might be a better alternative than instant dogp=
iling
     from all the senior Gitters. Maybe a happy medium to coordinate off-l=
ist
     first before everybody jumps on someone communicating rudely.

 13. Avarab: there are some instructions in the CoC about
     enforcement/escalation. We tend to take these reports off-list, so
     something does happen but it=E2=80=99s not so visible. Usually these =
resolve
     happily, but the list is left hanging, so it=E2=80=99s easy to get th=
e impression
     that nothing happened. At the same time, there are negatives to makin=
g the
     whole thing public.

 14. Philip: often common words mean different things between nationalitie=
s,
     this can get in the way

 15. Dscho: Thank you for taking on the task to be on the escalation list,=
 it=E2=80=99s
     hard. It can be really soul-draining, e.g. the GfW =E2=80=9Chow can w=
e make Git
     more inclusion=E2=80=9D issue. I had to stay away from the GfW fork e=
ntirely
     because I was so tired from trolling on that issue. From my point of =
view,
     the CoC is there to protect folks with less standing/representation. =
I
     thought for sure the CoC would never be invoked by a white male, but =
we
     saw it happen

 16. Dscho: for this session, hoping to find strategies to turn the tone a=
round
     on list and avoid issues from the beginning, throughout the
     project/community. Recently read Nonviolent Communication, has tips t=
o
     turn around the conversation even if it started poorly

 17. Jrnieder: are you saying someone in a position of power should never =
make
     use of the CoC? Dscho: I figured it was not there for me, it was ther=
e for
     people who don=E2=80=99t have the privilege I do. Jrnieder: A few thi=
ngs - CoC
     sets expectations regardless of who interactions are directed to;
     somewhere unwelcoming to established contributors but welcoming to ne=
wbies
     is still not an appealing place for some newcomers to invest in joini=
ng
     because they know they will one day be an established contributor.
     Secondly, if I have a dispute, having a guide for turning a potential=
ly
     problematic event into a productive event is really important. A proc=
ess
     that moves in that direction of nonviolent communication. Easier said=
 than
     done. But that=E2=80=99s part of making a friendly environment, and o=
verall that
     points to not treating the CoC as =E2=80=9Conly for some people=E2=80=
=9D.

 18. Bmc: the goal of the CoC is to produce and preserve the community we =
want
     to have. It should produce a place where everybody can participate fu=
lly;
     if we have an environment that=E2=80=99s unproductive or toxic we los=
e
     contributors. I=E2=80=99ve left projects over a poor contributor expe=
rience
     before, because it wasn=E2=80=99t worth my time to deal with the over=
head.
     Conversely, having a great and safe experience is a good way to attra=
ct
     diverse contributor base.

 19. Stolee: When we moved from MS to GH, we received quick feedback that =
we
     weren=E2=80=99t communicating well - too direct and unemotional. Mayb=
e Git
     community communicates that way, but that=E2=80=99s not how most peop=
le interact;
     that makes me think that our =E2=80=9Cefficient and effective=E2=80=
=9D communication is
     actually too aggressive, and easily interpreted as attacks on
     contributors. Basically=E2=80=A6 let=E2=80=99s all lighten up? :)

 20. Taylor: Yep, my =E2=80=9Ctalking to GitHubbers at GitHub=E2=80=9D voi=
ce is different from
     my =E2=80=9Ctalking to Gitters on Git list=E2=80=9D voice. New contri=
butors, are we on the
     right track here?

 21. Lessley: I made first contribution recently, and had been warned abou=
t the
     list, papers about the Linux kernel, and that open source contributio=
n
     could be a little contentious. I was really nervous and put it off, b=
ut in
     practice it was fine; I broke =E2=80=98seen=E2=80=99 which was embarr=
assing but was ok in
     general. Maybe I=E2=80=99d have more input if I had a larger contribu=
tion. I do
     wish I had gotten more review faster.

 22. Glen: I=E2=80=99m also a pretty new contributor. The communication st=
yle is a lot
     more direct than what I=E2=80=99m used to on the outside. But that do=
esn=E2=80=99t mean
     it=E2=80=99s unhelpful or unconstructive=E2=80=A6 but it takes some g=
etting used to. I had
     to put in a lot of effort to trust that folks meant well and were try=
ing
     to help, and that=E2=80=99s just how we communicate here. But I could=
 imagine it
     being really intimidating if people aren=E2=80=99t used to that kind =
of review.

 23. Taylor: To emphasize, I also remember when I started, I felt like peo=
ple
     were disappointed/upset by my contributions. Took me a while to
     internalize that people were trying to help me make my contributions
     better. So we should A) be careful to remember that new contributor
     experience, and B) be careful to set an example even in reviews with
     veteran contributors.

 24. Philip: Often different nations have different writing style. =E2=80=
=9CThanks.=E2=80=9D at
     the end of the email means =E2=80=9CThanks but no thanks=E2=80=9D in =
British English, but
     that=E2=80=99s not usually how it=E2=80=99s meant on Git list. I also=
 noticed it=E2=80=99s not
     well explained why something is a problem. Reviewer thinks everybody =
knows
     why they=E2=80=99re making some comment, but the person who proposed =
the patch
     really didn=E2=80=99t see the issue and won=E2=80=99t understand. We =
should give a little
     more background when pointing out an issue.

 25. CB: We=E2=80=99re not the only project that won=E2=80=99t land things=
 that aren=E2=80=99t
     technically excellent. It=E2=80=99s important on my team too, or else=
 the whole
     company falls over next week. We=E2=80=99ve had lots of internal even=
ts and talks
     about inclusive code reviews. The few extra sentences - =E2=80=9CThan=
ks for
     submitting, it looks great, the direction is good, I=E2=80=99ve got c=
omments
     because xyz=E2=80=9D - go a really long way. We recently had a new te=
am member=E2=80=99s
     =E2=80=9Cgood first issue=E2=80=9D turn into a 2 week ordeal, and tak=
ing the extra time to
     say =E2=80=9Cthis is good progress, it=E2=80=99s shaping up well=E2=
=80=9D was helpful to keep from
     discouraging our new teammate.

 26. Jrnieder: Chromium project has had a problem with this too, having ve=
ry
     high standards. So first Cr contribution would often just feel like a
     hazing ritual. The focus should be on helpfulness, not =E2=80=9Cdemon=
strate how
     much you care about the project by putting up with us=E2=80=9D

 27. https://chromium.googlesource.com/chromium/src/+/main/docs/cr_respect=
.md

 28. ^ This covers a lot of what we were talking about; a good reference f=
or
     better/respectful code reviews. Timeframe, tone, stating
     goals/expectations, etc. Should we adopt something similar in Git?

 29. 26. Bmc: It can be frustrating to spend a lot of time on a series and=
 then
         immediately get a lot of technical feedback, without any assuranc=
e
         that the direction is good. We should work harder to say =E2=80=
=9CI=E2=80=99m glad to
         see this patch, looking forward to seeing it land=E2=80=9D instea=
d of just
         pointing out things to fix. Or =E2=80=9Cthe way this patch looks =
vs. the last
         version is really great=E2=80=9D

 30. Dscho: One thing my manager does well is to lead by asking, to give s=
pace
     for me to reflect on what I just said and think about more perspectiv=
es.
     This doesn=E2=80=99t put me on the defensive right away. I=E2=80=99ve=
 made the mistake
     before by assuming any reply at all implies =E2=80=9CI=E2=80=99m inte=
rested in this
     feature=E2=80=9D - that=E2=80=99s not obvious, and instead my review =
comes out as =E2=80=9CYou=E2=80=99re
     doing this wrong, go away=E2=80=9D :( and I don=E2=80=99t know how ma=
ny people felt that
     and didn=E2=80=99t say anything, because they left.

 31. Victoria: Given the unique nature of mailing list reviews, even thoug=
h
     there are a ton of resources on how to give respectful reviews, it=E2=
=80=99d be
     useful to do a more specific guide for Git, discussing how to structu=
re
     review reply, how to follow up, etc.

 32. Stolee: We have discussed a =E2=80=9Cguide to reviewing=E2=80=9D in D=
ocumentation/, along
     with SubmittingPatches and CodingGuidelines. We avoided it because it=
=E2=80=99s a
     lot of work, and I=E2=80=99m also worried about the review of the rev=
iew doc.
     Would be a productive discussion=E2=80=A6.but a lot :)

 33. Jonathantanmy: Yep, I=E2=80=99m thinking of doing one like that, hope=
fully in a
     few weeks we can discuss it on list.

 34. Avarab: I think it=E2=80=99s a good thing to work on; we need to be r=
eally careful
     about what guidelines we pick and choose. Need to ensure an easy path=
 for
     new contributors so they don=E2=80=99t need to read hours of document=
ation for a
     typo fix. Plus we need to ensure that this doc is accessible for folk=
s who
     have different first language than English.

 35. Bmc: on git-lfs we have a contributor with very little English, so wh=
en we
     did the review I=E2=80=99d offer an alternative text, and we would wo=
rk together.
     That process was useful to come up with readable documentation in a
     helpful way. That is, proposing a solution instead of pointing out th=
e
     problem and saying =E2=80=9Cfix it=E2=80=9D can help a lot in scenari=
os like this.

 36. Dscho: Yep, this is important and will help us be more accessible to
     contributors whose English is not super top notch Cambridge exam :)

--8323328-46107303-1634817035=:56--
