From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Tue, 26 Apr 2016 00:10:16 +0530
Message-ID: <CAFZEwPMsmay+tv48p=zh3r4L1d38tNU0Z6zyn3Op_pd-nsv3Aw@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
	<CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
	<CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
	<CAPig+cSvvAJT6yb2h6B1S5LDr8H03t-b66rmbKWpo88Fw-ehmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:40:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulQm-0001lx-A5
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbcDYSkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:40:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35387 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbcDYSkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:40:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id v81so577283ywa.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QjJyuNhBPwIKDhXfOFtGqqrSjetHLUNNgcdLormyi7I=;
        b=OtyK08dImUItrlP9iWcj2mu9OVAiM/HiVc4BaajwijcYvHnx1gwIOudWmHDEAHyzfg
         3lR5dQGzON8OiXraY4r+8WJttmcV0Bml3VJdaok+DT30f2LB5m6y1U8WSI00nOGZJPZP
         ssOpZTkJ+UFwlDLgP3NtlcHRlaTwpuQWaHmni43KCoEguYPJGFVjLxxhjDGj+QCbOaxB
         1/JspQAvULMhl0cCgMNeprGKiNBgtO8eWZAinjUQvkX+nwbBbgnRMQCAgjAvBO74psvg
         4N32i6RFu3ROAMCyFL8mOffwcu0BSv3OQdyGsRcuohcPr+joHJNq2rEZKeSvvEXtOkUP
         tA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QjJyuNhBPwIKDhXfOFtGqqrSjetHLUNNgcdLormyi7I=;
        b=VPdFbeKxoGGR30lWLIL+wcyTklgvVRq+9QZhAMZ5MqWpHiYFP2nXHkFBG5j+FISk0e
         xF+80hswwBZIQulVqet2+oZuwjvdOejC8zR8HXRb8QuMp9Du09rOvn6TRAR30GE7+jjE
         8IjOZSP4znDtM73l9GZQgjZVEL15NaxK6s6jFzS3Pn7bGN26eYTn8Y4MBjn767VPbQ/A
         CpCfZ53V3lpecXF7sPnjgNVSed0qNVMsi7wRUR/crn3z7PjnULZQgkHg+axKr2Ouxx/C
         irG7OGjNYT8zIhLsTr5EqZ4We5a/Mx+7RHrp5XNyINPdaYxu1y/lLTkxkTKsaNH5fVVY
         hUMA==
X-Gm-Message-State: AOPr4FWIe7hDgr7QmOwYdaMN2ylOwclborOGwqFDd3ONkV/NhPm6NUW85XgUa+JmO3q27hbOt0hr74I5zgH/Qw==
X-Received: by 10.37.210.9 with SMTP id j9mr21746758ybg.53.1461609616400; Mon,
 25 Apr 2016 11:40:16 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 25 Apr 2016 11:40:16 -0700 (PDT)
In-Reply-To: <CAPig+cSvvAJT6yb2h6B1S5LDr8H03t-b66rmbKWpo88Fw-ehmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292542>

On Wed, Apr 13, 2016 at 10:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Apr 13, 2016 at 4:59 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Apr 13, 2016 at 10:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +test_expect_success '--no-quiet sets quiet to 0' '
>>>> +       test-parse-options --no-quiet >output 2>output.err &&
>>>
>>> Meh, as implemented, this isn't a very interesting test, is it?
>>> 'quiet' started at 0, so all this shows is that --no-quiet didn't
>>> disturb the 0. To really test that it resets it to 0, you'd want:
>>>
>>>     test-parse-options --quiet --no-quiet >... 2>... &&
>>>
>>>> +       test_must_be_empty output.err &&
>>>> +       test_cmp expect output
>>>> +'
>>>>  test_done
>>
>> This is to test whether the 0 of quiet remains 0 if --no-quiet is
>> included. This test "defines" the current behavior. Then when I change
>> OPT_COUNTUP(), this test will ensure that this behavior is not
>> interrupted as promised by the commit message of that patch[1]. I
>> guess this also describe why I choose to include these tests between
>> 2/5 and 3/5 rather than 3/5 and 4/5. And also see the extended
>> discussion[2] for this. If I do a re-roll then I include `--quiet`
>> before `--no-quiet`
>
> Each of these patches should have a single conceptual purpose. It
> seems, from the above explanation, that you're mixing and mismatching
> bits of such changes between patches.
>
> * The two new tests for --no-verbose and --no-quiet should be together
> and check that they correctly reverse --verbose and --quiet,
> respectively.
>
> * The test you describe above which ensures that --no-quiet leaves
> 'quiet' at 0 should be bundled with the change that might break that
> behavior, namely, the OPT__COUNTUP() change.

I am planning to re-roll this.
So, I am just confirming whether I understood properly.

 * I will add the tests for check for '-q --no-quiet' instead of just
'--no-quiet' sets to 0 and '-v --no-verbose' sets to 0 in the patch
which improves test coverage which will be before the OPT_COUNTUP()
change.

 * I will then add the test for '--no-quiet' sets to 0 in the separate
patch after OPT_COUNTUP() change.

Is there something else or something different that you are suggesting?
