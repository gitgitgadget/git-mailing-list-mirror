From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5] commit: add a commit.verbose config variable
Date: Tue, 15 Mar 2016 00:39:40 +0530
Message-ID: <CAFZEwPP_SZsk+B+1L93snQji=wg728P3Oq94oVJ+ZJkhmdC9Yw@mail.gmail.com>
References: <01020153698edabd-73daa5db-3c3e-417b-8d83-6cbc04439d95-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+8+saxsGzV=-C2w-eSaaOf0MYC=zTQbH3CW2G5UE5uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afXsB-00052n-8l
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 20:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbcCNTJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 15:09:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36408 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbcCNTJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 15:09:42 -0400
Received: by mail-yw0-f194.google.com with SMTP id p65so12658774ywb.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nsic3nsbp6LtvfHTPypCr4A7pQCbv7CFuyRos/H5Ap8=;
        b=npwekLl2/jIw6Sb0WgYfPNcMV1srroPONaHq26FxgAmYANpLIvPY2V/kqcmVjxBpju
         s68FGrhn8MSB65eY1PYlFvE8LVfYPmr8Ug+3YcZJF/nyHqlIxbjcLqunwB/RylhOiLmv
         4BUJ+vJUmFA7WCdCcWoeLAHY4tVEuvhom4S3JTXjQpHKG5VNAfVVz5Ti6yaQKCav2YkB
         U7AQEY4TE6zyI2oNQPmztCNcg6kY6KTUbMn7BIlA0fjCjqTQWit6eepQD9rN8LLfweaj
         lUYIgCBITaqY00cMUj/4Fs/5bBICnQTy/vGRBQpd6giBo2TO/EhAliiC86yPRNgIvcsN
         bZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nsic3nsbp6LtvfHTPypCr4A7pQCbv7CFuyRos/H5Ap8=;
        b=NGjYu5y9VVs7Ot2D2O29tr95Gu1SEERc8LLUZ1IE6srGsWTj5lWAamjsoMwM8zCyCo
         gSwyS48Sccz3iLtHV9jjPNLsbZpd3YmXcYIrU6ZCTF7wI7xy9HsccXeNRj2wvKel5Gyp
         UWlp29wzak4TVphNWC46qIb+Kg1hqXuxzp4umXr9OkWfS3VmUicUnnh3SptiFNFWg5Pg
         GaXAxyP+UnE+X7j5HYavYj8ctHgdEeDPco41909ARFFxbBNsu0YK1N3fKWxETD+WbaAx
         pqOAQPt1CXnG92j/Q4Pqe+939ZyM5N6hMeDazCXzd0O9cgh78F5SJ4VLvhwcarR74bCY
         iKbw==
X-Gm-Message-State: AD7BkJJMUFv0BUO9nXKIB1wfTeX9QMVqC0Ylt7w1kSTSsWuzvvHc8Jiv0INV0RztsAx314pNAFeAYWpwVeojSA==
X-Received: by 10.129.37.3 with SMTP id l3mr12939520ywl.128.1457982580870;
 Mon, 14 Mar 2016 12:09:40 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 14 Mar 2016 12:09:40 -0700 (PDT)
In-Reply-To: <CAPig+cQ+8+saxsGzV=-C2w-eSaaOf0MYC=zTQbH3CW2G5UE5uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288802>

On Mon, Mar 14, 2016 at 1:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 12, 2016 at 1:41 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Add commit.verbose configuration variable as a convenience for those
>> who always prefer --verbose.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> Mentored-by: Eric Sunshine <sunshine@sunshineco.com>

> More typical would be to say Helped-by: rather than Mentored-by:.
>
> Also, place your sign-off last.

Sure!

> This is a bogus regular expression; some greps may barf on it
> outright, while others will treat "*" as a literal. Either way, it
> could never match "diff --git" so the test would succeed by accident
> even if git-status did erroneously respect "commit.verbose".

I was unaware about this. Thanks for pointing it out

> I realize that it's possible to (mis)read Junio's recommendation[1]
> about also testing git-status as a hint to combine the git-commit and
> git-status checks into a single test, but that's not what was
> intended. These are conceptually distinct checks, thus they should
> each have a separate test. I'd suggest restoring the
> "commit.verbose=true and --verbose omitted" test as it was shown in
> [2], and then adding a new test in this script for git-status which
> looks something like this:
>
>     test_expect_success 'status ignores commit.verbose=true' '
>         git status >actual &&
>         ! grep "^diff --git" actual
>     '

I misread Junio's recommendation. Will change this.

> Not at all mandatory, but it wouldn't hurt to add a couple additional tests:
>
> * commit.verbose=true and --verbose
> * commit.verbose=false and --no-verbose

I was thinking of putting these tests as when I was debugging (simply
by printing verbose variable), I found that when commit.verbose=true
and --verbose the value of the variable `verbose` is 2. But then I
thought it wouldn't be that useful. But since you have pointed it out
now, I will definitely include them.

Regards,
Pranit Bauva
