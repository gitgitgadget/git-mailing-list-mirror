From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 16:58:47 +0200
Message-ID: <558D68A7.6010608@alum.mit.edu>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>	<vpqmvzmwrng.fsf@anie.imag.fr> <CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 16:59:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8V5v-0004ae-KY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 16:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbbFZO7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 10:59:04 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55394 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752706AbbFZO7B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 10:59:01 -0400
X-AuditID: 12074414-f794f6d000007852-e6-558d68a9dce6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F3.83.30802.9A86D855; Fri, 26 Jun 2015 10:58:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9793D.dip0.t-ipconnect.de [79.201.121.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5QEwlsp002142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 26 Jun 2015 10:58:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqLsyozfUYP51c4uZM60tNj2fyGxx
	e2YLs0XXlW4mi4beK8wWC94fZbO49Hk9q8WyvilMFleevmZ34PS42hzgsXPWXXaPiV+Os3pc
	vKTssfzBK3aPz5vkAtiiuG2SEkvKgjPT8/TtErgzPl37yFowgbvi34UHLA2MPzi6GDk5JARM
	JC5Pvc8CYYtJXLi3ng3EFhK4zCjxeHIghH2eSWL7dVEQm1dAW2LCigfMIDaLgKrEoqVr2EFs
	NgFdiUU9zUxdjBwcogJBEq9f5kKUC0qcnPkEbLyIQLrEhMvrgUq4OJgF/jFJHHmyF2yOMNDM
	vu7LbCAJIYFmJol9X1aAdXAKBEo03VgLVsQsoC7xZ94lKFteYvvbOcwTGAVmIVkyC0nZLCRl
	CxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKERITIDsYjJ+UOMQpwMCrx
	8Do094QKsSaWFVfmHmKU5GBSEuXNTOkNFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCyxcNlONN
	SaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuBdnA7UKFiUmp5akZaZU4KQ
	ZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9nqBtPMWFyTmAkUhWk8xKkqJ8x4FSQiA
	JDJK8+DGwtLcK0ZxoC+FeVeCVPEAUyRc9yugwUxAg9/Gd4EMLklESEk1MJbwW/y/8e5UcOoy
	A3mXSzmnn0hdFHxdI6xvsHer6Iy4q0oVhycFzldfqV6suWbyNr01jo0ZP+e0q7Fu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272781>

On 06/26/2015 03:15 PM, Christian Couder wrote:
> On Fri, Jun 26, 2015 at 3:00 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> On Fri, Jun 26, 2015 at 1:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>
>>> [...]
>>>
>>>> +Eventually there will be no more revisions left to bisect, and the
>>>> +command will print out a description of the first bad commit, and also
>>>> +create a reference called `refs/bisect/bad` that points at that
>>>> +commit.
>>>
>>> This could be understood as meaning that `refs/bisect/bad` is created
>>> only at the end of the bisection.
>>>
>>>> -Eventually there will be no more revisions left to bisect, and you
>>>> -will have been left with the first bad kernel revision in "refs/bisect/bad".
>>>
>>> The original looks better to me in this regard.
>>
>> I'm changing it to:
>>
>> Eventually there will be no more revisions left to bisect, and the
>> command will print out a description of the first bad commit. The
>> reference `refs/bisect/bad` created by bisect will point at that
>> commit.

I agree that is better.

> For the last sentence I'd suggest:
> 
> The reference called `refs/bisect/bad` will point at that commit.

Or maybe

The reference `refs/bisect/bad` will be left pointing at that commit.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
