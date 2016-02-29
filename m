From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Mon, 29 Feb 2016 18:37:40 -0500
Message-ID: <CAPig+cTAv8eNcTkN6K1kJ5zBcibmbRR59MLV6PCM=qa84HNdDg@mail.gmail.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
	<xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
	<56D0D2DF.1040807@web.de>
	<xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
	<20160227032907.GB10313@sigill.intra.peff.net>
	<56D14C56.6070306@web.de>
	<20160229101808.GD2950@sigill.intra.peff.net>
	<CAPig+cQkP++rnE4L1QSr-sW8VkS8ce7CyY9KAscebLao2Hw73A@mail.gmail.com>
	<xmqq37sbe8qr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXNp-0001Vt-5m
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbcB2Xhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:37:42 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:32970 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcB2Xhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:37:41 -0500
Received: by mail-vk0-f45.google.com with SMTP id k196so152015944vka.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=MRwrpkhTq94CCF2esaFFaGWn++LJiPHO7MlEpjeNNk0=;
        b=s1CMqxp8+SOIRiaS8Xxu+hEvDEL0aVFIJzC8ab37Xsj4lIMe6l71Ii0ArgISANGj9x
         27iMPahx+iQjq8m6MdSyzHM339iTYFe4KXepUQgJ5yZJygeb+xrd8Dy2TJ0OnJXbingt
         Xa3ItYWQ078Kemy+DstH9j1Sh6KHhYWLOeb+3ywBXL+0vd9+wg6FsDf++il93J4ShN+e
         7GIVQjQtGHKnECR5HEQaddy002ogZ6AqpMrQWwrHf1VrCI6ug0CtkB2ZGcmRad4zVlWF
         UrjL52ykomafHZQFx8bEktz6OFOGOlUOorXcbbSv2qZwOVbULNxUONS6D2LLLV9YmjBS
         hmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MRwrpkhTq94CCF2esaFFaGWn++LJiPHO7MlEpjeNNk0=;
        b=Twc3IHFUmf7oclkuYSm6JrPsbMx5dU1e3m+kztRCM/3hpXb0UFUxOvTGO8BVhWraqs
         eVU7WPkfGfUmguxwrW5xhFfC4qjuQ3iswF/oElGqZ6u5Q1J8nvhBT9xQC3vBOYS4dTQl
         ox9GuKRz//MxX1EuyCTcwLxM8whqcVjxoAp99MajK/41TL/cFZn7/6DJywILdXuQF8Zi
         tcm+dRJt2X5EhhNDaunyw60pZfm7een/hDR+Tbs9QEP/0c5T/fG1VQ069gQVKU8lYjM8
         GENXy0X6fjt0xK86xOi7d0lpqWKIsxnSNMuTfOxNCUY/bvRnRxO18mSC6h4MUfo2ZQ8K
         zXNw==
X-Gm-Message-State: AD7BkJL6OMDp3/hZKHD0xMc9GxGBSa4kCLc38HmW3BANI2nt6mMl2V0m1NYPtz9QhKVOr1+GSxWz0cwAm56SYQ==
X-Received: by 10.31.21.4 with SMTP id 4mr1723295vkv.151.1456789060119; Mon,
 29 Feb 2016 15:37:40 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 29 Feb 2016 15:37:40 -0800 (PST)
In-Reply-To: <xmqq37sbe8qr.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: mRWGM6tQtyWSBkgiBC3JA1D2haQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287939>

On Mon, Feb 29, 2016 at 12:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Your suggestion elsewhere in the thread to just use clang instead sounds
>>> good to me. :)
>>
>> If possible, for the moment, I'd prefer to hold off on that
>> sledge-hammer approach of unconditionally making the build use clang.
>> It would be nice to have a more detailed understanding of what exactly
>> is triggering the Apple compiler bug, and I've been trying to find
>> time to check it out on my old Mac.
>
> The (fixed) patch posted was "on OSX 10.6, use clang by default"; I
> think that for majority of the users, that is a reasonable thing to do.
>
> The result of the patch still allows those who want to see how badly
> old Gcc breaks to do so with "make CC=gcc", doesn't it?

I was not able to reproduce the problem on OSX 10.5.8.

Since the patch applies specifically to 10.6 (via -eq) rather than
"10.6 and earlier" (via -le) it happily does not break the build for
older OSX releases (such as 10.5.8) which lack clang. Thanks.
