From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] date.c: phrase a comment gender neutral
Date: Tue, 18 Nov 2014 12:07:24 -0800
Message-ID: <CAGZ79kYtV3d0iTuzuh=+pzSOYJ8O3MUS4YFq2FbwS-pinU2+iA@mail.gmail.com>
References: <1416338668-30683-1-git-send-email-sbeller@google.com>
	<xmqq4mtwwa1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqp3m-00015v-VX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbaKRUH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:07:27 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:44570 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbaKRUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:07:25 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so1665553igb.5
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 12:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n8kP3PM6NbHyJ+yWaCfIM+KYS/uJjmtKL41pNoKVQjg=;
        b=n0hW28QrgGEKJMRW9z+HCZUa1bsd7Ag0fuKkJr4w9O3MSDMHBhlLLflw52k0fRtzHl
         a5Nxg8Shiu46pN2P85lUQ53JG+MmVNoYNZ4g+BHonN6ttgZtfa7KdIQBBrWHU5AZ6u3M
         Hj4T7JtwC5lS/gV2VIKGIfEyHe3ba3jwwhF6QoktgjwcLXZOUwS4WNh5gQWeCE0lWdLa
         GyG4VyNyNC4Ik2lB8GYQNggBkY61+xv4VcT2LS/Fzk/hSjLAUOWqPcjTDgQoSO6d1L9p
         xMpPRMbKLKqhzSjDzKh3zaq6Xt9el+N2JNqQSF0UbSaFBxovCIsOxwYEJBZdKCANH2xK
         4MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n8kP3PM6NbHyJ+yWaCfIM+KYS/uJjmtKL41pNoKVQjg=;
        b=G42WkTtUaCWNGA3X6nJVQZD9tDHIe4PuEbnC01btKijdYdSVGCJn15OOYFSKqsXWE/
         ne/iaEK7HuHVXIq+RSwDv059PVqIcs4FLJ4Q0WUY3sHXG+BPSTlQ53TmAuMNeaI+wr5h
         pDreV5a+gCD7mFAskuy4mfo7PDEUS63Kt6gUWdMq0wjFfPbeRvU1TM2J8k1trxOHoFvn
         vcRMx5LKmM9dWthMExLwbEp86qGshJPWa5010+u2DSgZQ7L5Aen0ihLkzuL9cUqyh3xW
         f0qu3eCM1uaowGW8BknYkbfnbZzqrl5qj+32g13MsZWtHQDzCpAZEetws3hLIi4VllbB
         QiDg==
X-Gm-Message-State: ALoCoQk7zrE2Zp1R8Jle5VBTQonfwsmkar6ScFpoqcp6p5rMtAPnnSjxERLOq8VsBzzXAQEmxauQ
X-Received: by 10.50.79.229 with SMTP id m5mr35730175igx.10.1416341244932;
 Tue, 18 Nov 2014 12:07:24 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Tue, 18 Nov 2014 12:07:24 -0800 (PST)
In-Reply-To: <xmqq4mtwwa1n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ok.

I'll stop sending such gender related nits.

On Tue, Nov 18, 2014 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When looking for suitable functions to print dates,
>> I found this gem. Let's make it gender neutral as
>> nowadays people get upset by this gender debate.
>
> For some time I used to use "she/her" on Mondays, Wednesdays and
> Fridays and "he/his" on other days to balance them, and you are
> seeing the artifact of that.
>
> Some people might feel that we would be better off using "they" all
> the time, but IMO it's such a minor thing that once it _is_ in the
> tree, it's not really worth the patch noise to go and fix it up.
>
>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  date.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/date.c b/date.c
>> index 59dfe57..19fb439 100644
>> --- a/date.c
>> +++ b/date.c
>> @@ -732,7 +732,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
>>               /*
>>                * We take over "now" here, which usually translates
>>                * to the current timestamp.  This is because the user
>> -              * really means to expire everything she has done in
>> +              * really means to expire everything they have done in
>>                * the past, and by definition reflogs are the record
>>                * of the past, and there is nothing from the future
>>                * to be kept.
>
