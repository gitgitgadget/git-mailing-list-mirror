From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 17:28:27 +0200
Message-ID: <CAP8UFD1_qDhT5kE+Kk_8BCyPH_dL=zR-X8sdhsQoHE5nW8BUGw@mail.gmail.com>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
	<vpqmvzmwrng.fsf@anie.imag.fr>
	<CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
	<558D68A7.6010608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 17:28:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8VYQ-0006OC-SK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 17:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbFZP2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 11:28:30 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32831 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbFZP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 11:28:28 -0400
Received: by wiwl6 with SMTP id l6so48323928wiw.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F2wrG32YKo0y5Fha2dvqcao/0DKusuCCkbu1qoiJ/B4=;
        b=U2HrTBfWGlKvaQZQSbKPRGoSbPxo3ohVAdr/2ppadLAanuVcYMWeQXhv9ktQspvYXl
         Z9X7qrnsBYjkkVvWp11ZG9N2YKgQNmrzjOMEkn7OxeoITnqreMFHJVwdusFVD4xbEsXI
         2myuYklPdd7UXX5AByz+GHYGlXytTInelBMmBjFKu6B4WXaVXA/Ra1eyF14hGaz9Z9te
         6bK8cElNpXNHX+CiGovVQ00A1cmXrhj24KLQaSZQs7pmHyaEJCpxN+nHq2YftOJs5OXU
         /e0E15kuJqZtIZwXbls9srNfjkNfuMF7pGdrqIK8dZbE2K8QcWVQYTr3SrzaO6TnKxG2
         L3Lg==
X-Received: by 10.194.95.132 with SMTP id dk4mr4231456wjb.88.1435332507755;
 Fri, 26 Jun 2015 08:28:27 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 08:28:27 -0700 (PDT)
In-Reply-To: <558D68A7.6010608@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272782>

On Fri, Jun 26, 2015 at 4:58 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/26/2015 03:15 PM, Christian Couder wrote:
>> On Fri, Jun 26, 2015 at 3:00 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> On Fri, Jun 26, 2015 at 1:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>>
>>>> [...]
>>>>
>>>>> +Eventually there will be no more revisions left to bisect, and the
>>>>> +command will print out a description of the first bad commit, and also
>>>>> +create a reference called `refs/bisect/bad` that points at that
>>>>> +commit.
>>>>
>>>> This could be understood as meaning that `refs/bisect/bad` is created
>>>> only at the end of the bisection.
>>>>
>>>>> -Eventually there will be no more revisions left to bisect, and you
>>>>> -will have been left with the first bad kernel revision in "refs/bisect/bad".
>>>>
>>>> The original looks better to me in this regard.
>>>
>>> I'm changing it to:
>>>
>>> Eventually there will be no more revisions left to bisect, and the
>>> command will print out a description of the first bad commit. The
>>> reference `refs/bisect/bad` created by bisect will point at that
>>> commit.
>
> I agree that is better.
>
>> For the last sentence I'd suggest:
>>
>> The reference called `refs/bisect/bad` will point at that commit.
>
> Or maybe
>
> The reference `refs/bisect/bad` will be left pointing at that commit.

Yeah ok.
