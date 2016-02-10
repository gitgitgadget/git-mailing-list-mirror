From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stripspace: Call U+0020 a "space" instead of a "blank"
Date: Tue, 9 Feb 2016 22:26:58 -0700
Message-ID: <CAMMLpeTG-fccxxPb_P1vEtq8Kw7PaTkhLrmtN4NOOVWTZ1RsMw@mail.gmail.com>
References: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com>
 <xmqqvb5x1q01.fsf@gitster.mtv.corp.google.com> <CAGZ79kao-DWwn2j4aO8ArSPHAX65KeL7NyD=ONkB6qjOrDZNSQ@mail.gmail.com>
 <xmqqbn7p1obb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tobias Klauser <tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:27:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTNJD-00050o-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 06:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbcBJF1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 00:27:20 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37373 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbcBJF1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 00:27:19 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so11366609wme.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 21:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CeiD0i9DI8+IYUlQ/7B6bLkT/T5kCuQ9aoshbcJ8Hl4=;
        b=TTsjOI/vLDD5jDu4aSuwGqrtcOwRvxX8ZbqWWqk8kUlLWER/TxAZQvrCoHb0wVuwap
         ZHBTzDBjTfQIGs3bHCnIIVXA71S4F3ttetJ9w/DLWeWLp+FGy2314H2YwNpnne5kVJ0m
         2DDxdorxVpuztSU07+Ytkj+Y8U5K8L2pM7zuR/80Zr/er+JSO8uGQYYDb8hywDcHDHs4
         r3+6WRSFVK2Cx3/VTjipgh4pVrfNLLi3UU8+tv9J/c2qoR+pdLcKEtkTEiIfTpKMgd3x
         ne7jh2Dy5fOCizgkmo8JhWEdCb3je8KFiJXDqbcJ/01iqpW1TVAyceP/UyTnLozhrVPi
         6NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CeiD0i9DI8+IYUlQ/7B6bLkT/T5kCuQ9aoshbcJ8Hl4=;
        b=B9Cp6arevAU2JF1vhqF9HUdUIH767hAbrvY0LKdfTZzfrzrQbUfpFUanXKXls5tVPy
         8aSyjxbNcow7jme0gYfNZA4hlqnTcfQYEuYE2495V4mvR6AhHxuioLC+wFQyRWmM6065
         kC9iDtvSo9jEcd87/q9tGzK9WcX/bIHpW1bDdIlCW+68DqRYeoyAiFgXOrMCB3ehGBtX
         bh63FizdGrJ2AE5fRmFCd2mTMTiSXQb2mSrVPTiam9NOK4hnoNcH9vuQYPUfPKNykudK
         MIZ/b5iIBloloHhsZRX2b/YJ2hF+Cs/RMGescS/BIngNKQOc2ijayLFxDyg9/xIm1Nm7
         iKGg==
X-Gm-Message-State: AG10YOQdGzOBj10g5FSprTQ8q3AqU5QTeif/06+X5fGCMC1n3ou9ywcGn3bNdbah9m7ry0BvCDs1d8snOKV+2w==
X-Received: by 10.28.210.73 with SMTP id j70mr8404069wmg.8.1455082037833; Tue,
 09 Feb 2016 21:27:17 -0800 (PST)
Received: by 10.28.73.212 with HTTP; Tue, 9 Feb 2016 21:26:58 -0800 (PST)
In-Reply-To: <xmqqbn7p1obb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285891>

2016-02-09 16:00 GMT-07:00 Junio C Hamano <gitster@pobox.com>:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Feb 9, 2016 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>>
>>>> I couldn't find any other examples of people referring to this character
>>>> as a "blank".
>>>>
>>>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>>>> ---
>>>
>>> Any comments on this from anybody other than the author that I
>>> missed to support this change?
>>
>> I remember "blank" being used in my early days of computing.
>>
>> The blank was somehow more accurate as it described the exact
>> thing (i.e. char U+0020 as commonly produced via the space bar
>> on the key board)
>>
>> A space however could refer to any kind of indentation.
>>  * tabs would qualify for that
>>  * other tricks of your (wordprocessor-) editor would qualify for that
>>    (indent by 2 inches in footer section or other weeirdness)
>>  * any other character not using any ink in a printer[1]
>>
>> [1] https://www.cs.tut.fi/~jkorpela/chars/spaces.html
>>
>> Looking at that table in there, U+0020 is officially called "space",
>> so I guess the patch is technically correct.
>
> So the "blank" is correct because we just want a gap between the
> comment char and the text, and use of " " is merely an
> implementation detail.  The "space" is correct because that happens
> to be the byte used as the implementation detail of leaving that gap
> between the comment char and the text.
>
> ;-)

"blank" does not sound like good English to me, but there are a lot of
dialects of English, so I can understand if it sounds natural to
someone else.

-Alex
