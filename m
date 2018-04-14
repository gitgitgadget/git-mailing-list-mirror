Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAF81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeDNQjK (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 12:39:10 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:42335 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeDNQjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 12:39:10 -0400
Received: by mail-lf0-f46.google.com with SMTP id q9-v6so16512879lfk.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EPlqBUKNPN3U4nGphPTI7NP0L0h5sr8yZwz0ovyFmOI=;
        b=lF+gRV4pl70EAWz4IA9d7RdLBOy4KWFeh48SVvNX0jcYVFfWKK67KyJBKeG2dtCepv
         fiuoW6x3US9FOWPx9NWdmDgsqobZ58NxE7iEcnm+cx+KrwNrNrEvKGlVpDeypMjyo0wh
         FMqsshl4IPe3B+nWSAfeTQikmyewFS7mACStsv11tFwzM2cxxF8EMVs5AYLhKq2gmvPn
         KL/FHjuw+0YGLGWWGVBuq86Wf+bbjETRv2YodMXWDtOguJs+6+0/wgBl2eOm1I2nhk52
         NBvcMRMV+eELkh7V5cwnC0etaRVetzNcraE9oG5RhG/dxF15nkVPUcUOHGi+GDfLfFZP
         kJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EPlqBUKNPN3U4nGphPTI7NP0L0h5sr8yZwz0ovyFmOI=;
        b=ihq4ZE4gsV2/f6DFughkEUcwiZgWkhBCVl+MmPHtkuncI6QwrVS3lFM8HUsy0U8d7h
         v+id6ODSJOnn71zktXwi1TH3QKNt8qQYNjeyMc3xGe0lB/u5XCrokUns40nM88P3tTrO
         qFInxl4wZWjarNUatZFVbRae9Tw9saeeLZIs2VhltA3JNREZh1Wx+42LVAUSWIxsens8
         5vfBvgSWRtEfkv1/79FOBOqsvWEGu2cLmO558X8vHAG41qX5ycqTM38b6joLkLLCOKDS
         TPSgQZvH/8Hn89CVCxa/JMILkWG+ney/J5u/2O3/cMi5EuqrjZcuh4TgMNxU4VLs151v
         CDTA==
X-Gm-Message-State: ALQs6tC1Qk9KJ5OFRMGL9bz/JIoH0GskN99LoFw20ISzLkd2MSz5yVIW
        8FTv6m5U7fJzji82UarkwAlwZBp8DdPIiscO0CWPGw==
X-Google-Smtp-Source: AIpwx48oX2atATAZN6ba8r+z2xSgFqnhkigIJGAYozXaCtzE291I4/lGneZX47zf6yeS0EijDMWxlKUUQVmaE1FhqeM=
X-Received: by 10.46.152.143 with SMTP id b15mr6048125ljj.65.1523723948414;
 Sat, 14 Apr 2018 09:39:08 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.65.201 with HTTP; Sat, 14 Apr 2018 09:39:07 -0700 (PDT)
In-Reply-To: <3152c739-5c80-99b3-ac16-31fe348b7657@kdbg.org>
References: <CAHd499C39sBTJy_AoCJxE2ZS4ECJju2jroY6_0E1MssCBtmC=A@mail.gmail.com>
 <3152c739-5c80-99b3-ac16-31fe348b7657@kdbg.org>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sat, 14 Apr 2018 11:39:07 -0500
X-Google-Sender-Auth: stzz1fx94OTAOp6D0mmSVlGStPI
Message-ID: <CAHd499ApQV-juNU4tZ7XgDx3y4hi8u2-dwwa=eytFxrwVaHRmA@mail.gmail.com>
Subject: Re: Need help debugging issue in git
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 1:53 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.04.2018 um 02:36 schrieb Robert Dailey:
>>
>> I'm struggling with a bug that I found introduced in git v2.13.2. The
>> bug was not reproducible in v2.13.1. The issue is that using arguments
>> like "@{-1}" to aliases causes those curly braces to be removed, so
>> once the command is executed after alias processing the argument looks
>> like "@-1". This breaks any aliases you have that wrap `git log` and
>> such. I originally opened the bug on the Git for Windows project
>> (since I use Git mostly on Windows):
>>
>> https://github.com/git-for-windows/git/issues/1220
>
> ...
>>
>> Here is the alias being used for a test:
>>
>> [alias]
>>      lgtest = !git log --oneline \"$@\"
>>
>> And here is the command I invoke for the test:
>>
>> $ git lgtest @{-1}
>>
>> I should get logs for the previously-checked-out branch.
>>
>> When `prepare_shell_cmd()` is called in run-command.c, it gets expanded
>> like so:
>>
>> + [0] "sh" const char *
>> + [1] "-c" const char *
>> + [2] "git log --oneline \"$@\" \"$@\"" const char *
>> + [3] "git log --oneline \"$@\"" const char *
>> + [4] "@{-1}" const char *
>>
>> With my modifications (again, patch inline below) I get this:
>>
>> + [0] "sh" const char *
>> + [1] "-c" const char *
>> + [2] "git log --oneline \"$@\"" const char *
>> + [3] "@{-1}" const char *
>>
>> The second version looks much better.
>
>
> But this is wrong. Try this on the command line:
>
>   sh -c 'echo "$@"' a b c
>
> Notice how this prints only 'b c', not 'a b c'. The reason is that the
> argument 'a' is treated like a "script" name, i.e. what you get for "$0",
> and 'b' and 'c' as the actual arguments to the "script".
>
> That is, you must fill in some dummy "script" name at slot [3], and
> run_command chooses to put the alias text there.
>
>> I think the constant nesting of
>> commands inside each other that the first version does is somehow
>> causing curly braces to be removed. I don't understand enough about
>> shell processing to know why it would do this.
>
>
> Some shells expand the curly braces. They must get lost somewhere by one of
> the two shell invocations that happen on the way.
>
> BTW, you don't happen to have a file named '@-1' in your directory, most
> likely by accident?

Thanks for your help. I checked for @-1 but I do not have a file with
that name (good catch though). I contacted the MinGW mailing list and
they seem to indicate that {-1} is a valid brace expansion. I was able
to verify the git.exe code itself is not causing this problem. It
seems to be GNU bash doing it. But oddly enough, the Ubuntu version of
Bash for example does not process {-1} as a brace expansion. It seems
weird to me that Git uses a syntax for a portion of its revision
specification that could be ambiguously treated as syntax processed by
Bash. In other words, I feel like this would have been designed into
Git years ago, so I'm not sure why this is a problem now all of a
sudden.

Their suggested solution was to start quoting items in the list or
escaping the braces, but that will make git revisions less intuitive
to use and make commands more tedious to type. I am still discussing
things over there but for the purposes of the Git mailing list, I
think it's clear at this point this is not an issue with Git itself.
Having said that, thanks again for the help!!
