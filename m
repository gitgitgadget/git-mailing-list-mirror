From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] SubmittingPatches : WIP tag in patches
Date: Fri, 26 Feb 2016 03:19:50 -0500
Message-ID: <CAPig+cTmUo_9Ji+73EiEXibjy=kN7w6bhFYraBNdhc1nO7D0pg@mail.gmail.com>
References: <56D05BA2.1090502@zoho.com>
	<CAPig+cT9Aqm0+AEGz0F-CTihMJtMw45fq4h6zxKs_7uxHak0bg@mail.gmail.com>
	<56D05EE9.8020400@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@zoho.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:20:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDd0-0005nb-JF
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbcBZITw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:19:52 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34157 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbcBZITv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:19:51 -0500
Received: by mail-vk0-f54.google.com with SMTP id e185so70891948vkb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 00:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2asZGAHX4YZw/TRVei6TnxLAUtbCQjEUwbdESFLcj20=;
        b=SOPN0snoR2eNDhkrZkZLXz0KaXxP/gXv+Se1vKHT9/PR2DAvMZU0J31npL6e95Rkbl
         I57KreOcFfB902Wg1/ggyRYOaM6iDywmU9yitm+VYbRD7qbTfo/yXpI7c01GoQOiV7WO
         5Us/WBE5k+7MxEe+XK3kpaad3WBXVZeTDByrRDTS/AMCsriqiHk7PSo2tW5QN2lg1pJ8
         BQbIHOh6sTZD0030SkzlCvXGM/YlM4rXhfR1WTSbKmMOws7XaMhbpSSDmLbOUnVW4G3N
         3cRZ8Wdgtfl6GDOAySlxbbE9ujnHfTi+nmMkzvuthSG/afzEfV+O3cvrUcuq09C7moBl
         cnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2asZGAHX4YZw/TRVei6TnxLAUtbCQjEUwbdESFLcj20=;
        b=ltepmmv0g6BclmpcUHeDfHwy4Lj6Nt2DwiXV/ILJkoV5MkjeiSl4VtVECu9umCzskV
         DJukXbbgoC/1NRxDMtZ722KPe6vRlV478zvfg7uJ7T8iqnvnm10wGhvq6VkkldrmDJzG
         1wJ2q/XudJWfThGnfvuPDw8YpypjPZRTuraYTLlgqON8H1UebPPuSA2V2mT0FvH3jXk3
         w2Vd6ofqC81fM07NWd6hnyh6fBp7+0rXWr56FRylHI1P2mHeGYgIBYORdQ+HyXl6zAWa
         KhEgIaqiw5n6c3S5GNCrPNjvp6BXQdch+2fY/n/3lxOJ8Y/+ZOiq760YD4do7R0CyAXb
         /ckg==
X-Gm-Message-State: AD7BkJI0LA6+woixe6SwAidRydSRnZQTFBglT/VGVnSJYL0RVOqMa3HCdNTaClnr3CBTCFb995Ik6QL7bhoEgw==
X-Received: by 10.31.8.142 with SMTP id 136mr198376vki.14.1456474790456; Fri,
 26 Feb 2016 00:19:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 26 Feb 2016 00:19:50 -0800 (PST)
In-Reply-To: <56D05EE9.8020400@zoho.com>
X-Google-Sender-Auth: HEkAn2hkVtfA79-5pEWwUHdljLo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287550>

On Fri, Feb 26, 2016 at 9:19 AM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
> Eric Sunshine:
>> On Fri, Feb 26, 2016 at 9:05 AM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
>>> ---
>> Missing sign-off.
>
> I have to inoculate the habit of signing off every time.
>>> diff --git a/Documentation/SubmittingPatches
>>> @@ -168,7 +168,9 @@ the closing bracket to mark the nature of the patch
>>> is also
>>>  encouraged.  E.g. [PATCH/RFC] is often used when the patch is
>>>  not ready to be applied but it is for discussion, [PATCH v2],
>>>  [PATCH v3] etc. are often seen when you are sending an update to
>>> -what you have previously sent.
>>> +what you have previously sent. [PATCH/WIP] is often used when some
>>
>> Perhaps: /is often/can be/
>>
>>> +work is yet left to be done on the patch but you want to get the
>>> +review on the completed part of the patch.
>>
>> Maybe: s/review/feedback/
>>
>>>  "git format-patch" command follows the best current practice to
>>>  format the body of an e-mail message.  At the beginning of the
>>> --
>>> 2.1.4
>
> I have done the required changes, now I should send another email with
> tag [PATCH v2] right?

Yes, you can do that, or wait a bit longer for feedback from other reviewers.

It's also a good idea in the commentary section to say what changed
between v1 and v2, and, as an aid to reviewers, provide a link like
this[1] to the previous version.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/287544
