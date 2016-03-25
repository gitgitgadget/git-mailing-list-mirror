From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 12:25:04 +0530
Message-ID: <CAFZEwPPXPL=d2S+Htc+uFyrUfrWLZRk=7YFDevHNpuEB5ofVDQ@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<CAFZEwPNMB2Ti2d=qdZKyoYzneHxUPATiFWd_fSPxktZuF3Q+pw@mail.gmail.com>
	<CAPig+cRY8P2WtqR4y0zW+netCHa3=9Wnb8LmcB35SqP4OGC6Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:55:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLeK-00084Y-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbcCYGzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:55:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36494 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcCYGzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:55:06 -0400
Received: by mail-yw0-f196.google.com with SMTP id p65so8040316ywb.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TdWZyYtpUxtgORU+L9ZZPi1TslB2LM8ToGsQAOxve8Y=;
        b=uKmg+rCnFqmlC4mMgASq69DVdzpO5dFIKK6JsWgC32SWO3QTxqbqnJeOYg4/pl7g8+
         cWTjUP11Ovw8FsTvuVZHgaB+GCmWUXz7nx+jE2Tk73eWrAx1bcH6q75+dSrtrCeobMM8
         3Hl5j6acR9rcqgByPnhyvvVLQ081k7J3GyYrFgCrKVbzkCUU9jZxw59HAkLYMvM2l1GY
         aDCIOFvzeo7I5XgI2PKIVXbJlA+EJw6NOxbiFElQqlHvm5Ew0yLPFzCIW8yFx/cILgig
         Uov+X2Jn2okSrp//HkafdvGNZKW7v0QJQ30AsiqiWB0ypOBgwCYAmCS8816jxWgaRgBH
         JmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TdWZyYtpUxtgORU+L9ZZPi1TslB2LM8ToGsQAOxve8Y=;
        b=GmM1YJ8jqf83pSjyOLI/8sd17Z2HG0LCN13fs6Pe3e/oHw0rkfXSDq/SY7BLq2JMcF
         tKLEaE7xwrTgjRU8xOKPD9Mk9io4IV3VQvm+h74cL7tPWc2qJuUSY3xbKApf/MuolcEO
         a1Q2UWacwsTwLEEFqAlQZVxc7YE0OwTuWzdoMJrByaUimxsFueEEqLI19PQejyxW+RbB
         W1CG+zlammGjB1ck0F91pSae7OsYVEjfHGhGYYoMgr1VH/gKFl1TH3VR3U3fKRMt4xfJ
         LIGSzvWQpTuwDu9O2cFYiHQNMZww/q95swhcPHzprtQu7i70uyIcSqWelUWkgjzIYebp
         hWlQ==
X-Gm-Message-State: AD7BkJK3ikCDW1jFeY/H6yYE8Wl8aRRioPj+yLlurIRpN+BWiy+tfSMFbMkxkIWR5+XpkGxkBbNxeL3duuS1fQ==
X-Received: by 10.129.9.214 with SMTP id 205mr6382292ywj.53.1458888904945;
 Thu, 24 Mar 2016 23:55:04 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 23:55:04 -0700 (PDT)
In-Reply-To: <CAPig+cRY8P2WtqR4y0zW+netCHa3=9Wnb8LmcB35SqP4OGC6Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289855>

On Fri, Mar 25, 2016 at 11:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 25, 2016 at 2:06 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Fri, Mar 25, 2016 at 5:27 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Agreed that this needs proper justification in the commit message.
>>> And, the justification is to make each test more self-contained,
>>> particularly because a subsequent patch will introduce a second fake
>>> "editor", and by making tests responsible for setting the editor they
>>> need, they don't have to worry about bad interactions from "editors"
>>> set by earlier tests[1][2].
>>
>> This shou  cadve  mbe ave be ave be ave be ave be ave be ave be ave
>
> Hmm, yes, what you say makes perfect sense... er, wait...

haha :) Sorry for this. My browser crashed and it sent out some crap
(don't know how). I mean to say, "This should have been mentioned in
the commit message that scope of editor is reduced so as to not worry
about bad interactions from other "editors" which may be used after
wards."
>
>>>>> -cat >check-for-diff <<EOF
>>>>> -#!$SHELL_PATH
>>>>> -exec grep '^diff --git' "\$1"
>>>>> +write_script "check-for-diff" <<-\EOF &&
>>>>> +grep '^diff --git' "$1" >out &&
>>>>> +test $(wc -l <out) = 1
>>>>
>>>> Our test lib offers the test_line_count helper function, which
>>>> outputs a helpful error message in case the number of lines do not
>>>> match.
>>>
>>> test_line_count() was mentioned in [2], however, this line counting is
>>> done in the fake "editor" script, not in the test script proper, so
>>> the spelled-out form $(wc ...) was proposed[2].
>>
>> I have a slight doubt regarding this. Can the functions from test-lib
>> work in such scripts flawlessly? If yes, then its probably better to
>> use them.
>
> Probably not easily, and it's not worth complicating the "editor"
> script by trying to import the test_line_count() function.

Sure!

>>>>>  chmod +x check-for-diff
>>>
>>> Drop the 'chmod' line; write_script() does this for you.
>>
>> I was unaware about this. I will drop it off.
>
> I thought I had mentioned it in the review in which I had suggested
> using write_script() or one of the follow-up emails, but upon looking
> back at those messages, I saw it was not so. It turns out that I was
> probably thinking about a different patch review in which I had
> mentioned dropping 'chmod'[1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/288085/
Oh! I hadn't tested by removing chmod. I will try it for fun.
