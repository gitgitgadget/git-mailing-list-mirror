From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Tue, 5 Apr 2016 21:09:57 +0530
Message-ID: <CAFZEwPORAer3=WmUqqhztv4kAOHdv+yB12tRyUYh_YTSmtcQsQ@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
	<CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	jrnieder@gmail.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 17:40:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anT5I-00010f-81
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 17:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbcDEPj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 11:39:59 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33825 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823AbcDEPj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 11:39:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id f6so2397917ywa.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Kx3ny2SC494uw7NQP4qI30gGZzyXi7Q4f/8z9LY5+3U=;
        b=Mfsdf3amsQmZKgLtPg8YWGckvOdO+8MaUP//8Ai6jcpXWMA/r/BuRiHUZ8uQJ3qDSb
         5aQxUquENDQrme5e852zP1phKJxj26XGXrLzbbKxWxmoFMdw+u8Ug5w5Th+I8WhTbb9A
         EIVpaeQAq6U/ea+OVcCSt1zZZjfURDIAPl3noOZYcRIDAsdT5YxmdAYTM4LEeWFH6v9m
         JXFGd7l8Ohp7qAqJ7L8B5KGhD8npzGaS2zeJ84gROCT+adFcPFu9TX8h03/85LAFBXEg
         RNXIGgrWJ4vxFJpQZiQBxq1lTz4/jlZKp7/YvzkS5l4mw3F5RNZtmtbrzQANgveUpvbG
         rMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Kx3ny2SC494uw7NQP4qI30gGZzyXi7Q4f/8z9LY5+3U=;
        b=Cff19HH9I+gv8rJokP2qgxfPVP04CdOWtIV27IfmjeHtQ0Fzy9LMT01+YBTs0KVII2
         M0YIzhRiE1L0Ci2FQQjmLeg0wPPv3O9UQHDkPIq3vbk7yAYaSRzArZF5JskK+YLwD2kI
         /yXvr5chBlU5CYdC8nyzmgl50PtT5bFI9cA7HyEz90cz2JdC9r7Ugj+05e06+2ZNbBSt
         sbQ1pInypYLiLwDEN9lsjxbjqbM68yAjJTKBn8qcA38fmOxI4qeQUCi5ZY17BJJSYBxc
         FXT8zAX5L+nsA8i2keXAjF7QR9ZDU7CkT2MB3A4Ce+mQCkD+k+r+lW7mjDh4wdliyBKU
         R8Ew==
X-Gm-Message-State: AD7BkJImuLZ6BSzAxJgc87Iw20UbEAUQNlJjVXsi3l7fDEHumbg67naicdBjyTzL9krge4/Kq2TUCdGlyZapcQ==
X-Received: by 10.129.155.137 with SMTP id s131mr7693600ywg.24.1459870797555;
 Tue, 05 Apr 2016 08:39:57 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 5 Apr 2016 08:39:57 -0700 (PDT)
In-Reply-To: <CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290785>

[+cc:Duy Nguyen, Jonathan Nieder]

On Mon, Apr 4, 2016 at 3:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>> and not boolean and thus it is more appropriate to print it as integer
>> to avoid confusion.
>
> I can buy this line of reasoning, however, it would be even easier to
> sell the change if you cited an existing client (a git command) which
> actually respects multiple quiet levels. Are there any?

I investigated into this. But I was unable to find any git commit
which actually respects mulitple quiet levels. I first did a 'git grep
OPT__QUIET' to find the commands which use this. Then I went through
the documentation which covers it. None of them have any such mention
of multiple quiet levels. But still I dug further and and went through
all the individual source files. I followed the corresponding C source
code for the header file included and also searched there for any
trace of quiet. But I still didn't find any such use of multiple quiet
levels. I have found that the commit id 212c0a6f (Duy Ngyuyen; 7 Dec,
2013; parse-options: remove OPT__BOOLEAN). Maybe he has something to
say as to why this was introduced and OPT__QUIET which previously used
OPT__BOOLEAN, now uses OPT_COUNTUP rather than OPT_BOOL. This commit
In fact git-repack command has quiet but this is not mentioned in the
documentation. If someone could include this it in the documentation.
I would do it but I am not quite familiar with git-repack and haven't
really used it anytime.

> More importantly, though, this change implies that you should also add
> tests to ensure that the quiet level is indeed incremented with each
> --quiet, just as "-vv" and "--verbose --verbose" are already tested.
> You might be able to include such new tests directly in this patch as
> long as the commit message is clear about it, or add them in a
> separate patch.

I will include the tests for multiple level of quiet in the patch.

> By the way, I don't see any tests to ensure that --no-verbose and
> --no-quiet reset those respective values to 0. A separate patch which
> adds such tests would be nice (unless such tests already exist and I
> merely missed them).
There are no tests to ensure that --no-verbose and --no-quiet reset
those respective values to 0 just before this patch. But I have
covered the --no-verbose tests in the upcoming patch 3/5. I will
include the tests for --no-quiet in this patch.
