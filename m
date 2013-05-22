From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Wed, 22 May 2013 17:12:12 -0500
Message-ID: <CAMP44s3jJRt8Jd6_oMwGBEj31ddQvHJukfYr8ySrk_zBaTjCPA@mail.gmail.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
	<7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
	<CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
	<7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
	<CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
	<7vr4gzlxvx.fsf@alter.siamese.dyndns.org>
	<CAMP44s2hH63rM++bG-aGeEyaL3tvF8yZYmcO7K1J66KVxyOutQ@mail.gmail.com>
	<7vehczltwu.fsf@alter.siamese.dyndns.org>
	<CAMP44s3cvCuOJfm4HhqOiwm=63wGiTMx7LO8Y5F+SAu=E0tN9Q@mail.gmail.com>
	<7vtxlvj6vq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHHC-00045K-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab3EVWMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:12:16 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:44556 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297Ab3EVWMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:12:14 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so2547998lab.16
        for <git@vger.kernel.org>; Wed, 22 May 2013 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=20K6nKczSyZ5FTjj/jfFhGxdj5PQTb1qs/Krmcp19Yg=;
        b=wETq4k6S06fYae6/+X4V3gRsh/nbT2yM47xTwIe/DoANG+IDDE9g7l47DnlaYMUADI
         o1HSwyu8g6VkbHeeJviygOtjNdt06QR/+FFrpKsZFABndpXNnJyyy3FK1pI2y4EnclfM
         J1l6PvnTmL+BlEEOTix2mvCbNh4pHmE/Z+Ua62JcnDufzp+yJlnukclwQmEwP8VGmwQ6
         YqtrvtCtRLiGNe97csuUIuZvClbXA4giZqIYFDKuujtY6gc7KsSynPVIIO1AWczTU1my
         36R3+eC/AINIOGmxzctsWncIIWsAUaV+XvZDGyYfluS/2t0K0ZcMi61z9DAugw6gRcY4
         TRrg==
X-Received: by 10.112.63.169 with SMTP id h9mr4988890lbs.135.1369260732367;
 Wed, 22 May 2013 15:12:12 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 15:12:12 -0700 (PDT)
In-Reply-To: <7vtxlvj6vq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225196>

On Wed, May 22, 2013 at 11:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> She told Git that her local svn-branch was the basis for svn-next. She
>> DIT NOT TELL Git to fetch from there. She told Git to fetch from any
>> location Git thought best to fetch from, either a) or b) would fetch
>> from the wrong location, but a) would be wronger, you just don't want
>> to admit it.
>
> "(a) is more wrong" is just your opinion, and you are simply wrong.

My opinion based on very solid grounds; the whole purpose of 'git
fetch; is to FETCH from a REMOTE. a) is not doing that at all.

In addition, the vast majority of users don't have a clue as to what  the hell

>From .
        * branch            master     -> FETCH_HEAD

means.

a) is wronger. Period.

You say it's not, but give no explanation at all. This is no way to argue.

> She is working on svn-ext based on her local git-svn the latter of
> which has some changes of her own on top of Eric's tree.
>
> When working on _any_ branch that bases its work on something else,
> you have @{u} available, but that @{u} will not stay up-to-date if
> you forked from work that is done outside your repository.  That is
> what an unqualified "git fetch" is designed to help when run on a
> branch that bases its work on something else.

The fact that it's designed that way doesn't mean it's a good design,
and it doesn't mean the user expects that.

> If you happen to know
> that yoru current branch is forked from git-svn that is a local
> branch,

That's a very big *IF*.

> then running "git fetch" becomes unnecessary for the purpose
> of updating @{u} (it already and always is up to date), so doing no
> object transfer and no ref update is absolutely the right thing to
> do.  That is what "remote = ." gives you.

Jumping to conclusions based on assumptions again.

Sally doesn't know what the designers intended, Sally doesn't remember
what is the upstream of the current branch, of it has any upstream at
all. Sally does 'git fetch' instinctively, and expects Git to do the
right thing, but it doesn't, it does an utterly irrelevant and useless
action; non-fetching from a local-remote.

> In addition, that does not break the "pull = fetch + merge"
> equivalence you seem to be ignoring.

Do you want me to count to you the many times I've proved to you that
pull is NOT fetch + merge?

YOU are the one ignoring the fact that it's not: it's only that way in
very specific circumstances, certaily ver far from being a universal
truth.

> If she wants to check what Eric has been doing, she can do "git
> fetch git-svn", giving the remote name she calls Eric's tree with.
> At that point, she is not saying "I want to check what is happening
> to the upstream of my _current_ branch" (and the fetched result is
> not something she can immediately use while on her current branch).

Irrelevant.

> On the other hand, an unqualified "git fetch" that slurps from my
> tree, which is your (b), is just plain wrong.

But that's *EXACTLY* what we do when there's no upstream branch, is it not?

> My tree is not even
> related to what she is working on.

Unless you are prepared to say fetching from any other tree that @{u}
is wrong, and 'git fetch' should forbit it, this is irrelevant.

The user can fetch from wherever they want.

> Of course, when she is interested in what have been happening in my
> tree, she can say "git fetch origin".

Irrelevant. We are not changing that behavior.

-- 
Felipe Contreras
