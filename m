From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie grief
Date: Wed, 2 May 2012 06:14:46 +0530
Message-ID: <CAMK1S_jrDXvPTKt_Azk2BZm=N7SdgcvgAV7X1TEUvGhwcan_AA@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<4FA01C73.5000909@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 02:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPNga-0002rB-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 02:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab2EBAos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 20:44:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37210 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab2EBAor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 20:44:47 -0400
Received: by obbtb18 with SMTP id tb18so179350obb.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=93B50ztyja2odkpuSeg1Bpglg82nKD0lOhgWSbJC3QI=;
        b=HFkbO+AeB9D1CANhuZpzacBAzG1iNaIKl34V+CIYFksp/6sJ4rcVchMYQY2Oq3QSnS
         RCIgVo/676cvZ3HX3a23UWVyEOoJqjz0hBDEPwUyp4Tugg584uUARPklV4kkbumlQQbr
         DGQYBk7A2T3f8H5zYyEMVFB1tPmLqyl5WQHwXca3pyOoNtCZno7X0rjtKmkypL0Bz1DK
         D5Up6ijWRaASA+8XwFStlPFSoJyofYTSnCDiPLybGfbHZzgxfztA0yOEg/3cPXJjeVAj
         wvYRWQ3RzQmih3RXKJuFCEwFUIWcxJrGcHvS02Sfrah6yhBd+8pklEKeLyX+JDEvoTwl
         CoRw==
Received: by 10.182.11.40 with SMTP id n8mr6971299obb.32.1335919487062; Tue,
 01 May 2012 17:44:47 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Tue, 1 May 2012 17:44:46 -0700 (PDT)
In-Reply-To: <4FA01C73.5000909@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196774>

[I'm going to assume not copying the list on your reply to me was an
oversight, since there's nothing in the text to indicate it was
supposed to confidential or personal in any way].

[second, sorry about the multiple emails!]

On Tue, May 1, 2012 at 10:55 PM, Rich Pixley <rich.pixley@palm.com> wro=
te:
>
> On 4/30/12 20:44 , Sitaram Chamarty wrote:
>>
>> I've been reading the thread with interest.
>>
>> People who know far more than I do about git, its innards, and its
>> design have been responding in this thread so consider this a git
>> *user*'s point of view:
>>
>> On Tue, May 1, 2012 at 6:45 AM, Rich Pixley<rich.pixley@palm.com> =C2=
=A0wrote:
>>
>>> Multiple heads are the idea that a single commit can "branch" in th=
e
>>> repository and that both commits can be HEADS of the same branch at=
 once
>>> in
>>> a single repository. =C2=A0This allows a potential collision to exi=
st in the
>>> repository and to be pushed and pulled through multiple repositorie=
s.
>>> =C2=A0It
>>
>> That is bizarre; I have no other word for it.
>>
>> I teach git (occasionally), and if this feature existed I would
>> totally ignore it in my teaching material because I wouldn't know ho=
w
>> to defend or explain the need for "hydra branches".
>>
>> It's like having two people with the same first name *and* last name
>> (a situation that is not impossible in real life, but is rare and
>> almost always requires special handling).
>>
>> Does Hg do this?
>
> Yes, it does. =C2=A0"Hg merge" by default merges a second head into y=
our
> current working directory.
>
> It's a conceptual leap, I concur. =C2=A0Believe me, I'm going through=
 the


It's a conceptual leap I can do without; I'm bowing out of this discuss=
ion.

There's an ambiguity in the branch name now that, to me, is both
confusing and unnecessary.

It's like each branch name is now an array variable instead of a scalar=
=2E

We all know when arrays are better than a bunch of similarly named
scalars, but in *this* context I don't see why it is needed.

The fact that, (in later emails to others), you called this a basic
beginning need, or words to that effect, is just icing on top.

> reverse cultural shock now that git doesn't have this facility. =C2=A0=
But it's a
> leap whose idea has been around for over 20 years. =C2=A0It wasn't un=
til the
> daggy source code control systems like monotone showed up that it bec=
ame
> practical, but that was a decade ago now.
>
> The big win, of course, is that we can both push to the same reposito=
ry,
> (and through multiple repositories), and we can decide later whether =
we want
> to merge or branch permanently.
>
>> =C2=A0 That would explain why my (admittedly half-hearted)
>> attempts to learn it have failed -- whatever tutorial I used must ha=
ve
>> been written with the idea that hydra branches are intuitive and
>> logical and sane, but did not express the concept as clearly and
>> succinctly as you did.
>>
>> Thanks for this insight; my next attempt to understand Hg, should I
>> ever be forced into it, might actually succeed!
>
> It's really pretty simple. =C2=A0Your commit, (or push, or pull), alw=
ays
> succeeds, even if it's not at the tip of a branch. =C2=A0If it's not =
at the tip
> of a branch, then it creates a new tip.
>
> The word "head" here is problematic since git uses it in a totally
> different way. =C2=A0In git, "HEAD" refers to whatever commit is curr=
ently
> checked out. =C2=A0In hg, "head" refers to a childless commit. =C2=A0=
It doesn't even
> need to be on a named branch.
>
> --rich




--
Sitaram
