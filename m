From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3] githooks.txt: Improve the intro section
Date: Tue, 26 Apr 2016 19:51:32 +0200
Message-ID: <CACBZZX7_C9Xsd65FrB2cUAN+UQ5Fxc7MiBdw=HtAGre=Ppxjpw@mail.gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com> <xmqqr3dtlf7n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av79Z-0006V5-KA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbcDZRv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 13:51:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36735 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbcDZRv6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 13:51:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id l68so1488954qkf.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KfKnUdWdllnIb/YgDUxB6B4/U2vShwkKiuPXpOn2stM=;
        b=xhgR9hpr8TXvVr93vRveRclj15GWX8m66QrQV4KoS46ZqqPWYUCQAHPu0FGojie1Pf
         to7L8brLQ3zNWf28UXoZIUf1X0aeuE0TAGcGvGBFo2H6ywOLnQYLENJi8JZ/eVz3TFvS
         sLuIpPCqs0TBWRjVAWrRvIvkF929Y7f4HjKmtfU4W9ov8m70MHmpfcHqA0o1D1/qJDe0
         /0cwhb8RZ5mDDZ26v4dJHy31TExV/s11C6RmuJE8ouyCq/LFO7nGHdN0RljFWDEDxn5h
         QGo7buE0B7baev+5U9rjG8in2Dp5igkIsCRfZWoT2bMK2h2LW7mTyzG/y7AuwS86WQwD
         B5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KfKnUdWdllnIb/YgDUxB6B4/U2vShwkKiuPXpOn2stM=;
        b=aPQRoh1ycY9uunLuTtSc75MKxgq4uEk8Yab9tEjGHwDvSBxfW+I4JBoXkCBGw4gk5r
         IpuQTxrV3VGbMSAC87tpWZhEFGi7TJM9mbx4NdAFyzlbiSw4BHhU1QwX+6e7wgRhRwu9
         mQoZqAMT3QPGt7pi/95evcjdGn2kUD8gCqDuMrJNiwswmaGBTcBw4K2OQT/p6SIukls3
         mlkisEQ7c+iZ7ZZshf8mYLsscv2lFpXPd1vYYYuyzLErOx8e0T4J1GopNbe3UXJK6Ucf
         qcM4wva3MIs6ji9xHXoKiXaxRt2NV+Jq8A+ZdbV1mfT3uaC4it2TwOmz/u3YP5E2qynH
         5N2Q==
X-Gm-Message-State: AOPr4FV5OdwDxFSu+wXUm6d+pAeXFiE87J3rSERZAIjZEfG7F3WSZr0vaM0AmEdSV685CFyI77eHQaFN+VSfqQ==
X-Received: by 10.55.109.7 with SMTP id i7mr3841451qkc.127.1461693111955; Tue,
 26 Apr 2016 10:51:51 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 10:51:32 -0700 (PDT)
In-Reply-To: <xmqqr3dtlf7n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292630>

On Mon, Apr 25, 2016 at 8:23 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the documentation so that:
>>
>>  * We don't talk about "little scripts". Hooks can be as big as you
>>    want, and don't have to be scripts, just call them "programs".
>>
>>  * We note what happens with chdir() before a hook is called, nothin=
g
>>    documented this explicitly, but the current behavior is
>>    predictable. It helps a lot to know what directory these hooks wi=
ll
>>    be executed from.
>>
>>  * We don't make claims about the example hooks which may not be tru=
e
>>    depending on the configuration of 'init.templateDir'. Clarify tha=
t
>>    we're talking about the default settings of git-init in those cas=
es,
>>    and move some of this documentation into git-init's documentation
>>    about the default templates.
>>
>>  * We briefly note in the intro that hooks can get their arguments i=
n
>>    various different ways, and that how exactly is described below f=
or
>>    each hook.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>>  Documentation/git-init.txt |  6 +++++-
>>  Documentation/githooks.txt | 32 ++++++++++++++++++++------------
>>  2 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>> index 8174d27..cf37926 100644
>> --- a/Documentation/git-init.txt
>> +++ b/Documentation/git-init.txt
>> @@ -130,7 +130,11 @@ The template directory will be one of the follo=
wing (in order):
>>   - the default template directory: `/usr/share/git-core/templates`.
>>
>>  The default template directory includes some directory structure, s=
uggested
>> -"exclude patterns" (see linkgit:gitignore[5]), and sample hook file=
s (see linkgit:githooks[5]).
>> +"exclude patterns" (see linkgit:gitignore[5]), and example hook fil=
es.
>> +
>> +The example are all disabled by default. To enable a hook, rename i=
t
>
> "sample hooks are all disabled" would be better; if for some unknown
> reason you are trying to avoid "sample hooks", "examples are all
> disabled" may be acceptable.
>
>> +by removing its `.sample` suffix. See linkgit:githooks[5] for more
>> +info on hook execution.
>
> Makes a first-time reader wonder if I am allowed to ignore the
> sample and write my own from scratch, or if the only thing that is
> allowed is to enable what is shipped with .sample suffix.
>
> I wonder it would become less confusing if we placed even _less_
> stress on these sample hooks; I find that saying we ship sample
> hooks that are disabled is probably more confusing.
>
> We do not ship any hook (hence nothing is enabled by definition);
> there are a handful of sample files that you can use when adding
> your own hook by either referencing them or taking them as-is, and
> the latter can be done by removing .sample suffix, which is merely a
> special case convenience.

Will fix this confusion.

>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index a2f59b1..2f3caf7 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -13,18 +13,26 @@ $GIT_DIR/hooks/*
>>  DESCRIPTION
>>  -----------
>>
>> -Hooks are little scripts you can place in `$GIT_DIR/hooks`
>> -directory to trigger action at certain points.  When
>> -'git init' is run, a handful of example hooks are copied into the
>> -`hooks` directory of the new repository, but by default they are
>> -all disabled.  To enable a hook, rename it by removing its `.sample=
`
>> -suffix.
>> -
>> -NOTE: It is also a requirement for a given hook to be executable.
>> -However - in a freshly initialized repository - the `.sample` files=
 are
>> -executable by default.
>> -
>> -This document describes the currently defined hooks.
>> +Hooks are programs you can place in the `$GIT_DIR/hooks` directory =
to
>> +trigger action at certain points. Hooks that don't have the executa=
ble
>> +bit set are ignored.
>
> The last sentence is POSIXPERM only, though.

So what does this do on non-POSIX systems?:

    const char *find_hook(const char *name)
    [...]
            strbuf_git_path(&path, "hooks/%s", name);
            if (access(path.buf, X_OK) < 0)
                    return NULL;

Just always return true I guess.

I'm not going to change this bit, I think that if we have special
systems that don't have +x it makes sense to just document how +x
works on those systems rather than the entirety of the rest of the git
documentation adding caveats every time the executable bit concept
comes up.

>> +When a hook is called in a non-bare repository the working director=
y
>> +is guaranteed to be the root of the working tree, in a bare reposit=
ory
>> +the working directory will be the path to the repository. I.e. hook=
s
>> +don't need to worry about the user's current working directory.
>
> This sentence took me two reads until I mentally substituted "the
> working directory" with "its working diretory", to realize that you
> are talking about the cwd of the process that runs the hook.
>
> While "is guaranteed" may be technically correct and we have no
> intention to change it, it sounds unnecessarily strong.
>
>     When a hook is invoked, it is run at the root of the working
>     tree in a non-bare repository, or in the $GIT_DIR in a bare
>     repository.
>
> perhaps?

=46ixed.

>> +Hooks can get their arguments via the environment, command-line
>> +arguments, and stdin. See the documentation for each below hook for
>> +details.
>
> "each below hook" sounds somewhat ungrammatical.
Yeah. Now "each hook below".
