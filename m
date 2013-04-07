From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] send-email: make annotate configurable
Date: Sun, 7 Apr 2013 12:58:22 -0500
Message-ID: <CAMP44s3bdFfZRGL1BHtODiad6ZXD_xy1MfUhNPrJQV=L4hGamw@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvz2948b.fsf@alter.siamese.dyndns.org>
	<CAMP44s0g5YfvprwukJ4rnqXrm+S9-KJkwyYB+sxAcQjZpDXufg@mail.gmail.com>
	<7vvc7y45nf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtrQ-0002a6-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934213Ab3DGR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:58:25 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48252 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759727Ab3DGR6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:58:25 -0400
Received: by mail-lb0-f181.google.com with SMTP id r11so4980222lbv.26
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mjNqcIRK47Egt5Fmby/xaKvAG9GQTEbxK+2Hx7V/eYY=;
        b=bzI3JlqG18f+xXfs3S3PFDVJryTudL8m+z9uJPxjytnAQgQ9DkzdbIIat+3IeqwiC2
         H444cmOST6tXJG0N8UWE8ULZkZj/Jz86F+sr4okxMicmT2mGv+5UZwtzeLoA+Nrlg1fo
         sGmg9L1cBgs05nhF8ESIHTSUdE3UCn0JuI6DUtZ5dohpwk8r5+yN34V26oK1P5Rrr/A5
         F5k2ESeN0KeeBF7OKL8BQskw7OaShplS3rYepx3wTl9zxrr2vzcdHiVlVFdILX5675wP
         30LGNxRFx89HWhKnbDjVLnruPnSbkIXWhXWxu3JJ8t6Z/O+f6pgzkiSDtm+A1aCZrkYS
         47Vg==
X-Received: by 10.152.105.109 with SMTP id gl13mr10133576lab.40.1365357502339;
 Sun, 07 Apr 2013 10:58:22 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 10:58:22 -0700 (PDT)
In-Reply-To: <7vvc7y45nf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220350>

On Sun, Apr 7, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Apr 7, 2013 at 1:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Some people always do --annotate, lets not force them to always type
>>>> that.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>
>>> Sounds sensible; any tests to protect this from later breakages?
>>
>> Given that annotate doesn't even have tests, I don't think it's needed
>> at this point.
>
> That is a good way to spread earlier mistakes and add more instance
> of the same kind of mistakes into the future.
>
> It is perfectly fine to say "I ran out my Git time for the change
> itself; help by others to add test for it is appreciated."  It is
> not reasonable to say "See there is the same mistake already in the
> code, so I am free to make the same mistake, you cannot hold it
> against me, and this feature should never be protected by tests".

I did not say that, I said I think this is not needed at this point,
if you think otherwise, you can go ahead and implement it. I think the
patch is perfectly fine as it is, and I'm not going to to add tests
for something that is potentially time consuming for me, and this
patch is not introducing, that is; the annotate feature. If we
survived without tests for annotate, we can survive without tests for
sendemail.annotate.

-- 
Felipe Contreras
