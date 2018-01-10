Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503971F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755630AbeAJQC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 11:02:59 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:37729 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755597AbeAJQC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:02:57 -0500
Received: by mail-vk0-f53.google.com with SMTP id g83so3358033vki.4
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 08:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CVkcico3aQM3HtTbMH0Qk6x5AG1jtGnQ7wvcj9XWJVk=;
        b=f2whmnOMgOew8PkDJJLf/h8fBrpMSVWioPQ4+8Z8QBXc8B4R8ltLyLS/3s/f3RzmxC
         ie3hm21fKd3E7KvI52gw/0JEkzmXzSDET9IO/4fEJCRNoya+fPB1MFiChF6dvuiAQ/ZZ
         lWHru98Z6K7zzoQ8bw+ckCmyTj3X+TlvkoEvExT1kit8trK6tScmHgjoP1Z2QnS5Mvxz
         P6zAdnzHFMbg2UIA7QuMIQXVQJHAJd2j7Un30h7VFI3fLYXuvj4uXbNn7kkkj2xa96DJ
         rqPuSj44zdnCcOXzRM8C1EEiqBZRAYMFdYsKbMBdp8bCrzFPOG1H1XlDQVWXdW6MChNU
         fLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CVkcico3aQM3HtTbMH0Qk6x5AG1jtGnQ7wvcj9XWJVk=;
        b=jGDAuDuwKsZPSNrU6YD1P159pjr58ijgJhCBjWPtObu8t8EuZrsik0ITRxaChfp65f
         G+Fc0LD5aArfYfNHOVQEhYeDIIu6u0xqlYhBOjJwI6yDbtjbfkL79afINVyOM6Oxg/VY
         wPIsXnEW+tYzADzBypJoYMzT9JXceW3raHQW6nPs5fHgm2sJiNnEZAxR+6JRKSAlMowc
         t1YlOq82FRlQucQqppQ+JEWAdl+suyzGB10qaaOxNFw3dh2BBpNUWN0bGlxfN/lhe4pw
         8m9WMJjmQHHakcBbVmvC0Gk6W7F8/sun9wiX5c0TKdgDgCaW7OTvtBllnydV5FexQv+I
         4x7w==
X-Gm-Message-State: AKwxytcR76qK2cFlrY1OsrPWs83xCxq06joy8FDenc9v7d3wX0myDuzT
        9RzSY+MCq/9gNV0OLTSyYMoAvYVMnZ0L/3fF2DA=
X-Google-Smtp-Source: ACJfBot+KvW14McMt5/07oZoiLeMcaOJ5ZmlpECeMTizy6eqi/MmhDz9KqYePdKoIagtNW2nHlKYgsuCNgOaAE/KhJ8=
X-Received: by 10.31.197.65 with SMTP id v62mr17361870vkf.71.1515600176638;
 Wed, 10 Jan 2018 08:02:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.142.195 with HTTP; Wed, 10 Jan 2018 08:02:56 -0800 (PST)
In-Reply-To: <87mv1laeoe.fsf@evledraar.gmail.com>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
 <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com> <87mv1laeoe.fsf@evledraar.gmail.com>
From:   Sam Millman <sam.millman@gmail.com>
Date:   Wed, 10 Jan 2018 16:02:56 +0000
Message-ID: <CALKyTE57dfy1XFxVZR9yYc9rm6uQ+e+=PU_5gL15HdFO47abaA@mail.gmail.com>
Subject: Re: How to use multiple SSH keys on Git exe (not bash)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I actually played a bit more and got this:

Host *
IdentityFile ~/.ssh/id_rsa_d
IdentityFile ~/.ssh/id_rsa

Host bitbucket_1
User git
HostName bitbucket.org
IdentityFile ~/.ssh/id_rsa_d

Host bitbucket_2
User git
HostName bitbucket.org
IdentityFile ~/.ssh/id_rsa

And from basic testing it seems to actually work, it seems it is the
Host * that make sit work and it will actually iterate the keys and
try them.

Not sure why this is, any thoughts?

On 10 January 2018 at 15:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>
> On Wed, Jan 10 2018, Sam Millman jotted:
>
>> I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> working using git . exe, which means no GitBash.
>>
>> I can get the keys to work just fine with GitBash.
>>
>> I edited my .ssh/config to look like (I know this is incorrect):
>>
>> Host bitucket . org
>> IdentityFile ~/.ssh/id_rsa1
>>
>> Host bitbucket . org
>> IdentityFile ~/.ssh/id_rsa
>>
>>
>> And id_rsa1 works, I can actually pick from the other repo. But, of
>> course, id_rsa does not now.
>>
>> I change to:
>>
>> Host bitucket . org-dd
>> HostName bitbucket . org
>> IdentityFile ~/.ssh/id_rsa1
>>
>> Host bitbucket . org-sas
>> HostName bitbucket . org
>> IdentityFile ~/.ssh/id_rsa
>>
>> And now only id_rsa works.
>>
>> I also tried combining the two IdentityFile lines together like so
>> (for some reason):
>>
>> Host bitucket . org
>> IdentityFile ~/.ssh/id_rsa1
>> IdentityFile ~/.ssh/id_rsa
>>
>> I have even tried running ssh-agent . exe, adding id_rsa1 to that and
>> then running the git clone with no result.
>>
>> The weird thing is, I have two public keys as well and they both load
>> in the ssh . exe (they return errors about format), I just cannot get
>> my ssh . exe to work with multiple private keys.
>
> This might just be a special case of the problem of some hosting
> providers picking only the first key you provide, as described in this
> thread:
> https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.com/
>
> If so, you either need to hack around this with ssh host aliases, or a
> custom GIT_SSH_COMMAND.
>
>> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com> wrote:
>>> I am trying, for the sake of PhpStorm, to get multiple SSH keys working
>>> using git . exe, which means no GitBash.
>>>
>>> I can get the keys to work just fine with GitBash.
>>>
>>> I edited my .ssh/config to look like (I know this is incorrect):
>>>
>>> Host bitucket . org
>>> IdentityFile ~/.ssh/id_rsa1
>>>
>>> Host bitbucket . org
>>> IdentityFile ~/.ssh/id_rsa
>>>
>>>
>>> And id_rsa1 works, I can actually pick from the other repo. But, of cou=
rse,
>>> id_rsa does not now.
>>>
>>> I change to:
>>>
>>> Host bitucket . org-dd
>>> HostName bitbucket . org
>>> IdentityFile ~/.ssh/id_rsa1
>>>
>>> Host bitbucket . org-sas
>>> HostName bitbucket . org
>>> IdentityFile ~/.ssh/id_rsa
>>>
>>> And now only id_rsa works.
>>>
>>> I also tried combining the two IdentityFile lines together like so (for=
 some
>>> reason):
>>>
>>> Host bitucket . org
>>> IdentityFile ~/.ssh/id_rsa1
>>> IdentityFile ~/.ssh/id_rsa
>>>
>>> I have even tried running ssh-agent . exe, adding id_rsa1 to that and t=
hen
>>> running the git clone with no result.
>>>
>>> The weird thing is, I have two public keys as well and they both load i=
n the
>>> ssh . exe (they return errors about format), I just cannot get my ssh .=
 exe
>>> to work with multiple private keys.
>>>
>>> Has anyone got any ideas on how to solve this?
