From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v12 1/5] t0040-test-parse-options.sh: fix style issues
Date: Mon, 4 Apr 2016 18:15:12 +0530
Message-ID: <CAFZEwPNaxFyFmCkvPjRZQ0grOm1oWB1+5QhkpOMyEKW7j_99qQ@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+89MZSyHJhCrZsGMc7mM_uorE5j9GXk7kCTT1OTXV6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 14:45:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an3sd-0004sD-ND
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 14:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbcDDMpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 08:45:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32799 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbcDDMpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 08:45:13 -0400
Received: by mail-yw0-f196.google.com with SMTP id o63so29755297ywe.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u7X2Wb0i3QqvHQ7yNevuCSzHMl48/Mlh69m8oNlDI1c=;
        b=pHakATzkvlPykltVJDdWqicVWSYJVIKpEFrbFPKNKkh0GlZAfcVF6jOYiAztjD2/XB
         5CdFg3fd/E6qLMAytzU4cs9/wvolJpwgIt0cBmFqaIU4RDet6kjoTALfu1zk+CiRYyCU
         JwN0FVY9RHJiX3YkH9/h6kWY6slTHtCjMA1gPgtEs5tD++iJ07T3sDZSlAN5Ozp+rm0A
         0i/JIhfXJ9f3uTZNGWx4QbxTH7WHC9kg3Nqwu4uuKMo3wl50F/zOQ4vnBJNMjNLL7Ie6
         o0WS7EMwExrtp6bgL4Hx7yhKweOfvYzuQUU8geE7eYeXxodcHLGn5plj6l0RZJzVobtM
         YEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u7X2Wb0i3QqvHQ7yNevuCSzHMl48/Mlh69m8oNlDI1c=;
        b=iZETtn4RWSndIDKgX7bZZT1OtOfjzOWygeCfjGP1SOcXz7ieiHiLyJ6LAsieTZ+GL6
         WxYcaIAwWz6/pfcXtAY/AG8Mu7GGU8DvSaNi2QJTB7RV+2Miw/qfFijk3iIA1YW00/j9
         LsAgenZJWQfs++v+MKroHfrvGeLwhvK179bjNpn7vEHCZePaK+aa8ia+/tpoEZqFonfb
         gLgQTYqX50T8Pb7PZ0s8+OYqI27Pyv75ve4pUYpJl6Ftm7TMYZB7nSBghHh1rSfTK8bB
         ru/cp6Q+p7rzT1BIV7i0YpwJcFTWQw9S5vLj7D4WIotOs4Gg21wQDFZiWmZtBj4XNaQ6
         2sBg==
X-Gm-Message-State: AD7BkJI22MToIZUa5OjiSwVVOqHYCA7rmKcdlP0OD3XDTv2zw/EcmyIkJTTTNAp3X7lkjRneXYkI4dciKwTbDw==
X-Received: by 10.129.9.214 with SMTP id 205mr18199721ywj.53.1459773912236;
 Mon, 04 Apr 2016 05:45:12 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Mon, 4 Apr 2016 05:45:12 -0700 (PDT)
In-Reply-To: <CAPig+cQ+89MZSyHJhCrZsGMc7mM_uorE5j9GXk7kCTT1OTXV6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290688>

On Mon, Apr 4, 2016 at 2:30 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> @@ -7,7 +7,7 @@ test_description='our own option parser'
>>
>>  . ./test-lib.sh
>>
>> -cat > expect << EOF
>> +cat >expect <<EOF
>>  usage: test-parse-options <options>
>>      --yes                 get a boolean
>
> It would be better to use <<\EOF for this one to make it clear that no
> interpolation is desired in the heredoc.
>
>> @@ -156,7 +156,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
>>         check magnitude: 3221225472 -m 3g
>>  '
>>
>> -cat > expect << EOF
>> +cat >expect <<EOF
>
> Ditto: <<\EOF
>
> Same applies to all similar heredocs in subsequent tests where
> interpolation is not desired.
>
>>  boolean: 2
>>  integer: 1729
>>  magnitude: 16384
>> @@ -310,12 +310,12 @@ arg 00: --quux
>>  EOF
>>
>>  test_expect_success 'keep some options as arguments' '
>> -       test-parse-options --quux > output 2> output.err &&
>> +       test-parse-options --quux >output 2>output.err &&
>>         test_must_be_empty output.err &&
>> -        test_cmp expect output
>> +       test_cmp expect output
>
> Okay, this is a whitespace change (spaces -> tab).
>
>>  '
>> @@ -460,7 +460,7 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
>> -cat >>expect <<'EOF'
>> +cat >>expect <<EOF
>
> This is not a desirable change. This heredoc does not require
> interpolation, so you don't want to turn it into a form which does
> interpolate. For style consistency, therefore, you should change 'EOF'
> to \EOF.
>
>>  list: foo
>>  list: bar
>>  list: baz

Okay I will do the change. I was previously unaware about the use of
'\' before EOF. I googled it now. But I am still confused about its
use in this scenario. Upto what I understood, it is used where you
want to expand a variable, substitute a command, arithmethic
expansion. The use of '\' in the tests I have changed in v12 wrt 11 is
understood by me as you want to remove the use of escape sequences
which is justified. But this seems a bit vague. Is it some convention
in git?
