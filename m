Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2842E1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbcHWRJJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:09:09 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:34629 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbcHWRJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:09:07 -0400
Received: by mail-ua0-f177.google.com with SMTP id k90so255860411uak.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TePtyQkxqqovAOJuIxZCAWiYnkE+obWMmx8d/IUyats=;
        b=PSIs94z4NjAPjAj19+LmxnrC9h+YlXZb5Ucg1vqGbyt+ns9R9Cc40wR4GkF8OdQ3SB
         QriyT1tvSR5dS3I09Tjo7oL2lNnKvfwxL7Fylg1pZGmWxceJjJl/gUjk8YE4B1DlFS1Q
         jI0Ed1jF5/tyXy6e0FhmId8A/C7PIxIwpj0tTZl23/OEnH3mOjfi3IHsWM0TplPP/+IR
         AYclieBIeUOIdqGO8CUX8U6M86aM7ppIaAsk6rd3mK1Ln8hhWQ8KdgP6BsU0HsXxY6qd
         qoq6KtDr5PCBbM+YmsUOStx0pY28AF0ubIqKuY6ZYCAaT+ApAtmM+eCKKradH+rnJsl9
         gJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TePtyQkxqqovAOJuIxZCAWiYnkE+obWMmx8d/IUyats=;
        b=k8rG0QElh4ml+BJdLGfkAFUcUZuNI5Lse7CmuXST4kGTkdiBvKiJeKl5gEioCn3UfR
         C4SZlQJOddpsGbhxssV8439U2v/9gkZ8cryjf7+LjU6eUCB3OlGba07/f+qwdPMqAavD
         qjMTRz/GptpuN3A8ppAFEZNqSIwV5v9jHCA2aj/uxlzdSwBlBTTI287wdDFQ0QMtfhl9
         6j2frM53hcYUEyPey0fYlCT8q13l5+MHhRQBZ+r/JiYAcnM0DRrVLrjUMpIwECMoTM1O
         bkmfpN0eRg6GjgCO0U/L7k7YaaB+EztYqa4dX3PPS/ZbHBwi9USwiiu/Nc7GtDs832MD
         WZ+Q==
X-Gm-Message-State: AEkoouuCo9+fJqBG10v8Aj1L8R/nZkhvo8cjkdvlgoWijKRNJCgAYl19ieewPEI/V09o0bDzb0NH+utMdfGa/A==
X-Received: by 10.159.34.177 with SMTP id 46mr14997065uan.111.1471972118076;
 Tue, 23 Aug 2016 10:08:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.85.4 with HTTP; Tue, 23 Aug 2016 10:08:37 -0700 (PDT)
In-Reply-To: <20160823164326.GA22168@tb-raspi>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com> <20160823164326.GA22168@tb-raspi>
From:   Lucian Smith <lucianoelsmitho@gmail.com>
Date:   Tue, 23 Aug 2016 10:08:37 -0700
Message-ID: <CAHLmBr0gZNnQ7ycDqTSJ-f6YpgSr7Yfjjqd21P5KjQRyC88K8Q@mail.gmail.com>
Subject: Re: git-svn bridge and line endings
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 9:43 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On Mon, Aug 22, 2016 at 05:04:47PM -0700, Lucian Smith wrote:
>> I'm attempting to use the git-svn bridge, and am having problems with
>> line endings on Windows.
>>
>> The setup is that we have a git repository on github, and I've checked
>> out a branch on my Windows machine using Tortoise svn.  I make
>> changes, commit them, and the branch is updated.  In general, this
>> works fine.
>
> Just to make sure:
> The repo is in git format.
> Is it a public repo ?

Yes, it is.  In fact, it's https://github.com/sbmlteam/sbml-test-suite

> Or could you make a piblic demo repo ?
> Do I understand it right: Tortoise SVN talks directly to the Git server ?

This is the part that is a little bit of black magic for me, but yes:
I point TortoiseSVN at
https://github.com/sbmlteam/test-suite.git/branches/develop and tell
it to check that out, update, commit, etc.

> Isn't Tortoise SVN a client to talk to SVN server?
> What goes over the wire to the remote Git server, git or SVN ?

That's a good question ;-)  I think SVN!

> To my understanding, "git svn" can use Git locally, and talk to an SVN se=
rver.
> What do I miss ?

I assume something is using "git svn" on the github side of things,
but I don't know for sure, and I'm not sure who's in charge of that,
either.

-Lucian

>> If this was just SVN, I could set the 'eol-style' for files to
>> 'native' to let it know to expect Windows/linux/mac line endings for
>> particular files.  This seems to be handled in git by using the
>> '.gitattributes' file instead.  Unfortunately, the git/svn bridge
>> doesn't seem to be translate the information in the .gitattributes
>> file to appropriate eol-style settings in SVN.  Checking out a file
>> using SVN on Windows leaves me with a file without CRLF's, and if I
>> check in a CRLF file, that's the way it goes into the repository.
>> Differences in CRLF alone show up as 'real' differences that can be
>> checked in, and, if this happens, this causes problems with other
>> people's repositories.
>>
>> Am I doing something wrong; is there another way to handle this; or
>> can I file this as a bug report/feature request?
>
