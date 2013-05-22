From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 21:57:18 -0500
Message-ID: <CAMP44s3cvCuOJfm4HhqOiwm=63wGiTMx7LO8Y5F+SAu=E0tN9Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 04:57:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UezF1-0004M3-V5
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 04:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab3EVC5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 22:57:22 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39457 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab3EVC5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 22:57:20 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so1514564lbh.41
        for <git@vger.kernel.org>; Tue, 21 May 2013 19:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3Chvbd/Pkb+Xtiq+BGUuXY9ywddAEHQ3B88ZzHTruHM=;
        b=LQ419P7HpDoKwo6c0NcscOtqWjl40l/eFNL5yKLTOaV08ht+nCZbiAG96uAhMmhQJc
         B2Nqrj02dPPqSOnRRY8VRqQnQX+mYEiDQxOGFs4lxGeLkWLMFI83lwFtwBvi8t8Txxhc
         kVzMbDkEuOk2Qyz1zfqaCT7hdAXtHXtRz9yJJjWJIoa0MUdH8ssLD5OI1NOvlhe2MDO3
         MLFmFwS4oUMsgsg3vR0SEQTR47P33b0vhbRzLWM5XCvJA2B4c1926zc3ZH7Km9y55ZFS
         Sug8QQk69gXux9vYCBg4UGJdklfCYr1Kmd3Swoo2jY3YyGFQmrt5NmgC+cJ/8dpgVftO
         yMLg==
X-Received: by 10.112.164.105 with SMTP id yp9mr384718lbb.103.1369191438842;
 Tue, 21 May 2013 19:57:18 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 19:57:18 -0700 (PDT)
In-Reply-To: <7vehczltwu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225122>

On Tue, May 21, 2013 at 7:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 21, 2013 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> I still haven't received a response: which makes more sense?
>>>>
>>>> a)
>>>>
>>>>       % git checkout svn-ext
>>>>       % git fetch
>>>>       From .
>>>>        * branch            master     -> FETCH_HEAD
>>>>       # oops
>>>>       % git fetch git-svn
>>>>       % git log ..FETCH_HEAD
>>>>       % git merge FETCH_HEAD
>>>>
>>>> b)
>>>>
>>>>       % git checkout svn-ext
>>>>       % git fetch
>>>>       From git://git.kernel.org/pub/scm/git/git
>>>>          680ed3e..de3a5c6  master     -> origin/master
>>>>       # oops
>>>>       % git fetch svn-ext
>>>>       % git log ..FETCH_HEAD
>>>>       % git merge FETCH_HEAD
>>>
>>> I think with the scenario you are following, a) would prepare the
>>> FETCH_HEAD with her local git-svn branch which is her svn-ext topic
>>> is based on, but you illustrated it to fetch 'master', which I think
>>> is a minor typo.
>>>
>>> Modulo that typo, the step before the #oops makes perfect sense.  It
>>> fetched where she told Git her work on svn-ext is based on.
>>>
>>> But the step after that does not make much sense in that flow.
>>
>> You don't get to decide what Sally (I'm naming her) does, all you get
>> to decide is what Git does.
>>
>> Sally wants to fetch from the true upstream: svn-ext, but in the
>> process does by mistake a 'git fetch' *without arguments* (WHICH IS
>> WHAT THIS WHOLE DISCUSSION IS ABOUT). So now is the time you answer:
>> a) or b).
>
> Heh, that was my example.
>
> In any case, my pick is still a).  She *TOLD* Git that her local
> git-svn branch is what forms the base of her local svn-ext work.

She told Git that her local svn-branch was the basis for svn-next. She
DIT NOT TELL Git to fetch from there. She told Git to fetch from any
location Git thought best to fetch from, either a) or b) would fetch
from the wrong location, but a) would be wronger, you just don't want
to admit it.

You are, once again, *assuming* that if a user sets up an upstream, he
wants to fetch from there. All you answers are based on assumptions.

-- 
Felipe Contreras
