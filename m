From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 09/12] ref-filter: align: introduce long-form syntax
Date: Sun, 7 Feb 2016 00:07:01 +0530
Message-ID: <CAOLa=ZRSbvY-VbFKxXAM+_uaRd_Odfc4w+ZfHpwHbznfscv9sg@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-10-git-send-email-Karthik.188@gmail.com> <CAPig+cQCLDvWfzWqoLq9xKsMO7FPKYSn0HxtKizhMv94hxXyBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:37:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS7jk-0002lB-Cu
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 19:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcBFShc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 13:37:32 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33075 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbcBFShb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 13:37:31 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so1380598vkb.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W22qfCvW/0Bkf5IYzxJ5zCvkh0mPdaLa3pjMitmQvls=;
        b=sNH62uNZaFqEzp2eTyB3TEleFBFxmzmOjhv6zeErGc/9lsvuyc+TJp2A28LWSTZpQn
         83wU6iLSishYSrXYIaqtbqNKYZGuYPKe47GCYoMYr86E2Ru4FHGi9BAKezvCAnEeBNIR
         qXWb/f8z988ETYTcXQOKk/fBFEj9pLzAF8EwqPmhYet4pi9430SBwD0FQpxn/RisMOqk
         Pb1MBk7UGEXOv0n3k9OZkTGuEk2yS/hKcpVKHU7ZdPiD9PTidJCf8clkAMnHDbXpSTLN
         pJMJy2W4YIR9Lv6l1xqyFVTJTM88VatlVtQWc2tOMZgk+nqfGbtkpoZyYMI1K84il5Bh
         vdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=W22qfCvW/0Bkf5IYzxJ5zCvkh0mPdaLa3pjMitmQvls=;
        b=KYgFpxEw2T1HbgrVZaGhrjp0/tblX3FqLoNLKMaMa9JMnPyu03XCriI6VFsTskBfDc
         m1AIvNYLlvDopAcQ3bueggx9PbDF1gqg5uYsdvwcA2kojOozhQckkBKsCiFWeSxkL8b8
         a44YBiAD1CFHsAE0jsFUQkBdnl6zNc5MA/uSg3zowmEtbOAfqzX1OJqghK6KwLtwH03q
         +BWIYd3ay7x/Bi9RqVuQPiS/5+cVpozdbhyAopbMM0z83rVG+jsCUx/S3scXlDCb0yXe
         77m5GxWfcoVQQ7n1XoPOxZIwjpaOjBExvtrdMPlZt8nSZJSJ8ZcYbTX5zCVfWD6YRJTr
         Szsg==
X-Gm-Message-State: AG10YOQIm54NYM6CMZ0LAUBcIjLP+19oLC5uVBkO+RjFzRq9BzpT5VOnZ5M+71JExPoiGOTsh+bNFn5sxVcSBA==
X-Received: by 10.31.155.131 with SMTP id d125mr12225520vke.146.1454783850853;
 Sat, 06 Feb 2016 10:37:30 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 10:37:01 -0800 (PST)
In-Reply-To: <CAPig+cQCLDvWfzWqoLq9xKsMO7FPKYSn0HxtKizhMv94hxXyBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285701>

On Fri, Feb 5, 2016 at 5:30 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce optional prefixes "width=" and "position=" for the align atom
>> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>>
>> Add Documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> @@ -133,6 +133,48 @@ test_expect_success 'right alignment' '
>> +cat >expect <<-\EOF
>> +|       refname is refs/heads/master       |refs/heads/master
>> +|        refname is refs/heads/side        |refs/heads/side
>> +|         refname is refs/odd/spot         |refs/odd/spot
>> +|     refname is refs/tags/double-tag      |refs/tags/double-tag
>> +|        refname is refs/tags/four         |refs/tags/four
>> +|         refname is refs/tags/one         |refs/tags/one
>> +|     refname is refs/tags/signed-tag      |refs/tags/signed-tag
>> +|        refname is refs/tags/three        |refs/tags/three
>> +|         refname is refs/tags/two         |refs/tags/two
>> +EOF
>> +
>> +test_align_permutations() {
>> +       while read -r option
>> +       do
>> +               test_expect_success "align:$option" '
>> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
>> +               test_cmp expect actual
>> +               '
>
> I think I mentioned this in the last round: The two lines following
> test_expect_success() are actually the test body, thus should be
> indented one more level. (Not necessarily worth a re-roll, though...)
>

I must have missed it, will change it.

>> +       done
>> +}
>> +
>> +test_align_permutations <<-\EOF
>> +       middle,42
>> +       42,middle
>> +       position=middle,42
>> +       42,position=middle
>> +       middle,width=42
>> +       width=42,middle
>> +       position=middle,width=42
>> +       width=42,position=middle
>> +EOF
>> +
>> +# Last one wins (silently) when multiple arguments of the same type are given
>> +
>> +test_align_permutations <<-\EOF
>> +       32,width=42,middle
>> +       width=30,42,middle
>> +       width=42,position=right,middle
>> +       42,right,position=middle
>> +EOF
>> +
>>  # Individual atoms inside %(align:...) and %(end) must not be quoted.
>>
>>  test_expect_success 'alignment with format quote' "
>> --
>> 2.7.0



-- 
Regards,
Karthik Nayak
