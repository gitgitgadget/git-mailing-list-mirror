Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7780208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 21:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdHRVfg (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 17:35:36 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36422 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdHRVfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 17:35:36 -0400
Received: by mail-yw0-f179.google.com with SMTP id u207so66188364ywc.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wJjaxOLkof3u9uq5SAZaPiWq2KsjzYMSId2Iy3oPPQM=;
        b=mvLXnMnKcET7kIaJeC2SvA4GqPH5m3d40Bz8LmmIqChdftMwtISCtWPotTODO4JiJH
         piCpDf1kpcKhXIKYfGPUdukX6TegP6GkUVqDiQREXkgJnzbKL5I/HgC49uqIXv1x4qIw
         rWuLffCB4m/Zl8jhWaSAdlpHx55zp9awnrvBAR8KHGOngvz6+kLYaJ1fxdruSOaJjB5D
         h7kKOFxpJf+gfRFRsODEcGugFJcqiQhxIAoQ5EpuYiV5cLRPPODR7RduOML/BR4sEtUU
         mK9xuq9rpWECGuTAlaTfZgjN0/rq2qxocQ7QERVHVAtDhuC4DuXGHgy5W98uClWU/Hdl
         bdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wJjaxOLkof3u9uq5SAZaPiWq2KsjzYMSId2Iy3oPPQM=;
        b=ppTeSFYo0t+b4j0hDoR0L9P1eY77E/gHKHIb88IjNpPWuQtlATkkLQ0vN4bgP8K7P3
         IDdUqOySIqrs8WDAVpBijPO4GeCvCqKcRk2+0eutczRUf4PeS+Dy9t2bFDIRKvAV9ic8
         3pEv9WcnZIwRjgyxyVOiIQSoJy8VurFsWnasMvN5Rd5iz/0TTHCGc2DvdbTzMzNTndGA
         KqljvG1hhD0skdBVWt5fdY3PAwwkeJ5yvl5RPbhzYLymBqi/Ar7vGsJ4IIZYdtrhq2gv
         4Or71kvvOex1Ie7C1Lsd5xqZZOvGdWV/q8jMui1fQCLYO6/2lyBPQjAsQd5wb4sAmbte
         djog==
X-Gm-Message-State: AHYfb5iXNxUwdM20wF5PYEzfxsBdI3rTf7vVSngw8rPpz7MjTs3x9swc
        32iq5olCGB39+72rXqNRgH1t2Qbpng==
X-Received: by 10.129.206.5 with SMTP id t5mr3017264ywi.385.1503092135244;
 Fri, 18 Aug 2017 14:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.211.10 with HTTP; Fri, 18 Aug 2017 14:35:34 -0700 (PDT)
In-Reply-To: <20170818203858.GK13924@aiede.mtv.corp.google.com>
References: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
 <20170818203858.GK13924@aiede.mtv.corp.google.com>
From:   R0b0t1 <r030t1@gmail.com>
Date:   Fri, 18 Aug 2017 16:35:34 -0500
Message-ID: <CAAD4mYhYWa=gB3ZG=Mepx2C+GO_ku7m2Zn6rL2paQBsVK6ya6A@mail.gmail.com>
Subject: Re: [bug] Git submodule command interprets switch as argument and switch
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> R0b0t1 wrote:
>
>> The issue is as follows:
>>
>> R0b0t1@host:~/devel/project$ git submodule add
>> https://github.com/user/project -f
>> Cloning into '/home/R0b0t1/devel/project/-f'...
>
> Thanks for reporting.  Confusingly, I think this is intended behavior.
> "git help submodule" explains:
>
>         add [-b <branch>] [-f|--force] [--name <name>]
>                 [--reference <repository>] [--depth <depth>] [--]
>                 <repository> [<path>]
>
>                 Add the given repository as a submodule at the given
>                 path [etc]
>
> Since the -f comes after <repository>, it is a <path>.
>

Not to comment on every response to this bug, but I understand. What
is confusing is that the command was failing without being forced, and
without thinking I added "-f" at the end. The command succeeded as if
I supplied the force flag, but per my experience with other tools, and
with other Git commands, "-f" should not be a flag. It should be a
path, as you say. However it appears to be both.

To reproduce my situation exactly, add "*" to your .gitignore. The
directory "gerrit" should then be ignored, and Git will warn you that
the submodule will not be tracked (I may have another issue to report
related to this, but I'm still trying to figure out what is going on).
However, if you name the directory something else, like "-f", it will
still be matched by the .gitignore rule and should not succeed. This
is why I think the path is also being interpreted as a flag.

Something else may be happening, but either way the behavior does not
seem to be expected nor consistent with other parts of Git.

> That said, there are a few related things wrong here.
>
> The usage string above says I can put "--" before the <repository> to
> make things extra unambiguous.  But when I try that, I get the following
> result:
>
>         $ git submodule add -- https://gerrit.googlesource.com/gerrit -f
>         Cloning into '/tmp/t/test/-f'...
> [...]
>         Resolving deltas: 100% (215796/215796), done.
>         /usr/lib/git-core/git-submodule: line 261: cd: -f: invalid option
>         cd: usage: cd [-L|[-P [-e]] [-@]] [dir]
>         Unable to checkout submodule '-f'
>
> If I try to put the "--" between <repository> and <path>, I get another
> confusing result:
>
>         $ git submodule add https://gerrit.googlesource.com/gerrit -- -f
>         '--' already exists in the index
>
> "git help cli" is supposed to give advice about this kind of thing as
> well --- e.g., it gives some sound advice about what form of flags
> scripts should use (e.g., to always use the 'stuck' form --name=<name>
> instead of --name name).  But it doesn't mention this issue of flags
> belonging before other arguments.
>
> Thoughts?
>

I have experienced issues with -- before. It has been long enough I
have forgotten. Sorry for not being able to provide anything concrete.
