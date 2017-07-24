Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B771F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 09:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbdGXJds (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 05:33:48 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34267 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdGXJdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 05:33:47 -0400
Received: by mail-ua0-f179.google.com with SMTP id q25so55197429uah.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aKp/1kiZ2e08WVFl35pSAcocAygxc0wk4zkXy7WZo9Y=;
        b=kk6Ok+LGcwI7kw9WS7rFXROMYCT/5F6Gk6XjkvzSt/Zl6xCw5nrDrND3ARMy/SHiMl
         3tYIpbUQl4xCFLl9AlVNq5KiGgVc44G/rbmDtGzWYqqvU/tLzdUubKhXIY7RrsdD2DzK
         3H5jbwO18oHfvyzU5YriYw5YmIaQ0yElbx3OD2AW6ezkcl8nvIFafCe9Dm4+GNhhoQFe
         cyFSEYwSg68/PbdRsRRKEO5SOzS98of49zbMe72dqxN2abFd1Zx8MF3zDutVRJv9wAPe
         5N6fbtBPuuGDm1dE3aUyWrqmQzmODUxnuXLl88a2GPDLqjDdQuhC513QfBn7THmQeOT+
         u/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aKp/1kiZ2e08WVFl35pSAcocAygxc0wk4zkXy7WZo9Y=;
        b=YTVSlAg7oh96Z77RgWA+PgEi38mqI4qInNeW4uyEzrUfX9UeJ3BTzU7ro5mY+1nXjf
         xs0XK2Zc21mG/O5k3YTEb9QwiIMFFDA7l3eW8VMFfTlV9MTMEU5UWJRYGFz8uUrn/2cR
         EjfIUEsNSsICk2ipSMw4vOn7joHoUJu4b+qcI0juWpPcgt8pbTUAQG8dleRjgBH+wTv1
         988HVfVwFFCwGywqolRxMHRwzKO+F4mI53P5mbQ2hgvXExfe/4RJ0Huw3SFx1asx+93K
         S8O6p1TOWWaJghQrFAiBEsm6l/Jrmu5LxHFsXfsHfouuRXtgoajYH6xpldGkcaW7vXE4
         AcDQ==
X-Gm-Message-State: AIVw111nzlzRBXbi2gaterMRZe4HmD7eS5qI0D38r/9X6j01KcRhsWKr
        CS/iuNH1jX8fwfug7PmSqcZxYfQIPw==
X-Received: by 10.31.177.1 with SMTP id a1mr1026238vkf.70.1500888826027; Mon,
 24 Jul 2017 02:33:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.42.7 with HTTP; Mon, 24 Jul 2017 02:33:45 -0700 (PDT)
In-Reply-To: <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
 <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>
From:   John Szakmeister <john@szakmeister.net>
Date:   Mon, 24 Jul 2017 05:33:45 -0400
X-Google-Sender-Auth: zSzM8Qx4yVoxduaNQMy3sXZCeTs
Message-ID: <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>
Subject: Re: Expected behavior of "git check-ignore"...
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 23, 2017 at 12:33 PM, Philip Oakley <philipoakley@iee.org> wrote:
[snip]
>>
>>>>>>
>> git init .
>> echo 'foo/*' > .gitignore
>> echo '!foo/bar' > .gitignore
>
>
> Is this missing the >> append to get the full two line .gitignore?
> adding in a `cat .gitignore` would help check.

Yes, sorry about that.

>
>> mkdir foo
>> touch foo/bar
>
> I don't think you need these. It's the given pathnames that are checked, not
> the file system content.

It was there so you could see that `git status` ignores foo/bar
(though that wasn't part of the little script).

>> git check-ignore foo/bar
>
> Does this need the `-q` option to set the exit status?

No, it's always set.

> echo $? # to display the status.

Sure.  So, to recap the update reproduction recipe would be:

>>>>
git init .
echo 'foo/*' > .gitignore
echo '!foo/bar' >> .gitignore
mkdir foo
touch foo/bar
git status # foo/ shows as untracked because bar is present
git check-ignore foo/bar
echo $? # show the exit status
<<<<

It seems like it should print "1", but it prints "0".

>> I expect the last command to return 1 (no files are ignored), but it
>> doesn't.  The StackOverflow user had the same expectation, and imagine
>> others do as well.  OTOH, it looks like the command is really meant to
>> be a debugging tool--to show me the line in a .gitignore associated
>> with this file, if there is one.  In which case, the behavior is
>> correct but the return code description is a bit misleading (0 means
>> the file is ignored, which isn't true here).
>
>
> Maybe the logic isn't that clear? Maybe it is simply detecting if any one of
> the ignore lines is active, and doesn't reset the status for a negation?
>
> I appear to get the same response as yourself, but I haven't spent much time
> on it - I'm clearing a backlog of work at the moment.

Correct, it appears that if any line in the ignore matches, then it
exits with 0.  So it's not that it's ignored, but that there is a
matching line in an ignore file somewhere.  I can see the logic in
this if it's meant to be a debugging tools, especially combined with
-v.  Simply changing it does affect quite a few tests, but I'm not
sure that it was intentional for negation to be treated this way.

> I also tried the -v -n options, and if I swap the ignore lines around it
> still says line 2 is the one that ignores.
> It gets more interesting if two paths are given `foo/bar foo/baz`, to see
> which line picks up which pathname (and with the swapped ignore lines).
>
> Is there a test for this in the test suite?

There are several.  But line 427, test_expect_success_multi 'nested
include', is one that I think is pretty direct about testing this.  I
imagine what happened is that gitignores used to contain only things
you wanted to ignore and when the ability to negate came along the
semantics of this was never changed--and possibly for good reason.
I'm just wondering if it should change, or if the documentation should
be updated to reflect how it actually behaves (the file may not be
ignored, but a line is present in a gitignore that affects its
status).  The behavior is definitely a little unexpected as it stands,
given the documentation though.

Thanks for taking a look Philip!

-John
