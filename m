From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v2 000/142] Use the $( ... ) construct for command
 substitution instead of using the back-quotes
Date: Wed, 26 Mar 2014 10:41:24 +0100
Message-ID: <CA+EOSBk0m_XJd20eMAKN+KKd_06DOMGmcjgiLm3syCcLropP9A@mail.gmail.com>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqy4zyktng.fsf@gitster.dls.corp.google.com>
	<vpqlhvx8mt8.fsf@anie.imag.fr>
	<CAPig+cSaOK_EaEcyiuhNKDG=DGpt=NxhM+eJYq34C5=7pSuO1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 10:41:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSkKx-000871-DL
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 10:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbaCZJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 05:41:25 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:55909 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaCZJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 05:41:24 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so2008838veb.31
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8VJ957pZJAsLFGd1/OHVxoILsbq4kkraI6HKrjtWX90=;
        b=ZU4X0FQOEj/ugTS74RxUh71642blLmWnQyw3LFpocJBx/q7TOnfB0No8gYwKWQc8H+
         IwE9ojvELyD5a3mYNw/HPrYBcSK+e0ljakUr19FMarbhYSTpxmPVpQfK7fgbVu1qHEX4
         dIQ4Kd6ZCt/BpI94W4iLm2LDwRDGStMR4uSDQemszLBGuzWacoHIUpVzkPRZhoMzky3F
         +zn/DhRNGuYqOMvTAq6FPV7dMyHTpo9kWiRqj8whaD1Ch4J9cW10avZccrqqmkHTOyR7
         fRgZShDNEZDExaY23q1gHzV5KP1M6s8kMA6AJYFCjyAdfV7PpxrVsgtw7QQpNnJZYhW9
         PYYA==
X-Received: by 10.52.171.68 with SMTP id as4mr51108211vdc.0.1395826884223;
 Wed, 26 Mar 2014 02:41:24 -0700 (PDT)
Received: by 10.52.15.33 with HTTP; Wed, 26 Mar 2014 02:41:24 -0700 (PDT)
In-Reply-To: <CAPig+cSaOK_EaEcyiuhNKDG=DGpt=NxhM+eJYq34C5=7pSuO1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245172>

2014-03-26 8:44 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Wed, Mar 26, 2014 at 3:02 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  - Nobody has time or energy to go through 140+ patches in one go,
>>>    with enough concentration necessary to do so without making
>>>    mistakes (this applies to yourself, too---producing mechanical
>>>    replacement is a no-cost thing, finding mistakes in mechanical
>>>    replacement takes real effort).
>>
>> It's a bit less bad than it seems:
>>
>>  142 files changed, 609 insertions(+), 609 deletions(-)
>>
>> The first pass I did was a very quick one, but I already went through
>> the patches I received (apparently not the whole series) and it wasn't
>> that long.
>
> I also gave v2 a read-through. Nothing jumped out as a red-flag.

Thank you all. I will change the comment as  the maintainer wishes
(75ee3d7078fbcc3b87a3ae5e0cf42f46256c5da4 for example) and send the
other patches slowly (10 at a time every week, boring but that's
okay).

Best Regards
