From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 3/3] commit: add a commit.verbose config variable
Date: Thu, 24 Mar 2016 15:56:56 +0530
Message-ID: <CAFZEwPNyELB2BZ1q95HroV0a3vfNK0eTtzcy-2aEmUY5QVZe-g@mail.gmail.com>
References: <01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
	<1458813876-10591-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPN2+RwrE583XHOv9=05XQaWZnL=cK6wa0rMC-3AU275yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:27:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj2Tl-0002nK-Os
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbcCXK07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 06:26:59 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34666 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbcCXK05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 06:26:57 -0400
Received: by mail-yw0-f194.google.com with SMTP id f6so4914935ywa.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=33AZeGZppblqbH8d0hTHPx1KHkGQ4zQysiY5HrqNSBU=;
        b=xso1MxuVYH5rXpj1P0oH29X96jZooMC94CW0xhzfZXHYY7pra0E0m6RELV/r42WBYF
         liURZ7JKSZjO78AqTs128bketT+0ltFCuaOrau39zUw8a8rUjJLj1qiQY3CyhwgWMAyK
         22Zs9NDSGV8whiL9M6J0TXCEb7yy7NaBMDpo84IDBFIjGO+Me+3H3+tMEM3iOQXj32Pl
         ywXSevTYOJwxcwBKdyQ0nWSIY0XdAfnsa2sGlrX8oySzCDXoBLjlC+eap8nwHpuZJfAr
         GwLfuCG8PNDO7IaUWJZBhtkAT7UPhmXDetdFYiGHMg8YclZoms6zf3S/ritYOcZWAiPe
         GgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=33AZeGZppblqbH8d0hTHPx1KHkGQ4zQysiY5HrqNSBU=;
        b=bno0hKQKvZZx0QiGksiThibiOpd/E6NjdSGG3eFKSZHU3G3aU3GYiJ92o6neMRkVnk
         bTzWvyBJJoONN3jitAV73YptfVjAreVzSebE4AcSKKU1i+Lf9PO1YCcR+EbEF18mcNM5
         hgm7sdEzkJ4zAk6ZAAEa+As9r1G/NsU4xucf964CSZOCZnboBRocSoCSOUp5Ifrk1EgY
         fre42IASDNYXpD1z6jCK5ah6SKxOFifmwx/Q/kMfClIr5hIZqe7gP7NdyJwodgicPSr4
         N2+lPugS7ytZYVrsPGBh5MxQiq16OVv2SriApPwtPhETyvlC7ifXEuEg6YhddoLrkXbi
         keNA==
X-Gm-Message-State: AD7BkJKLNVYXSkCQ+wcbdVVLWBUJXENQYjdCUzJYqfhVDXoIHnZeSrG63TEmp4mzUTAkFOQR/rfCGPwJsvLJOA==
X-Received: by 10.129.9.214 with SMTP id 205mr3622728ywj.53.1458815216602;
 Thu, 24 Mar 2016 03:26:56 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 03:26:56 -0700 (PDT)
In-Reply-To: <CAFZEwPN2+RwrE583XHOv9=05XQaWZnL=cK6wa0rMC-3AU275yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289732>

I got it. The verbose is initialised to -1 before. When cmd_commit
runs, it changes the value of verbose accordingly to 0 or positive.
But when cmd_status runs, it will retain the value -1 and the if
clause which accepts all values except 0 will execute. I guess a if
statement inside cmd_status which reinitialises it to 0 or positive
depending on the situation will solve the problem.

On Thu, Mar 24, 2016 at 3:52 PM, Pranit Bauva <pranit.bauva@gmail.com> =
wrote:
> On Thu, Mar 24, 2016 at 3:34 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> Add commit.verbose configuration variable as a convenience for thos=
e
>>> who always prefer --verbose.
>>>
>>> Helped-by: Junio C Hamano <gitster@pobox.com>
>>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>>
>>> ---
>>> The previous version of the patch are:
>>>  - [v8] $gmane/288820
>>>  - [v7] $gmane/288820
>>>  - [v6] $gmane/288728
>>>  - [v5] $gmane/288728
>>>  - [v4] $gmane/288652
>>>  - [v3] $gmane/288634
>>>  - [v2] $gmane/288569
>>>  - [v1] $gmane/287540
>>>
>>> Changes with respect to the previous patch:
>>>  - Compare with -1 as only -1 value is used for unspecified behavio=
r.
>>>  - Write clean tests
>>> ---
>>>  Documentation/config.txt     |  4 ++++
>>>  Documentation/git-commit.txt |  3 ++-
>>>  builtin/commit.c             | 13 ++++++++++-
>>>  t/t7507-commit-verbose.sh    | 51 ++++++++++++++++++++++++++++++++=
++++++++++++
>>>  4 files changed, 69 insertions(+), 2 deletions(-)
>>
>> Please always run the full test suite before submitting patches to
>> make sure that your changes do not inadvertently break something.
>> This patch breaks several tests in t7512-status-help.sh,
>> t7508-status.sh and t7060-wtstatus.sh.
>
> Sorry for that. I will make sure I do run the complete test suite. I
> currently ran only commit based tests. But now that I think about it
> that since status and commit share a lot of things, it might be
> possible to break parts of status. I will investigate further as to
> what cased this problem though I kind of get a hint that it is becaus=
e
> of verbose being the parent and others consuming it. There are a lot
> of tests failing.
