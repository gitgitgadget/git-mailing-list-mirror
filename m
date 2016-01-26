From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Tue, 26 Jan 2016 15:10:44 +0530
Message-ID: <CAOLa=ZSnDe=q8SpicYW6gNKmNts3K=FpCFq6q8t_pUv+8AZhnQ@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
 <CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com> <xmqqa8ntdxzs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:41:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO07q-0003n1-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934103AbcAZJlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:41:18 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33539 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934067AbcAZJlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:41:14 -0500
Received: by mail-vk0-f46.google.com with SMTP id e64so89288431vkg.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DEPoADYlgJTqcO+kHiMRkeRYsjGkXIgAOCs4U3Y/Mpo=;
        b=WnD+vdicbOKL92RrMMy0VG+BHDfqTM+j3E91WPIhecrQ/dzwQXAnvA+WjT33JCWV91
         aEqFNgzWdB/jCOunNRHR++Wha7YIF4UX85XqpyrUYibpU5GR5LGbliwP98qTfPRgDIPE
         p3gvXKvXzqtddqBzlOUBAS4fBh0J5Qn2z3bQwkFv+GRTOkvNd6by7ZUH5JT99Wi355wE
         ahpar6V/GdlMCkzuY+SSOiUD0iDIXsCguNUqlWyFvi2yudZ62harXM9jGrWAp8HiEXLm
         tVCnmTTgM4SErT8dwzXGgmn9Z2JgBnIV+hDOT18j20XsWOyKVvR8dFoygthmQENK1b1y
         ZAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DEPoADYlgJTqcO+kHiMRkeRYsjGkXIgAOCs4U3Y/Mpo=;
        b=YdC4hh5v8mOl12SZZZRJyg6VEPm9CbDmVnEpdbVk1QkvHGsD9TVQCKANMjS/zkl4fd
         QsapwCECIcC291gO4G95umvi2OMpOdoHcaMxAWdUYsQR5Ox+cKlBBmm5Sgr9KhOYFLqg
         B6VsYMxxqPbnp3ZGVxF6NAardteDBwLblDVHjysPM8NLZ8ESMsFhXcWUC0pJZESSxrlU
         1+U6PI6JjHGbOS/1qE8q1QP574UdN8iQxJagYLvFwOYGleVK2Nh3PfkUNNBT76W8C6kh
         jUIZs89jCnJFBxKJvkhKU/sMQz0M5v//I9Ea6qnrfaOBUn/JN2g7jJIdcmieG8G+rzAG
         ioaA==
X-Gm-Message-State: AG10YOTQKbrjWgaiQUR/SsmXw5mgILzZqLnP+r0Vswl/BWgPK7feu3q/KmEfoS2MM1At8NqLvM2l7dDet2zSyg==
X-Received: by 10.31.142.203 with SMTP id q194mr13668720vkd.95.1453801274019;
 Tue, 26 Jan 2016 01:41:14 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 26 Jan 2016 01:40:44 -0800 (PST)
In-Reply-To: <xmqqa8ntdxzs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284796>

On Tue, Jan 26, 2016 at 5:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
>>
>> This is not wrong, per se, but referencing $option inside the
>> non-interpolating single-quote context of the test body makes it a bit
>> harder to understand than it need be. As it is, at the time that the
>> test body actually gets executed, $option still evaluates to the
>> desired permutation value so it works.
>
> I think I said this in one of my recent reviews to somebody else,
> but this needs repeating.
>
> My position on this has been and still is a complete opposite.  It
> is a designed behaviour that variable references made inside test
> body that is quoted with sq pair can see the values of the variables
> that are defined outside test_expect_success, and you can freely use
> the global $TRASH_DIRECTORY, $_x40, etc. inside the test body that
> is quoted with single quote.  The $option here is no different.
>
> In fact, it is more desirable to avoid double-quoting the test body.
> The problem with using double-quote around the test body and
> formulating the executable shell script using variable interpolation
> before test_expect_success even runs is that you would be tempted to
> do something silly like this:
>
>     HEAD_SHA1=$(git rev-parse --verify HEAD)
>
>     test_expect_success "check something" "
>         HEAD_SHA1=$(git rev-parse --verify HEAD) &&
>         ... do other things that should not move the HEAD ... &&
>         test '$(git rev-parse HEAD)' = '$HEAD_SHA1' &&
>         test '$SOME_VAR' = '$OTHER_VAR' &&
>     "
>
> It is not just error prone (if variable reference had a shell
> metacharacter in it, e.g. a single-quote in OTHER_VAR's value, you'd
> have a syntax error in the test body), but because two invocations
> of rev-parse in the above are both made before test_expect_success
> runs, and would yield the same value.  It is not even testing the
> right thing.  If you broke rev-parse, the invocation will not fail
> inside test_expect_success but outside when the arguments to that
> helper is being prepared.
>
> So please do not write something like this:
>
>>     test_align_permutations () {
>>         while ...
>>         do
>>             test_expect_success "align:$option" "
>>                 git for-each-ref --format='...$option...' >actual &&
>>                 ...
>>             "
>>         done
>>     }
>
> but make it more like this:
>
>         for option in ...
>         do
>                 test_expect_success "align:$option" '
>                         git for-each-ref --format="...$option..." &&
>                         ...
>                 '
>         done
>

Thanks for this descriptive explanation, I shall use the suggested format.

-- 
Regards,
Karthik Nayak
