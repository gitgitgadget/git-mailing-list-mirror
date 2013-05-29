From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 09:10:44 -0500
Message-ID: <CAMP44s03Gig4j5RD+7FnjWppHZ0rsJ0mvFrrVbpYoRmyU=xJWA@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com>
	<CAMP44s0cpAkAUzo0nS55yv+6=cCBsBhgNiYxpEd8Hzk=3mfNhw@mail.gmail.com>
	<CACsJy8Do-djwjVP1YvGnvsbdiWjE47KTK4pZZ3Qdnubvd-r3Lw@mail.gmail.com>
	<CAMP44s0vaPUmvS8OzZ_4UR5XmKK-fyU4nE47Djjr215zkgpRFg@mail.gmail.com>
	<CACsJy8Br1gigKL2GHQxC-9X8nizXzWcBysVuCHCGh1F3DiGp8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 16:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhh5Y-0006mN-VH
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 16:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966361Ab3E2OKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 10:10:48 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:63386 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966355Ab3E2OKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 10:10:46 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so8757001lab.13
        for <git@vger.kernel.org>; Wed, 29 May 2013 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xhVyXpMGV0zBtsDXDlloB0IRKxxa8ktRID7x9rVG8kU=;
        b=oDoT5LXQ4vmWKlrBh+AEIeCz06V8zDg4aeIR0IYhmeXkOizV2D01SXBJm2khJH7LAE
         QBxluB8WLl8aQbt3D+djq9WwuXTZWKCD4Z9Co7mA/IW/+qJcaVOsvD7zEbeHrl5SmlB8
         /vAn9ryQtdfuXKxk3zynZa/LflUscFsgt7HKTTereOQxpELuDLQayjifOEqEA4IhBkqk
         C9r+9HK01cxuujRnlXSzMUSuxF12Zqvn8yEmQmQ1U5cc03W5icC6HTzjQ4fxpOHeBwhc
         La7yTBNwua2K7bTBsr5kRKy29lnWasMUt+09kpnY2jLXyzsiHLY/jAmdmpP7BhAGXDev
         sk0Q==
X-Received: by 10.112.33.17 with SMTP id n17mr1672567lbi.72.1369836644735;
 Wed, 29 May 2013 07:10:44 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 07:10:44 -0700 (PDT)
In-Reply-To: <CACsJy8Br1gigKL2GHQxC-9X8nizXzWcBysVuCHCGh1F3DiGp8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225832>

On Wed, May 29, 2013 at 8:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 29, 2013 at 8:46 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, May 29, 2013 at 8:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Wed, May 29, 2013 at 8:34 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Wed, May 29, 2013 at 8:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>> On Mon, May 27, 2013 at 11:52 PM, Felipe Contreras
>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>> We should free objects before leaving.
>>>>>>
>>>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>>>
>>>>> Micronit: perhaps you should move the "free obejcts before leaving"
>>>>> (in do_pick_commit) to the subject instead of "trivial fix", which
>>>>> adds no value to the patch.
>>>>
>>>> Perhaps. I prefer it this way because it's really a trivial fix not
>>>> really worth much time thinking about it. So when somebody is browsing
>>>> the history they can happily skip this one. The time save by not
>>>> reading I think adds more value than any succinct description that
>>>> would force each and every patch-reviewer/history-reader to read it.
>>>
>>> Some time from now, assume a ridiculus case when this function grows
>>> more complex and somebody wonders what the "leave" label is for, "git
>>> log --oneline -Slabel:" showing "trivial fix" would not help much.
>>
>> Fortunately that's not the main use-case, and for that single instance
>> that probably will never happen, I think it's not too much to ask to
>> this hypothetical developer to remove the --oneline, or copy-paste the
>> SHA-1 and take a peek. He would probably need to do that anyway.
>
> And the "time saving by not reading" is also hypothetical. But I won't
> continue this discussion.

Is it? How much time does it take to read "trivial fix"? Half a
second? How much time does it take copy-paste the SHA-1 of a --oneline
log? Five seconds? So to break even we need ten readers that would
only browse the history per each person that goes beyond the summary.
To be safe let's do +- 100% and make it twenty readers.

I think it's safe to assume there will be more than 20 readers
skipping this commit without much though, perhaps a 100 or even more,
and how many would need to take a closer look? I'd say 0, 1 might be
possible, but to err on the side of caution let's say 2, hell, let's
be generous and make it 3. We are still safe well beyond profit.

But we have already wasted many more seconds than any of those guys
would, so does it really matter?

-- 
Felipe Contreras
