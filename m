From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 15:15:29 +0200
Message-ID: <CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
	<vpqmvzmwrng.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8TTn-0006bm-7f
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 15:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbFZNPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 09:15:32 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34263 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbFZNPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 09:15:30 -0400
Received: by wicnd19 with SMTP id nd19so45093935wic.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=boCR0Ntyas64HYGlw5g6kkemvriHNi4jJTvIxKh1YJ8=;
        b=QLoA8PXrGYwH/D3GpHm2MsqASK+lLxw/Vy2NR+m1cyTAzHDW/bAXLGRLRR/SmVSGIW
         YqgE6hGvPDwpLy1Vg45vjoQdTdUZHwXxRu0C2GPd2pqr6Xsco/gVhOhU+SjAfzYbgdpy
         E5a9i7l3o3FtlTvC0Kcdz/VC4qOu/S7ghUifRDGXqkKFZCcPLAapfFQHQnY8k4DR2vWD
         0MFMG22KSKEcRaGoOTXwT7BrdR68Ckyj/k/LfOccuvrcXmZRxool14bjtT1Iy+2AKPux
         T+v57dKDJHoXAanFghnaPo1r7YMiSyTpvTAhZINKQznGN/mr+BtncKLtZcmuxjAO2g/w
         HFsw==
X-Received: by 10.194.95.132 with SMTP id dk4mr3175154wjb.88.1435324529100;
 Fri, 26 Jun 2015 06:15:29 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 06:15:29 -0700 (PDT)
In-Reply-To: <vpqmvzmwrng.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272779>

On Fri, Jun 26, 2015 at 3:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Fri, Jun 26, 2015 at 1:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>> [...]
>>
>>> +Eventually there will be no more revisions left to bisect, and the
>>> +command will print out a description of the first bad commit, and also
>>> +create a reference called `refs/bisect/bad` that points at that
>>> +commit.
>>
>> This could be understood as meaning that `refs/bisect/bad` is created
>> only at the end of the bisection.
>>
>>> -Eventually there will be no more revisions left to bisect, and you
>>> -will have been left with the first bad kernel revision in "refs/bisect/bad".
>>
>> The original looks better to me in this regard.
>
> I'm changing it to:
>
> Eventually there will be no more revisions left to bisect, and the
> command will print out a description of the first bad commit. The
> reference `refs/bisect/bad` created by bisect will point at that
> commit.

For the last sentence I'd suggest:

The reference called `refs/bisect/bad` will point at that commit.
