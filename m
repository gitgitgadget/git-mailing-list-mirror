From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC: repository of handy git aliases?
Date: Thu, 18 Aug 2011 17:40:49 +0200
Message-ID: <4E4D3281.2050600@drmicha.warpmail.net>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com> <CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com> <CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com> <CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com> <4E4A76E7.2090100@drmicha.warpmail.net> <CAH3AnrpahkHtnu5QTRns-vVcCoj3Q8JM-mzytYF2ZC_EXjU7Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 17:41:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu4iJ-0000Jj-M1
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 17:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab1HRPkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 11:40:53 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36370 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755057Ab1HRPkw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 11:40:52 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9F295228C7;
	Thu, 18 Aug 2011 11:40:51 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Aug 2011 11:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5sLwivQlNCoOHMYuvaJcA8
	IOxdw=; b=MAm7f2ZPAu2nu51jWddg6GslLTSx8bBidBSX03vUliItkE3/AsiFMP
	zTnUssbEk1W+EM4mr9fccddfe7j+nYUMH+Thjo+Vlm4dVXeooH7CLW/SDvHxN7Hf
	41qK9nQ5K2atFl70bN7bgUT5j+mcnC2ZCiy5/yJC1KaTI8XD5KtgU=
X-Sasl-enc: L915oa412gfNzavCT2JcoHYQqT3dHZWV2lGUNX+90A5p 1313682051
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 05FB57A004F;
	Thu, 18 Aug 2011 11:40:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAH3AnrpahkHtnu5QTRns-vVcCoj3Q8JM-mzytYF2ZC_EXjU7Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179604>

Jon Seymour venit, vidit, dixit 18.08.2011 16:52:
> On Tue, Aug 16, 2011 at 11:55 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Jon Seymour venit, vidit, dixit 08.08.2011 12:43:
>>> On Mon, Aug 8, 2011 at 8:22 PM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>>>> On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.=
com> wrote:
>>>>> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:
>>>
>>> I've also added this...
>>>
>>> Listing the tips of branches in pu that are not in master
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Suppose you have two aliases defined like so:
>>>
>>> [alias]
>>>         oneline =3D !/usr/bin/xargs -L1 git log --decorate --max-co=
unt=3D1 --oneline
>>
>> How about
>>
>> oneline =3D git log --no-walk --decorate --oneline
>=20
> I still need to !/usr/bin/xargs -L1m, don't I? The point is to
> transform a list of SHA1s into a decorated list. But point taken abou=
t
> --no-walk being an alternative to --max-count=3D1.

Is this a typo or do you have an xargs which understands "1m"? My point
was that you can feed all tips to "log" at once, as long as you don't
exceed the argument list limits, of course.

>> git branch --merged origin/pu --contains origin/next
>>
>> (or with --no-merged, but put it first.)
>>
>=20
> So, the idea with tips is that it will show you the tips of
> independent lines of development that have diverged from origin/next
> (or before) that have been merged back into origin/pu. This works,
> even if you don't have branches assigned to these tips.

OK, that is different then.

[snipped discription]
>=20
>=20

[readding relevant part:]
>>> b166408 mergetool: Don't assume paths are unmerged
>>> b29d76f merge: mark the final "Merge made by..." message for l10n
>>>942cf39 receive-pack: Allow server to refuse pushes with too many ob=
jects

>>>
>>> which is a list of the tips of branches that are in pu, but not in =
next.
>>
>> That's not quite the standard --decorate, is it? ;)
>>
>=20
> Not sure what you mean by not being standard? The main idea about
> using --decorate here is to get a dump of any refs that might describ=
e
> the identified tips.

Just compare your output with this:

git log --decorate --no-walk --oneline origin/{master,next,pu}
a46e511 (origin/pu) Merge branch 'fg/submodule-git-file-git-dir' into p=
u

0e3f8f0 (origin/next) Merge branch 'master' into next

4bfe7cb (origin/master, origin/HEAD) Sync with "maint"

That is, I get the branch decorations there; you use the same format bu=
t
don't get any. But I may be misunderstanding completely what you are
trying to achieve. I guess I have to reread your extended use case
description...

Cheers,
Michael
