From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Wed, 13 Apr 2016 14:29:48 +0530
Message-ID: <CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
	<CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 10:59:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqGeV-0006yv-5E
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 10:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759443AbcDMI7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 04:59:53 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34099 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759477AbcDMI7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 04:59:49 -0400
Received: by mail-yw0-f193.google.com with SMTP id h6so5742287ywc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DXnMEqARV/ZglIRHTON8Z8Alu7f8OtXKio6Olq80wIk=;
        b=JS7H15m0YPAS6huHObXCeszmSmeTYWLpe7OhwHxGJDiXW4YXL78hMp0hjrm8OQYnTw
         i1aGCxKfm0p+3qUYOlt8mtGArzre/AQ6XbMrdKcODxSyxnKSNfVJR3zye2cTdqGTj7G3
         LV7wYVV1XARErNANqDB3mhpaPCe5J0zO7PZIcNZ6Cv/WFoDAGHS3giSjVuiSgTZVFLQ0
         D8Ym/EpDc4eemiogFhFXZTHA8anvcTQiWTXLpkrSfCtkD7e3Z9CLAC6v1gTm1XtjjIpz
         c3uEYeffbvTjBtZkL5+nHpeq+4PwP6ClAi35p5wpQwOK1yFN+1JUwsbXXfytW0PK/lX+
         jD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DXnMEqARV/ZglIRHTON8Z8Alu7f8OtXKio6Olq80wIk=;
        b=joaRtR466lTzXCSpBU6E8JCDd5Jx61iY4z3Hxty7ZgjBkH0RrAHCHe8FEOWOBuJ1b8
         HPlLgEL7AX9LOj2mFlwA2lX6i4v0KJvF6AbrSzh21dNNqCxOpua3P7WU27ui7U6TV0AM
         ugrUcbchEdG/HtmK/uK8YUY2O+yvAGncBtM1xmNoe4uq1by9wqH2l0vypNP/h343/UH3
         fbePgD4Z/xpCbo5ZhfKpQIM+ZnQats+hIDwWW8BvTvuSOJwfz6lWNNKtnnrwLKQ6e+lp
         ebWvPgj7pwyE9V6hOWYiYHgxbeTm9P6Pgf2YZCp2rECSTYql03xwC3vGsvLO+PdNL7Gl
         /5kA==
X-Gm-Message-State: AOPr4FWk2pl8S960rMhrTmUfQDtYJ+GrS/pvvzf0Ap1sM7yf9KUtO+hd0MsMCp1mV5Vesgz7lHiuJs+LGf2Knw==
X-Received: by 10.129.134.133 with SMTP id w127mr4152652ywf.252.1460537988325;
 Wed, 13 Apr 2016 01:59:48 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Wed, 13 Apr 2016 01:59:48 -0700 (PDT)
In-Reply-To: <CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291381>

On Wed, Apr 13, 2016 at 10:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Include tests to check for multiple levels of quiet and to check if the
>> '--no-quiet' option sets it to 0.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> @@ -476,4 +476,41 @@ test_expect_success '--no-list resets list' '
>> +cat >expect <<\EOF
>> +boolean: 0
>> +integer: 0
>> +magnitude: 0
>> +timestamp: 0
>> +string: (not set)
>> +abbrev: 7
>> +verbose: 0
>> +quiet: 0
>> +dry run: no
>> +file: (not set)
>> +EOF
>> +
>> +test_expect_success '--no-quiet sets quiet to 0' '
>> +       test-parse-options --no-quiet >output 2>output.err &&
>
> Meh, as implemented, this isn't a very interesting test, is it?
> 'quiet' started at 0, so all this shows is that --no-quiet didn't
> disturb the 0. To really test that it resets it to 0, you'd want:
>
>     test-parse-options --quiet --no-quiet >... 2>... &&
>
>> +       test_must_be_empty output.err &&
>> +       test_cmp expect output
>> +'
>>  test_done

This is to test whether the 0 of quiet remains 0 if --no-quiet is
included. This test "defines" the current behavior. Then when I change
OPT_COUNTUP(), this test will ensure that this behavior is not
interrupted as promised by the commit message of that patch[1]. I
guess this also describe why I choose to include these tests between
2/5 and 3/5 rather than 3/5 and 4/5. And also see the extended
discussion[2] for this. If I do a re-roll then I include `--quiet`
before `--no-quiet`

[1]: http://article.gmane.org/gmane.comp.version-control.git/291313
