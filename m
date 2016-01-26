From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Tue, 26 Jan 2016 15:00:41 +0530
Message-ID: <CAOLa=ZSQJQXEQ05+jqDBCp3QUBB9VYFVbaMT+k228HKKZkXKnA@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-13-git-send-email-Karthik.188@gmail.com> <CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:32:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNzyi-0007dB-E6
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046AbcAZJbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:31:23 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36041 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbcAZJbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:31:12 -0500
Received: by mail-vk0-f47.google.com with SMTP id n1so88273447vkb.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XDibM/VnLiFmnoSkoc1dbhTM5B7fVwEbC3+btc7OWEg=;
        b=qu3hFE6usVGYA8ecezIx/HcamCQhW1mBmhvHktnW66+NItBrV/TGfyHHxypwf+7BK5
         rXBQnnvceFefUvfJrGRHnXsNGHuYvABQXVxMLFVCWI9+uA3OQMLJpWxF+Yghbx7VG96T
         V7O4S8ClGE6v1hUEPfGOML7+SreD5XCty0w8C45rfURlcq4UujG9LjixOwnLsukOdoDy
         csYKFGrsvZrlWhvhA1mROCrRycDxRrBBnI/eh9A4fTYQJI4x9UJfCOvfNJCnAmFKnaSj
         Da9TPv/RqTnkfWR4Mk5HC+P0/zVE7o8W7GKXcNXhce5E8UQEwp9JDj/PkqaK/YLbrGvR
         ZXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XDibM/VnLiFmnoSkoc1dbhTM5B7fVwEbC3+btc7OWEg=;
        b=AsR+P3FoceqGjvnLkuP+fbNIa05dIkpxi/pi0TD9VFHHKIG1jUrEbOtJq3/bqhm2Dg
         mDP6gIIWLhPBcuHYMRGHBMJB8GMgWGYRohxJAHVg5lmc2GzD6bRJLrYKwlA9U3nsSMcJ
         JfRHuWImtVnDbHi3GcTzP++KSuaDhKUfTwi03zbDjnE4hH288u7kSxT4UAq1kAWK0LCh
         2VOfGxQ8IlB0kDkRvschqP4xaPc1qx418QsYJhifiE9xYUdEphA8tZ7eBjpPWXRikYKu
         XAFVpTxAFVGHa6Jct7vdyfOthcw9mW3hCjDucT0y8FW4hfd745g/jYuEvCaZCVlUS6Bv
         dzcQ==
X-Gm-Message-State: AG10YOQZdWey5eGXVRQC7et5QwjUy4s5M5EsDp5Re94KMJ5jQWJQ+xIsvlklX9WFk2Bv2pWXbOKkGdsc5sfU2g==
X-Received: by 10.31.159.136 with SMTP id i130mr13943043vke.144.1453800670939;
 Tue, 26 Jan 2016 01:31:10 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 26 Jan 2016 01:30:41 -0800 (PST)
In-Reply-To: <CAPig+cT56AiO-3GNzia7UsGZFM5zu5zsEC31XPuq-by1p4+sbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284790>

On Tue, Jan 26, 2016 at 4:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce optional prefixes "width=" and "position=" for the align atom
>> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>>
>> Add Documetation and tests for the same.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index fe4796c..0c4417f 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -133,6 +133,47 @@ test_expect_success 'right alignment' '
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
>
> Style: in shell scripts, add space before ()
>

Will change.

>> +       while read -r option; do
>
> Style: drop semi-colon and place 'do' on its own line

Will change.

>
>> +               test_expect_success 'align permutations' '
>
> This title is not as illuminating as it could be. It would be better
> to indicate which permutation is being tested. For instance:
>
>     test_expect_success "align:$option" ...
>
> Note the double-quotes. Or:
>
>     test_expect_success "align permutation: $option" ...
>
> or something.
>

"align:$option" seems right, will change.

>> +               git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
>
> This is not wrong, per se, but referencing $option inside the
> non-interpolating single-quote context of the test body makes it a bit
> harder to understand than it need be. As it is, at the time that the
> test body actually gets executed, $option still evaluates to the
> desired permutation value so it works. However, it would show intent
> more clearly and be more robust to use a double-quote context to
> interpolate $option into the git-for-each-ref invocation directly
> rather than allowing the test body to pick up the value at execution
> time.
>
> Fixing this means using double- rather than single-quotes for the test
> body, which means you'd also want to flip the  double-quotes wrapping
> the --format= argument over to single-quotes. Also, for style
> consistency, indent the test body. The end result should be something
> like this:
>
>     test_align_permutations () {
>         while ...
>         do
>             test_expect_success "align:$option" "
>                 git for-each-ref --format='...$option...' >actual &&
>                 ...
>             "
>         done
>     }
>

After reading this and Junio's detailed description stating otherwise.
It's safe to
go with something similar to what Junio suggested :

        for option in ...
        do
                test_expect_success "align:$option" '
                        git for-each-ref --format="...$option..." &&
                        ...
                '
        done

>> +               test_cmp expect actual
>> +               '
>> +       done;
>
> Style: drop the semi-colon
>

Will change.

> More below...
>
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
>
> Overall, this version is much nicer now that the tests are
> table-driven rather than each permutation being copied/pasted.
>

Thanks.

> This is a tangent, but it's disappointing that this entire test script
> is skipped if GPG is not installed, especially since none of these
> tests seem to care at all about signed tags. By requiring GPG
> (unnecessarily), these tests likely are not getting run as widely as
> they ought to. Consequently, it probably would be a good idea to drop
> the GPG requirement from the top of the file and have the "setup" test
> create lightweight tags ("git tag ...") rather than signed ones ("git
> tag -s ...").

Maybe an independent patch post this series. I'll keep a note to myself.

-- 
Regards,
Karthik Nayak
