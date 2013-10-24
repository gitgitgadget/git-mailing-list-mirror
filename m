From: David Aguilar <davvid@gmail.com>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 19:15:25 -0700
Message-ID: <CAJDDKr7BkZjhjPF==v6PWVA4_-HM2cOaj+xusgkLKf7OocEpaw@mail.gmail.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
	<xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
	<87zjpzg592.fsf@mcs.anl.gov>
	<xmqqk3h3pywt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jed Brown <jed@59a2.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 04:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZASd-0004Yn-IS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 04:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3JXCP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 22:15:26 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59457 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3JXCP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 22:15:26 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so2195251pad.7
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 19:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1zjGr5RkphnzmGrohMIRxG9RqL5Ep6ijTv82gO1ynrM=;
        b=xqyLDaSjMalI8eNj9S/R8Eax7QDzXroSHXdlyrQouejYrE4VEp7ktKl059hC5aySWC
         mZRMxNFM00M+cxPkdM5p5DOLiDSbQOF/cPQ/+f0px5+jHtebrsmtUdwVW09PCEG2cJo4
         IYt97Wtnpqo+7WJMMVlyiIVVJH4yQ7UvSpGiHgNRMkTbCrCHO0eWek7QrqUER+uy4M2R
         MDygq8tZYl3dsUQpYwaB799PcOMUgHC19svtzpLaacqPSeO0eXCsGpOlfrnapxSfh4f5
         oAmDd65lMRMMVKo/AaD8+eri19zKio/m2hZyZyQGOtrzk/cf6skx7Jpr3jgnYX7hNsq+
         lEfg==
X-Received: by 10.68.129.99 with SMTP id nv3mr456776pbb.40.1382580925517; Wed,
 23 Oct 2013 19:15:25 -0700 (PDT)
Received: by 10.70.125.197 with HTTP; Wed, 23 Oct 2013 19:15:25 -0700 (PDT)
In-Reply-To: <xmqqk3h3pywt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236562>

On Wed, Oct 23, 2013 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jed Brown <jed@59A2.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jed Brown <jed@59A2.org> writes:
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>> I suspect that it would be too late for 2.0 we want to do sometime
>>>>> early next year, though.
>>>>
>>>> How would you manage transition from the current behavior?  Warning
>>>> people to explicitly use "." or ":/" during some interim period sounds
>>>> worse than just switching the default behavior.
>>>
>>> "How would I"?
>>>
>>> You're asking that question only because you omitted too much from
>>> the quote ;-)
>>
>> I meant that if the proposed migration plan were to be "just change it
>> and people will learn" (because anything more gradual would actually be
>> worse for users) then is it really too late for Git-2.0?
>
> I do not know it that is even a workable plan, but I need to sleep
> on it and then hear opinion from others, but in general, if anybody
> needs to ask if it is too late, then it already is.

Making grep tree-wide would be very welcome here.

IMO Git-2.0 *feels* like a good time to change the default since
there's relatively little downside to doing so, but "early next year"
is not very long to wait either; it doesn't seem like there's a strong
reason to rush this in.
-- 
David
