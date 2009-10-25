From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sun, 25 Oct 2009 12:43:08 +0300
Message-ID: <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <7vy6n065os.fsf@alter.siamese.dyndns.org>
	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 10:43:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1zd8-0004na-8O
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 10:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbZJYJnH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 05:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZJYJnG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 05:43:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:53840 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZJYJnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 05:43:04 -0400
Received: by fg-out-1718.google.com with SMTP id d23so751477fga.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iFPibSD8zdEGvJcDvR6++G1yh28JdCdzjzxT7xKiEtg=;
        b=qGm9nJGY8gEh8J9jQoDYCANvj4fxPfqpVfKz6+1br1JUg5fJhDXF1BRtEJ7lyFbg6o
         4M3KLvlcobnvxGYGB7LNtYJaxthRZA12+byNOuINe4TsD6O4UlklDcqIVJW8sSl7p078
         2qr6EYLXjFVGKLwU4OftxcuR4nGm3f8bBfvfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hb81qhl6po4SplO8y3lfShLv/1dp/OvVfUPrX2fDVykwOLQGuu5FWJY1LTV5+bsRUI
         mRC3mJ8ebAI0nRLpOkmGK8VpSSOHrsce12VIYGA280rAHmm+rW2MhPI48dHxPBrEBgj5
         eST8/21X1ePpGTTUM2mIyXnA2EB0s8xdnZGAY=
Received: by 10.87.66.32 with SMTP id t32mr2444050fgk.75.1256463788476; Sun, 
	25 Oct 2009 02:43:08 -0700 (PDT)
In-Reply-To: <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131197>

On Sun, Oct 25, 2009 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I'm inclined to to discard the first patch.
>>
>> And you decided to mention that after many people including you, hav=
e
>> agreed that it's a good idea?
>
> This line of argument is wrong and counterproductive. =C2=A0Of course=
, after
> reading what others said and thinking about it more myself, I can cha=
nge
> my mind based on their opinions. =C2=A0Otherwise there is no point in=
 having
> any mailing list discussion.
>
> People propose changes, and two things can happen:
>
> =C2=A0(1) I and others may think it is not a good idea, clarifying ar=
gument may
> =C2=A0 =C2=A0 come from the original author and/or additional argumen=
ts defending
> =C2=A0 =C2=A0 the change may come from others. =C2=A0People who thoug=
ht it was not a
> =C2=A0 =C2=A0 good idea may change their mind, and the patch gets acc=
epted. =C2=A0git
> =C2=A0 =C2=A0 becomes better.
>
> =C2=A0 =C2=A0 If people cannot change their mind, it is useless to ma=
ke supporting
> =C2=A0 =C2=A0 arguments to nudge them to reconsider.
>
> =C2=A0(2) I and others may think it is a good idea, a counterargument=
 comes,
> =C2=A0 =C2=A0 and people who originally thought it was a good idea ma=
y change their
> =C2=A0 =C2=A0 mind, and the patch does not go in. =C2=A0git is saved =
from becoming
> =C2=A0 =C2=A0 worse.
>
> =C2=A0 =C2=A0 If people cannot change their mind, it is useless to ma=
ke counter-
> =C2=A0 =C2=A0 arguments to nudge them to reconsider.

Yes, people can change their mind, but if they do so, they must tell
it as it is, and you didn't:
  I think a "Getting started" section that only covers "git config" loo=
ks
  way out of place in the beginning of this document.

If you would have said it properly "I've changed my mind" there's an
obvious question that arises: Why? What made you change your mind. You
didn't say that either.

> Yes, I originally thought a "getting started" section may be a good i=
dea.
> There is no need to point it out to me.

One never knows =3D/

> But after I saw that the original author said "_if_ we have to do thi=
s,
> keep it short", the comment made me question my previous assumption o=
ne
> more time: is it really a good idea to add "getting started", and is =
it a
> good idea to cover the config command in that section?
>
> After re-reading the first thousand lines of the user manual, I reali=
zed
> that the explanation was carefully laid out so that you do not have t=
o be
> taught "git config" in the beginning to be able to follow it. =C2=A0N=
ow, after
> applying your latest patch, if we do not have to teach "config" there=
,
> what else is left in the section? --- Nothing.
>
> What conclusion do you expect me to reach after such a consideration,
> other than "then let's not have it"?

Aha! That's the explanation I was looking for, and what I think you
should have said in the first place. Now we can do some productive
discussion.

I disagree. I think it's awfully useful to have color.ui =3D auto
configured before reading the multitude of 'git branch', 'git show',
and 'git diff' commands that are presented on first two sections. So
useful, in fact, that I think it should be enabled by default.

Supposing that color.ui is 'auto' by default, then yeah, I don't see
the point of such a "git config" section so early in the document, but
it must be explained somewhere.

>> If you read the results of the last git survey you'll see that the
>> area that needs most improvement is the documentation.
>
> Yes, I did read it, but what about it? =C2=A0You already know we both=
 want to
> have a good set of documentation.
>
> Remember that "changing" and "improving" is different; some changes m=
ay
> not necessarily be improvements. =C2=A0"It needs improving, so let's =
change it"
> is not an argument. =C2=A0This isn't obviously limited to the documen=
tation but
> also applies to UI changes.

No, but "improving" needs "changing", and the discussion I see is
biased towards "not changing".

>> Also I still
>> see many people doing commits without configuring the user name and
>> email properly and so I've tried very hard to improve the user manua=
l
>> to make it easier for them to understand they must do that.
>
> The "unconfigured user.name is wrong" is the least of the problems fo=
r
> people who start commiting without understanding the basic principles=
=2E
> People may ask "how do I publish my changes", "how do I discard the
> commit" and "how do I modify the commit two days ago", and teaching t=
hem
> things like "reset HEAD^" and "rebase -i", without making them aware =
of
> the implications will do disservice to them in the long run. =C2=A0Th=
at kind of
> self-teaching is already done by people (and for doing so sometimes t=
hey
> hurt themselves) by diving into man pages of individual commands befo=
re
> understanding the distributedness and its implications, and my hope h=
as
> always been to keep the user-manual a document that teaches things in=
 one
> coherent and hopefully the most useful order.

I don't think the user manual is achieving that purpose. I don't know
if it's the user manual's fault, or git's UI. Both areas need a lot of
improvement (as the git user survey suggests), and I've tried to
improve both with a lot resistance in both. So I'm not very hopeful
anymore.

> The early part of the manual (the first thousand lines) does not talk
> about making commits but lays out the groundwork for a good reason. =C2=
=A0And
> in order to follow the current structure of the manual, you do not ne=
ed to
> be taught "config" as the first thing.
>
> It is a totally different story if we are going to rewrite the manual=
 in
> such a way that we start from "hello world". =C2=A0I am not necessari=
ly saying
> it is a bad way to teach [*1*].
>
> But the current "starting from a sightseer, while learning the basic
> concepts like reachability and stuff, and then learn to build on top =
of
> others' work" structure would also be a valid way to teach, and in th=
at
> presentation order, I do not think teaching "config" sits well at the
> beginning.

IMO the vast majority of git users will use it to just fetch a
repository, and browse through it, and that's because most people are
not developers. Even developers most probably will start that way, and
only start committing after a while.

However, I haven't met any proficient git user that got to that point
by reading the user manual, so I think it must be completely
re-thought. Judging from the luck I've had pushing even the simplest
changes I don't think it will improve much more, unfortunately.

Cheers.

--=20
=46elipe Contreras
