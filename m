From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git notes: notes
Date: Thu, 21 Jan 2010 09:45:04 +0100
Message-ID: <4B581410.9080506@drmicha.warpmail.net>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001201148.11701.johan@herland.net> <20100120182438.GB31507@gnu.kitenet.net> <7vhbqg376b.fsf@alter.siamese.dyndns.org> <20100120195626.GA6641@gnu.kitenet.net> <7vska01qrt.fsf@alter.siamese.dyndns.org> <4B576F5C.2050102@drmicha.warpmail.net> <7veilk1o3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 09:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXshK-0000Be-8m
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 09:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0AUIrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 03:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430Ab0AUIrG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 03:47:06 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58213 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab0AUIq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 03:46:59 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 22BA5CDAFB;
	Thu, 21 Jan 2010 03:46:59 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 21 Jan 2010 03:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=E/5OMsJeFAAbhrCwAP4+6MYHDto=; b=UOBXn/bSA+kNCMJ71AIB6zzgFOG+UjA4EyBOzu7SzmyOc0buU17lRKk4W5fxSKg+lo7u/ulJnLWtZ6XpALsnQ5FDAL4uIhr9SoizCrJfoFGX3uzBOZAdmiXTJk8/gPjmE/jfRRHDW1T0McymXSX9PP2ueCZwFbarJuGNfKRXVrA=
X-Sasl-enc: y2Xr59NhxNAKtKJYmBJLuyxdZ6leOo8m+/t8kf8EnOT5 1264063618
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE718405A4;
	Thu, 21 Jan 2010 03:46:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <7veilk1o3s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137642>

[Adding cc from elsewhere in this thread, for fairness.]
Junio C Hamano venit, vidit, dixit 20.01.2010 22:08:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 20.01.2010 21:10:
>>> Joey Hess <joey@kitenet.net> writes:
>>>
>>>> Do you think it makes sense for even git log --format=format:%s to be
>>>> porcelain and potentially change when new features are used?
>>>
>>> If the series changed the meaning of "%s" format to mean "the subject of
>>> the commit and notes information", with or without documenting it, then it
>>> is just a bug we would like to fix.
>>
>> No, but outputting the note as part of the log is the standard. So for
>> example, when you do a format-patch | apply cycle, format-patch will
>> insert the note as part of the commit message, and apply will *store*
>> the note text (including Note:\n) as part of the commit message of the
>> new commit.
> 
> Thanks; that was the kind of breakage report I was looking for (and wished
> to have heard a lot earlier).  Personally I find it is unexcusable that
> format-patch defaults to giving notes.
> 
>> So, I would say the notes feature is not that well integrated right now,
> 
> No question about it.
> 
>> I'm not complaining, I actually have this on a maybe-to-do list, but the
>> way the series went kept me from investing time.
> 
> Hmm, that hints there is a failure in the review and merge process.  Care
> to explain how we could have done better please?

Well, I can only recall why it kept *me* from investing more time. I
actually have very little free time available, I contribute to Git
because it's fun, or I want a certain feature, or, admittedly, having a
commit in a project like Git gives me a certain satisfaction.

The notes feature looked very promising to me, and when Dscho came up
with it (or followed up on someone else's proposal, I don't remember) I
invested time in testing and contributing (minor) fixes. Then the series
took on a life on it's own, first "disappearing" (when I was wondering
if anything is going forward), then reappearing with (not only my)
commits squashed in (which took away the satisfaction part), then going
through a lengthy technical discussion on fan-out schemes (which was
necessary, but took away the fun part). [The last two parts may have
been the other way round, which doesn't matter.]

When the first part of the series landed I began to look at it again and
use it for the comments which go after the "--" part of a patch, only to
find out that format-patch issue. I noticed the bad consequence on
format-patch|apply only later. So I looked at the code, the log flags,
and was about to code when the notes API changed again (on pu). So I
decided to wait until the API is baked (that decision may have been
influenced by my expectation that my patches would get squashed in
again) and to fix that issue before 1.7.0.

Note that I have to match the project's necessities with time
availability on my side - otherwise I would have written that patch when
more of that series had landed. Now I reported it because it came up in
some disguise (and didn't want anyone spend time needlessly fixing a
side issue), and I'm not the one fixing it, but that's fine.

Besides the sociological aspect, I think you mentioned the main
technical aspects:

* If you introduce a new features, write extensive tests covering
non-uses and mixed uses of the feature.

* Write redundancy tests, such as checking that format-patch|apply and
apply|format-patch both amount to the "identity" in the appropriate sense.

Right now we do very atomic testing, which does have its merits (for
determining the cause of a breakage). But since many features and
commands are not orthogonal, atomic testing does not test for side
effects, and test repos are minimal. Trying to test for specific
combinations makes you miss some combinations, especially combinations
with future features. But testing for those identity operations
(quasi-noops, or cycles) should ensure some consistency.

Maybe we should have a test repo which has all kinds of features turned
on and used, and on which a set of those identities are tested. With
every new feature, the repo as well as the set of supposed identities
would need to be amended (maybe by cloning the repo, adding commits, and
testing on an increasing set of repos). That would have caught at least
the current issue immediately.

Cheers,
Michael
