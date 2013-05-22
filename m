From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 19:27:12 -0500
Message-ID: <CAMP44s2hH63rM++bG-aGeEyaL3tvF8yZYmcO7K1J66KVxyOutQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 02:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uewtj-0008HA-2V
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3EVA1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 20:27:14 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:45525 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3EVA1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 20:27:13 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so1446482lbi.25
        for <git@vger.kernel.org>; Tue, 21 May 2013 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NgSxj7JtLwhh1nOvKVr3eQ+1t2klMk+2g4KGUqhTKiM=;
        b=edi3uXTA11xQsZ1yNapUDYjsHLsCMsCE9eIc4ynCyUdKAm4S/6caJPPSyeJ2CVCz/H
         l3jClP3yEOx/Bc1n6UcUvUS6kXXE1vlO56L76uQZyaVEe5COuLKMxL39swi4c2yweGxv
         LtbWZRFO1JJ+thysLTe50Ml3cFxLclL664TYuBym3lu1zHYusZZ8il9ybNPsluhxqzyS
         rBjvzrdow4jk7wFv//FcTCZKrw25oAJR6Mj7T5a3Hftm+rrFFaqmy+3iNR/X6yplWQ4z
         Dv6mwmhiP5JZ47KNCrgIIqfj6ngBr5WHzkJB4MNM3XNoHPUxnYfBSjlDBBA2MhftOVLf
         sHgA==
X-Received: by 10.112.63.169 with SMTP id h9mr2773163lbs.135.1369182432150;
 Tue, 21 May 2013 17:27:12 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 17:27:12 -0700 (PDT)
In-Reply-To: <7vr4gzlxvx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225099>

On Tue, May 21, 2013 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I still haven't received a response: which makes more sense?
>>
>> a)
>>
>>       % git checkout svn-ext
>>       % git fetch
>>       From .
>>        * branch            master     -> FETCH_HEAD
>>       # oops
>>       % git fetch git-svn
>>       % git log ..FETCH_HEAD
>>       % git merge FETCH_HEAD
>>
>> b)
>>
>>       % git checkout svn-ext
>>       % git fetch
>>       From git://git.kernel.org/pub/scm/git/git
>>          680ed3e..de3a5c6  master     -> origin/master
>>       # oops
>>       % git fetch svn-ext
>>       % git log ..FETCH_HEAD
>>       % git merge FETCH_HEAD
>
> I think with the scenario you are following, a) would prepare the
> FETCH_HEAD with her local git-svn branch which is her svn-ext topic
> is based on, but you illustrated it to fetch 'master', which I think
> is a minor typo.
>
> Modulo that typo, the step before the #oops makes perfect sense.  It
> fetched where she told Git her work on svn-ext is based on.
>
> But the step after that does not make much sense in that flow.

You don't get to decide what Sally (I'm naming her) does, all you get
to decide is what Git does.

Sally wants to fetch from the true upstream: svn-ext, but in the
process does by mistake a 'git fetch' *without arguments* (WHICH IS
WHAT THIS WHOLE DISCUSSION IS ABOUT). So now is the time you answer:
a) or b).

You whole argument resides on this question, because you assumed the
answer is a), but that's an *assumption*, answer the question and
you'll see why. But your solution to a question that would undermine
your argument is to just ditch it. Great.

> So, the short answer is neither, but a) can be fixed (not in code
> but in the typescript) to make more sense, perhaps like this:

Do not avoid the question.

>     % git checkout svn-ext
>     % git fetch
>     % git log ..FETCH_HEAD
>     % git rebase FETCH_HEAD
>     # The last three can be "git pull --rebase".

If she does 'git pull --rebase', then the whole thing is irrelevant
for the disunion about GIT FETCH WITHOUT ARGUMENTS.

She didn't want to fetch '.', nobody does; she wanted to fetch a real
remote repository.

>     # ok, did Eric do something in the meantime?
>     % git checkout git-svn
>     % git fetch
>     From git://git.bogomips.org/git-svn.git/
>      * branch  master -> git-svn/master
>     % git rebase FETCH_HEAD

This 'git fetch' is irrelevant, because it's not fetching from '.'.

>     # now let's rebuild the svn-ext on top
>     % git checkout svn-ext
>     % git pull --rebase

No fetch without arguments here either.

All these commands are red herrings.

Is it a) or b) or are you just going to never allow your argument to
be challenged? That's a great way to "win" arguments, but a bad one to
arrive to good solutions.

-- 
Felipe Contreras
