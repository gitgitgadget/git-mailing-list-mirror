From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v15 3/7] t0040-parse-options: improve test coverage
Date: Thu, 5 May 2016 10:16:03 +0530
Message-ID: <CAFZEwPN84Qr2z4M7DQFWda3JO7Ut-4FWO5G8+ExwSobwcyM6Fw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cTW9=w8fMTwcF-Z6DPmXMM4qiWZA=7S1GcFEoGG8hPUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 05 06:46:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayBAx-0006IK-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 06:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbcEEEqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 00:46:06 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33105 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcEEEqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 00:46:05 -0400
Received: by mail-yw0-f169.google.com with SMTP id t10so128887699ywa.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 21:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=VPDLGWxFcV4IH8vd4gWH4FPwKiWodf5Egh/e0LgJvUQ=;
        b=yAAXFrmrPEIz5h8Xsy++b7WoD8nCgYaiCejxj2mEcvTkTyQ9BoRXqs9ApzljqoaxO3
         q8Puvu6sOopldYt8Mkn91PLLq1uyCwocDNgi+wp3LDjeqxsC743B4ynpHgsnIzFzR9Lk
         MSyDtan8QJlffRSRYyJIBwZY06pPgf0az35PmwgsG2pD5t/RgVgEplR86VTs+MkozI+Y
         eJn+8ES7+DscNu8lTK0A20g2J7Hksj9IhPR/5b/ep9kPQZitae//X1kERMi3BnyPc4bl
         HWls95F3ytGgMDxMa79H2d/3zKA2DqEGWEoYdRuMILN4vltLGR3ccbQOJKNjMq+/NwWy
         Tnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VPDLGWxFcV4IH8vd4gWH4FPwKiWodf5Egh/e0LgJvUQ=;
        b=Q/v/18l5OHVCS6yrMnnwKnCG/vgytefDn7gpUyBHQgxIBd/SLDTZhzOaEHe/2IkB04
         dHiVIuEPl/wmdotUcfUuseM4DL2fKq5j3V0ZOZvD2qEdyDfITBtP4sGTZBszTvm6asOV
         q8nUbHHQj6jTMdO5Ut3d9LRzuM6+hADxh9dtMUekC3/fQosh4uDrxuHPsLb780zs7UW8
         H8FNmSA7u2K6KcQg6zp5h6otSt8WZuOlLkNMZYCv2C8WrPHT+bOvSZCjUyNyy0ZP1mrw
         NDB7LgC7PgKIFAiTfc3LF9r+XjN47z2glIhCszTyxHaCiYBJrElB2dVRz9VTTAjPF6c4
         qG+A==
X-Gm-Message-State: AOPr4FUFEPxBhbl6Y+v/zNYUYBAIVVof0X0xxOKkEC5MmXZFUCwSobv+m3//w1ZJUDtPs0HuYLPKfE50xFiyYg==
X-Received: by 10.13.221.212 with SMTP id g203mr7309978ywe.68.1462423564027;
 Wed, 04 May 2016 21:46:04 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 21:46:03 -0700 (PDT)
In-Reply-To: <CAPig+cTW9=w8fMTwcF-Z6DPmXMM4qiWZA=7S1GcFEoGG8hPUtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293632>

On Wed, May 4, 2016 at 2:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 30, 2016 at 4:03 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Include tests to check for multiple levels of quiet and to check if the
>> '--no-quiet' option sets it to 0.
>
> As this patch is also adding a test of --[no-]verbose, the commit
> message should mention it.

Will include this in commit message.

>
> More below...
>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> @@ -476,4 +476,61 @@ test_expect_success '--no-list resets list' '
>> +test_expect_success 'multiple quiet levels' '
>> +       test-parse-options -q -q -q >output 2>output.err &&
>> +       test_must_be_empty output.err &&
>> +       test_cmp expect output
>> +'
>> +
>> +test_expect_success '--no-quiet sets quiet to 0' '
>> +       test-parse-options -q -q -q --no-quiet >output 2>output.err &&
>> +       test_must_be_empty output.err &&
>> +       test_cmp expect output
>> +'
>
> It wouldn't hurt to have two tests for --no-quiet: one which tests
> --no-quiet alone to ensure that 'quiet' *remains* at 0, and one which
> tests --no-quiet in combination with some --quiet's to ensure that
> 'quiet' is *reset* to 0. These tests would give you good coverage for
> changes by subsequent patches, such as the OPTION_COUNTUP patch which
> flips the initial value to -1.

Will add them

>> +
>> +test_expect_success '--no-verbose sets verbose to 0' '
>> +       test-parse-options --no-verbose >output 2> output.err &&
>> +       test_must_be_empty output.err &&
>> +       test_cmp expect output
>> +'
>
> One would expect to see 'verbose' get the same treatment of having a
> test invoke --verbose multiple times. (Yes, I realize that the "long
> options" test does just this, but testing multiple --verbose's is not
> its primary purpose, so having a test which does test multiple
> --verbose's as its primary purpose can be beneficial and is less
> likely to be broken by someone in the future.)

Sure. Having another test dedicated wouldn't hurt.
