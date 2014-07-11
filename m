From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Sat, 12 Jul 2014 01:35:30 +0900
Message-ID: <CAFT+Tg9vLE-xr9dBV8uD=f0xu+U4_XOqdRC5ZKd95P0vLqfdbw@mail.gmail.com>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cTbhUKF7OwYJY2_1m9j=khPRaLM2kd5KqDGD=vjRz0qHg@mail.gmail.com>
	<CAFT+Tg-6fR9OJ93TT7ww3x=zYHY=Dh5u-7owgQMBK5o_JKLEaA@mail.gmail.com>
	<CAPig+cQ05pzU9uVBqS8tBHvB8_3qAtgsPYz1sGhpa0W1CVymqA@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 18:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5dnN-0002Yq-3M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 18:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaGKQfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 12:35:33 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:60601 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbaGKQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:35:32 -0400
Received: by mail-ig0-f169.google.com with SMTP id r10so726501igi.4
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=Vc6TvU0R5ybrBUK+zGraVxYV5UKHz5tC1cqjiC8ZGe0=;
        b=qmkTyjjgNU7sDlpb9CgDsrDh5HSCLcO6RJKkLaockz6DqrwVutIqpW1qWvohHIq0As
         TUaIq3/dz7uODIIItSMu2CQeVyXo/pm06I5MGHFNuBoWuQ7vU0BOiMy6RJsBW3c++mAD
         yAnIb7FxsCWxwbcsYeg07BbvL9YueuM/y3G6BLNJYikv5S6BACYipStnTKXy4r8cMtp0
         GvgvJYyg6JJSdrar9hhLDBHAFdwo0J+IJEUeaFi1/Zb23VMSz+zRntiGGn/5RFUrtAqq
         4YIl/nQA2GSj8EmIs8VxUFZovThS8m8lyP9Nl8St2NhvAdxiw3Zq1tH+rJIcux3oc4es
         mAUg==
X-Received: by 10.50.92.101 with SMTP id cl5mr6113577igb.2.1405096530863; Fri,
 11 Jul 2014 09:35:30 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Fri, 11 Jul 2014 09:35:30 -0700 (PDT)
In-Reply-To: <CAPig+cQ05pzU9uVBqS8tBHvB8_3qAtgsPYz1sGhpa0W1CVymqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253290>

2014-07-12 1:24 GMT+09:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Jul 11, 2014 at 5:22 AM, Yi, EungJun <semtlenori@gmail.com> wrote:
>> 2014-07-09 6:52 GMT+09:00 Eric Sunshine <sunshine@sunshineco.com>:
>>>> +       grep "^Accept-Language: ko; q=1.000, en; q=0.999, \*; q=0.001" actual
>>>
>>> Do you want to \-escape the periods? (Or maybe use 'grep -F'?)
>>
>> I just want to match '*' character. I tried 'grep -F' but it does not help.
>
> I meant that the periods in your grep pattern are matching any
> character. If you want to be very strict, so that they match only
> period, then you should \-escape them.

Oops, I misunderstood you. You are right. I'll \- escape them.
