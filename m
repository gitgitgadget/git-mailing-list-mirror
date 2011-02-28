From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 11:53:05 +0100
Message-ID: <4D6B7E91.4050308@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>	<4D68D630.9000608@drmicha.warpmail.net>	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>	<4D6B5D09.8010806@drmicha.warpmail.net>	<vpqwrkkpkea.fsf@bauges.imag.fr>	<4D6B6F97.8030409@drmicha.warpmail.net> <vpqr5aslbje.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 28 11:56:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu0mJ-0008Gc-7X
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab1B1K43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 05:56:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59690 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740Ab1B1K43 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 05:56:29 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0D934203E2;
	Mon, 28 Feb 2011 05:56:28 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Feb 2011 05:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YOt29GvOuBXf/7OBAK03D2MYA9U=; b=o3KZgu/I5Q1XHL4pNOuuPk5IIrYwM6HLi9GwfNa62Vu6fzJoxCpXsDn/FCzGVBcNgPh6p7I6Qhrj7B12IYOtmL2gx6flTPTUmzikCy+dsfMobHNQC4kPCVraltjPUk6g7j2H8am7K4Srr4dE2gTo7IyUhtgWklWhgDIog/4DbAg=
X-Sasl-enc: aggDV3Gv91DIQy822iDtvloL/esiXwNLX9VTpsioDn+D 1298890587
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1603B406BB6;
	Mon, 28 Feb 2011 05:56:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <vpqr5aslbje.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168099>

Matthieu Moy venit, vidit, dixit 28.02.2011 11:05:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Matthieu Moy venit, vidit, dixit 28.02.2011 10:40:
>> 
>>> # let's see what happens ... $ git add $ # ok, nothing happened
>>> ... # continue hacking without noticing that a bunch of files
>>> have been added.
>> 
>> No no, I said "add" would default to what "-u" does now (see
>> below).
> 
> Right, that less disturbing than I wrote (but still potentially 
> disturbing)
> 
>>> Mercurial has taken the other way, making "hg add" add everything
>>> by default, and some users do complain:
>>> 
>>> http://osdir.com/ml/version-control.mercurial.general/2007-08/msg00316.html
>>
>>
>>> Since when do we care about them (as in "hg", not in "users", mind
>> you...).
> 
> If you don't care about experiences of others, I can do nothing for
> you. I don't have a crystal ball, so I can't say what Git users will
> say about a given feature, but I can look around me (I'm sure you can
> too) and see how it went for other people.
> 

Between hg and git, add and commit are very different. Haven't we all
seen these super smart comparisons saying

hg add is much faster than git add, but git commit is much faster than
hg commit?

They do completely different things. When used after each other, they do
"A+B+C", but "hg add" does "A", "hg commit" "B+C", whereas "git add"
does "A+B", "git commit" does "C" (with pathspecs for add, no options).

Because of that, and also because I haven't thought
about/suggested/proposed what "hg add" seems to do by default now, I
dismiss that experience as unrelated. "hg add" is partially related to
"git add" only, and their default is completely different from what I've
mentioned.

(I think you know hg and git well enough to know this difference, and
also know from the list that I do care [even in your quote], or I would
have explained that in the first place).

>>> If you change this for Git, you'll have people complaining about 
>>> backward compatibility plus people complaining about least
>>> surprise :-(
>>> 
>>>> - "add" should be about tracked paths by default (default
>>>> pathspec "."),
>> 
>> See, here!
>> 
>>>> 
>>>> - "commit -a,--add <addopts>" be "add <addopts> && commit",
>>>> and
>>>> 
>>>> - "-A,--all pathspec" (default pathspec ".") be about tracked
>>>> and untracked paths (whether add or commit).
>>> 
>>> Today, "git add ." adds new content in tracked files, and new
>>> files, but doesn't notice files deletions. Did I miss something,
>>> or is there no way to do that with your proposal?
>> 
>> What in
>> 
>>> That would need a proper migration plan etc., and some thinking
>>> about -i/-o. Just brain-storming.
>> 
>> reads "proposal" to you?
> 
> What's wrong with you today? Miles asks a honnest question and gets
> a dissertation about the netiquette,

A question answered in the post he replied to (but failed to quote).
Given my previous encounters the other day, an explanation of our
netiquette seemed in order (other lists trim much more then we do), and
non the less I did so politely, and I even appreciated his leaving cc in
place (which other lists do differently, and proves his openness to adapt).

> I ask another question, mention
> the experience of other people and get this.

Jeff, then Junio and I have been discussing ways forward to improve the
user experience with respect to related options of "add" and "commit"
(which are similar and named differently, or dissimilar and named the
same), and everyone is welcome to join (of course; just to be clear),
there is no consensus yet. Every voice counts.

> I did read "brainstorming" in your email, tried to brainstorm with
> you, but you're not making it easy to us. I'm stopping here, sorry
> for disturbing.

What is not OK is trimming down my posts to the amount that they make no
sense any more, or a completely different sense, and then commenting on
that skewed quote, forcing me to reexplain what I had explained already.
This makes us go in circles, rather than forward. It's a waste of resources.

You may have been unlucky in being number "n+1" to do so to me on-list
today, and maybe in "proposal" being more formal in English than in
French, alleviated by the fact that you cut out my sentence

"I know I'm getting a bit radical here, but the more I think about it, I
feel that"

introducing the list of items which you did quote (no to mention the
whole reasoning building up to that). So, not just poor luck, you see;)

Writing that long post (with a large unradical part, and a short radical
brain-storming) I was afraid already it would make people read partially
only. I hope we'll turn that into a more constructive direction again.

Michael
