From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: An interesting opinion on DVCS/git
Date: Wed, 04 Mar 2015 16:25:07 +0100
Message-ID: <54F723D3.1050805@drmicha.warpmail.net>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com> <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com> <alpine.DEB.2.02.1503031642340.26501@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Lang <david@lang.hm>, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 16:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTBAy-0005dM-A8
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 16:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbbCDPZN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 10:25:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36811 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756899AbbCDPZK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 10:25:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6A14320A51
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 10:25:08 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 04 Mar 2015 10:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=WwYcarzuJ5XM1fAx6AWNdd
	AAaMY=; b=tY/lTfbsgnccR22+cbp0YzXYV52b1Bu+n0M4L2dtuTz1BJZHr0fI8e
	mSBakQSDIoLIWxfwORRuODO9yQxFkShAvN6osaHPilxGEuNlfihdEsKcs624reew
	sVzL4kh2GQchYtCgdKa+zDtUgKpwMB9FOkX43J51BJSSbTP8Mllu4=
X-Sasl-enc: qMoXa7iP/aeipJlgD9STcNCn/DKd2qFG8ZeXLPwJMeoS 1425482709
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B4DB0C0029D;
	Wed,  4 Mar 2015 10:25:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <alpine.DEB.2.02.1503031642340.26501@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264763>

David Lang venit, vidit, dixit 04.03.2015 01:53:
> On Tue, 3 Mar 2015, Shawn Pearce wrote:
>=20
>> On Sun, Mar 1, 2015 at 7:29 PM, Stefan Beller <sbeller@google.com> w=
rote:
>>> bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sani=
ty
>>
>> Indeed, a DVCS like Git or Hg does not fit everyone. And neither do
>> centralized systems like Subversion. Choice is good.
>>
>> However... I found some passages troubling for Git, e.g.:
>>
>> ---snip---
>> Git is so amazingly simple to use that APress, a single publisher,
>> needs to have three different books on how to use it. It=E2=80=99s s=
o simple
>> that Atlassian and GitHub both felt a need to write their own online
>> tutorials to try to clarify the main Git tutorial on the actual Git
>> website. It=E2=80=99s so transparent that developers routinely tell =
me that
>> the easiest way to learn Git is to start with its file formats and
>> work up to the commands.
>> ---snap---
>>
>> We have heard this sort of feedback for years. But we have been unab=
le
>> to adequately write our own documentation or clean up our man pages =
to
>> be useful to the average person who doesn't know why the --no-frobbi=
ng
>> option doesn't disable the --frobinator option to the
>> --frobbing-subcommand of git frob.  :(
>>
>> http://git-man-page-generator.lokaltog.net/ shouldn't exist and
>> shouldn't be funny. Yet it does. :(
>=20
> As for the different online tutorials, I'll point out that every univ=
ersity that=20
> supports it's students using Thunderbird has it's own version of a tu=
torial on=20
> how to use and configure Thunderbird. The question is if they are cov=
erying=20
> their one use case of how to use git with their service, or if they a=
re trying=20
> to duplicate the git documentation.
>=20
>=20
> There are two reasons for having multiple books out for a piece of so=
ftware
>=20
> 1. the software is horribly complicated to use, even for beginners
>=20
> 2. the software is extremely powerful, to to understand all the diffe=
rent=20
> advanced options, and when to use them, takes a lot of explination
>=20
> In the case of git, there's a bit of both.
>=20
> Part of the problem is that there are so many different ways to use i=
t (all in=20
> common use) that there isn't one simple set of insructions that will =
be right in=20
> all the different use cases (thus the value of services that force us=
ers to=20
> operate in one specific model providing a tutorial in how to use it w=
ith their=20
> service)
>=20
> At this point, Internet Lore says "git is hard to use", and if you ap=
proach any=20
> software with that attitude, you will find lots of things to point at=
 to justify=20
> your opinion.
>=20
> I'm not saying that there isn't room for improvement, I'm just saying=
 that the=20
> evidence provided is not as one-sided as they make it sound.
>=20
> David Lang
>=20

Yes, that article has a few really weak lines of arguments, such as the
tutorial count.

Also, that advice to "learn git from the file formats", which I hope
means something like "learn the structure, not recipes" is good advice
for learning any powerful toolset - rediculing it is not quite a proof
of intelligence.

And I don't think there's anything we have to regret about the basic
architecture of (the DAG/object structure of) git. (OK, the various
signature formats ;)

That being said, we all know how often we want to change the UI and
backwards compatibility keeps us from doing so. The UI could really
benefit from a fresh start, where, based on what we know now, we first
think about:

- How do we structure/denote subcommands within commands? E.g. to dash
or not to dash, default subcommand etc.

- How do we structure "read" commands vs. "write" commands? E.g. the
pairs "branch [-l]"/"branch <name>", "log"/"commit" etc.

- How do we name options consistently? E.g. -n=3D--dry-run everywhere

- How do we make working with the special git concepts more natural?
E.g. index, detached heads.

Michael
