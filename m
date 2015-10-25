From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: fallback on alphabetical comparison
Date: Sun, 25 Oct 2015 12:45:28 +0530
Message-ID: <CAOLa=ZSS3QK8wkKUGCtLqhoZATCxJxpYBvPCUf37KHVwZeRsOg@mail.gmail.com>
References: <562B3807.2030203@kdbg.org> <1445697770-29331-1-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRnDNFCQs6qspKDEz6C0Rum8W0tSMxejw+WOBD=XHrDxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 08:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqFXe-00031Z-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 08:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbbJYHP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 03:15:59 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36607 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbJYHP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 03:15:58 -0400
Received: by vkex70 with SMTP id x70so82663862vke.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nuQR2FDbU9I8wNmPxKke+IdMVyGByx/XqquwKg+ie1s=;
        b=z4tPIMJ6fZsM0dLcyFJD4NDL3BhttsYwdfzPR0vLHoUu8yar26+a2Zgu/NvAAcj+Hj
         ylQOSsdj9xBcU79zVJ8LV2UiLy9Q6WnteLl65lECt3/h0X8abB4k4F50r/xmG9L8rXlx
         70cfLb4oRnerPQp7AiWcrrm8Jkb1YnQi0SWru5x9oTZvwFaMOTFK8DYiF9JfvArZ/Yj0
         0axzFocy9zXQowhJhDukV1Pt+pTegxUWl/yypmNy2U+pbr0xOCDeeUoh8dwg+IntUKQl
         qwTZBlrGzov79Qmv1tGELhhBLJGzSnQRytAC09hhpNEnfDxbvDhb4njWI9ddrm3/cT/Y
         JvpQ==
X-Received: by 10.31.171.140 with SMTP id u134mr626503vke.30.1445757357901;
 Sun, 25 Oct 2015 00:15:57 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Sun, 25 Oct 2015 00:15:28 -0700 (PDT)
In-Reply-To: <CAPig+cRnDNFCQs6qspKDEz6C0Rum8W0tSMxejw+WOBD=XHrDxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280138>

On Sun, Oct 25, 2015 at 5:48 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 24, 2015 at 10:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In ref-filter.c the comparison of refs while sorting is handled by
>> cmp_ref_sorting() function. When sorting as per numerical values
>> (e.g. --sort=objectsize) there is no fallback comparison when both refs
>> hold the same value. This can cause unexpected results as pointed out
>> by Johannes Sixt ($gmane/280117).
>
> Please make the commit message self-contained by describing the
> "unexpected results" here rather than directing readers to chase down
> the information elsewhere themselves.
>

Will do.

>> Hence, fallback to alphabetical comparison based on the refname whenever
>> the other criterion is equal. Fix the test in t3203 in this regard.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>
> It would not be amiss to add a Reported-by: to credit j6t.
>

Definitely. Thanks for the quick review :)

-- 
Regards,
Karthik Nayak
