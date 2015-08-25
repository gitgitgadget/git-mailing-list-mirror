From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Tue, 25 Aug 2015 18:53:34 +0530
Message-ID: <CAOLa=ZTxNADuiHizF=HRK-KP2MuFJE=XS1BqRrmVQkyNVxbEgQ@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUECw-0002RC-HC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbbHYNYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 09:24:05 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33867 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbHYNYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 09:24:04 -0400
Received: by obbfr1 with SMTP id fr1so141313706obb.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fmjgKpFeaR1OCdE8xJclKUv7umZejtSEQPMhRLHBRdA=;
        b=FUx7jJwMUGgsCArNR4DEIrRifk++zYKW8vvj+YILz96g6mPgJSAJ17GORQGu6RuZu0
         1IfONx2ABaivpwK8OqeVDvZWHx+eAmScvs3FFSCna6Y2kmBfQIZyMYDQB1iePrpoMBIW
         uJXLTCPSwCaRj+8WOF94U/H02TI8arBeH5+mwS5KuXIMxVK1VKCyXCgQoUi+6vzpCknc
         vZGYQb7/zmSiOQUajF7vSFDIIHkILGnrYiQhxa5nbDC7YdycrS50C27uJylXSvgN3F3U
         EyipmGcvfnaJwHs4XORlgaqAQkdbwGKhAKerIsJjd5oPGqrFqfWqvARa9wfTlwOVHpm1
         NkWA==
X-Received: by 10.182.33.39 with SMTP id o7mr7878351obi.42.1440509043517; Tue,
 25 Aug 2015 06:24:03 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 06:23:34 -0700 (PDT)
In-Reply-To: <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276524>

On Tue, Aug 25, 2015 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>> index 1997657..06d468e 100644
>>> --- a/Documentation/git-for-each-ref.txt
>>> +++ b/Documentation/git-for-each-ref.txt
>>> @@ -133,7 +133,8 @@ align::
>>>      `<position>` is either left, right or middle and `<width>` is
>>>      the total length of the content with alignment. If the
>>>      contents length is more than the width then no alignment is
>>> -    performed.
>>> +    performed. If used with '--quote' everything in between %(align:..)
>>> +    and %(end) is quoted.
>>
>> There's no --quote, there are --shell, --python, ... (well, actually, I
>> would have prefered to have a single --quote=language option, but that's
>> not how it is now).
>>
>> I had already commented on a preliminary version of this series
>> off-list. I think all my previous comments have been taken into account.
>
> Thanks, both.  I think this is pretty close to being satisfactory
> ;-)  There may probably be a handful of minor nits like the above
> that need to be addressed, but I do not think I saw anything
> glaringly wrong that makes the series unsalvageable.  It was a very
> pleasant read.
>
> It's almost there, and I am very happy to see how this and other
> series evolved so far ;-)

I like how it's totally different from what I started off with, it's
been a great learning curve
for me. Thanks for reviews.

-- 
Regards,
Karthik Nayak
