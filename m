From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Thu, 12 Nov 2009 12:29:18 +0100
Message-ID: <4AFBF18E.7070906@drmicha.warpmail.net>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>	 <7vy6n065os.fsf@alter.siamese.dyndns.org>	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>	 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>	 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>	 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>	 <20091025111438.GA11252@progeny.tock> <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 12:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Xry-0006g5-Md
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 12:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZKLL3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 06:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZKLL3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 06:29:25 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:45593 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752163AbZKLL3W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 06:29:22 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D2461BD321;
	Thu, 12 Nov 2009 06:29:27 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 12 Nov 2009 06:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=c17yY2fCLfDdCGAa4fyVC1MUBZU=; b=hUDD14a2mXuM/vDCHjmLL977f8iCbg3ObBeeDJUbD30NWmiL+oIYEn4cQd85WuCZrjYgzeytnIn0BiGM4ZDp7DZz4xThMyndeAG8wQysqNWZWqN0QYvDAxED4uFZf7eOS06levbhwbR2wpspuzItQW1REe0deqcypwomqtpY6Mc=
X-Sasl-enc: idX+OrHtVozWCIC6P65OUDGsfF/3NoJK3TRMjHNCF8m5 1258025367
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 266A01EAD2;
	Thu, 12 Nov 2009 06:29:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091112 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132765>

=46elipe Contreras venit, vidit, dixit 12.11.2009 00:15:
> On Sun, Oct 25, 2009 at 1:14 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Felipe Contreras wrote:
>>> Supposing that color.ui is 'auto' by default,
>>
>> Should it be?  I think it would not be too hard to detect a color
>> terminal by checking $TERM.  Are many people bothered by color?  Do =
we
>> need some way to make it more obvious how to turn color _off_?
>=20
> I think it should be.

Back then (before my involvement with git) the result of the discussion
was something like: "Since some of us are way more opposed to the use o=
f
colors than others are in favor..." This does not sound overly democrat=
ic.

=46eel free to bring this issue on for a change in Git 1.7.0. It would =
be
good to research any possible incompatibilities this would imply (other
than the looks of the output),

>>> No, but "improving" needs "changing", and the discussion I see is
>>> biased towards "not changing".
>> [...]
>>> I don't think the user manual is achieving that purpose. I don't kn=
ow
>>> if it's the user manual's fault, or git's UI. Both areas need a lot=
 of
>>> improvement (as the git user survey suggests), and I've tried to
>>> improve both with a lot resistance in both. So I'm not very hopeful
>>> anymore.
>>
>> I hope you have not misunderstood.  I cannot speak for everyone else
>> here, but I know I am happier when (1) fixes match problems to be
>> solved in a documented way and (2) fixes do not unnecessarily break
>> unrelated habits.  One way to bring this about is to justify each
>> change by explaining what real problem it will solve and how it avoi=
ds
>> collateral damage.  Without that justification, a change is indeed
>> dangerous and might be worth resisting until it gets clarified.  But
>> this is not meant to prevent fixes from occuring at all.
>=20
> Well. I've sent many patches, and gone through several iterations.
> After fixing all outstanding issues, addressing all the comments, and
> getting several "I like this" votes, Junio suddenly decides he doesn'=
t
> like the initial changes at all and doesn't provide any way forward.
>=20
> I don't see how that's an environment that fosters changes.

The process can be frustrating at times. Many patches go through many
rounds. I've had occasions where I got frustrated and gave up, as well
as those where I learned a lot and the actual result was much better
than it would have been without thorough discussions. It's this process
which tries to ensure that the project is moving forward most of the
time, rather than sporadically back and forth; moving forward maybe a
bit slower, but still at an impressive overall rate.

Regarding this specific patch series: I took part in the initial
discussion, and got frustrated by the original poster's seemingly
unwillingness to accept advice, so I left. I'm not drawing any general
conclusions, and please don't take this as an ad hominem argument.
Sometimes it's simply a matter of mismatching participants.

It's just my impression that many people retreat from a discussion
because they feel it's getting unproductive (from their particular poin=
t
of view), maybe hoping the thread will die out sooner or later. Once it
looks as if something they object to could be included they come back
with counter arguments. This makes the discussion seemingly go back and
forth, but is a natural sociological effect.

>> Could you list some UI patches that were overlooked or not properly
>> addressed?  Maybe people just forgot about them or were waiting for =
an
>> updated version, or maybe the problems some solve weren=E2=80=99t ar=
ticulated
>> clearly yet.  I would be glad to help out in any way I can.
>=20
> For example there have been many attempts to bring the 'git stage' to
> foreground of the UI; right now it's kind of hidden and many people
> don't even realize it's there. Even simplistic attempts as
> standardizing --index, --cache and so on into --stage have failed
> miserably.
>=20
> Again, there doesn't seem to be a path forward. Perhaps the git's
> stage will remain an obscure feature of git forever. (all the input
> from git user's survey points out that people are not really using it=
)

I didn't read that out of the survey. On the other hand, the last surve=
y
pretty impressively showed where it had been publicized most
prominently. One should keep that in mind when interpreting the results=
=2E

If you care to go back to that discussion you see that there is good
reason for having both --cached and --index. They are different. "git
help cli" explains this nicely.

"To stage" has been introduced to describe what "git add" does to peopl=
e
who hard wire "add" to the meaning it has in other VCSes. In fact, this
would be unnecessary if the concept of Git as a *content* tracker could
be transmitted more successfully. Git cares about content only, so what
could "git add" possibly mean?

"git stage" is a failed follow up ui experiment.

In this regard, I think the problem is that there are really two kinds
of people in terms of learning style:

- Some prefer recipes, similarities with previously known recipes. "How
do I...?" And then try do understand "How does (G)it...?" from that.

- Some want to understand concepts first: "How does (G)it...?" And then
figure out how to use (G)it to do what they want.

I'd guess most developers and a large fraction of the "technical crowd"
belong in the second camp.

I still think we should both

- try and teach concepts early, emphasize that Git is different
(content, index, branch - that's it)
- make Git behave in "expected ways", making it easy for the (willing)
beginner) without compromising its usefulness as a power tool.

I better stop before I digress even more from the original topic :)

Michael
