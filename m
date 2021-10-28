Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE0C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD09A60E78
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 09:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhJ1Jec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 05:34:32 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:48970 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1Jea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 05:34:30 -0400
Received: from [IPv6:2a01:e0a:d1:f360:9536:a9eb:5090:a834] (unknown [IPv6:2a01:e0a:d1:f360:9536:a9eb:5090:a834])
        (Authenticated sender: jn.avila@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6B2A57802C2;
        Thu, 28 Oct 2021 11:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1635413522;
        bh=3XSAqDivZer/geuKX+MfFo1OUIKJlJTaywETbAROTDE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i52X+fAcpF3WAhV9l1qTTchS3AzrBIE2oKP2a01KroNZL6hCAp7aet1bPSX6tMaVM
         NH7MSQCNoCr3g6kxbn2UN2gYiCN/Y0h5zjlKpFevlnXiwMcg5KfJ4PGHiIJ8Pfw3df
         hKuU76rnc+F/EMfTAsY7WqpwHXp0rwZ5s3GzjgztJAgZdXBaUmFMKR0TbkLNXEMrcO
         jj5R3/lm36KrcY4dVykuYBvfHOCXp2I27hhbwYdHyBXC7Wi4+mqnrUckSBhrdMtQZx
         Ke48MoAxxYR6ujFk96Uk/3KwJOopKpOSby927o4fWQC6uSot/a2Cky3ke74WjnxlFw
         JfEcXa9Nd+xMA==
Subject: Re: [PATCH] doc: fix grammar rules in commands'syntax
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <819ab0ed-8a99-2987-79c9-88cd1118b51b@free.fr>
Date:   Thu, 28 Oct 2021 11:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 27/10/2021 à 20:56, Martin Ågren a écrit :
> On Tue, 26 Oct 2021 at 21:35, Jean-Noël Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> --- a/Documentation/git-archimport.txt
>> +++ b/Documentation/git-archimport.txt
>> @@ -9,8 +9,8 @@ git-archimport - Import a GNU Arch repository into Git
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
>> -               <archive/branch>[:<git-branch>] ...
>> +'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir>]
>> +              <archive>/<branch>[:<git-branch>]...
> 
> Your rewrite makes it seem like one would write, e.g., "myarch/master"
> with a literal slash, whereas my initial thought was that the original
> tried to express something like "(<archive> | <branch>)". But I have
> zero experience with "GNU Arch" and git-archimport, so I can't really
> tell whether your rewrite is for the better or not. :-)

The <archive>/<branch> grammar is the one available in the usage of the
command.


> 
> In any case, this document goes on to write "<archive/branch>" several
> times. Supposedly, they would all want to be changed as well. There's
> also an instance of "Archive/branch identifier ..." to maybe look into.

Ack. All the changes in a single commit

> 
>> --- a/Documentation/git-cvsimport.txt
>> +++ b/Documentation/git-cvsimport.txt
>> @@ -9,11 +9,11 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
>> +'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]
> 
>> -<CVS_module>::
>> +<CVS-module>::
>>         The CVS module you want to import. Relative to <CVSROOT>.
> 
> Here's another "<CVSROOT>".

Is this an environment variable or a placeholder?

> 
>> --- a/Documentation/git-http-push.txt
>> +++ b/Documentation/git-http-push.txt
>> @@ -63,16 +63,15 @@ of such patterns separated by a colon ":" (this means that a ref name
> 
>> -Each pattern pair consists of the source side (before the colon)
>> -and the destination side (after the colon).  The ref to be
>> -pushed is determined by finding a match that matches the source
>> -side, and where it is pushed is determined by using the
>> -destination side.
>> +Each pattern pair '<src>:<dst>' consists of the source side (before
>> +the colon) and the destination side (after the colon).  The ref to be
>> +pushed is determined by finding a match that matches the source side,
>> +and where it is pushed is determined by using the destination side.
> 
> This looks like the insertion of "'<src>:<dst>' early on, where the rest
> of the changes are just follow-on line-wrapping.
> 

Strict line-wrapping doesn't work well with version control in free
text. And it doesn't work well either with asciidoc, where some unlucky
wrapping can generate spurious formatting.

> I wonder if this patch could benefit from being broken into smaller
> pieces. Maybe a few preliminaries like "change <foo|bar|baz> to
> (foo|bar|baz)" and the like, then even if the final patch is "large", it
> will not be *as large*? But there are clearly sub-topics here, such as
> "change <some_arg> to <some-arg>" and "change arg to <arg>". Or maybe
> this doesn't make sense as an approach to cutting this patch into
> smaller pieces, but I thought I'd mention it.

The changes are muliplying. I will split them.

> 
>> - - It is an error if <src> does not match exactly one of the
>> + - It is an error if '<src>' does not match exactly one of the
>>     local refs.
>>
>> - - If <dst> does not match any remote ref, either
>> + - If '<dst>' does not match any remote ref, either
> 
> I believe these match Junio's preference, so ok. But again, this looks
> like it could go in a separate patch from a lot of these other changes
> as a way of keeping to somewhat focused changes.
> 
>> -               (--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
>> -               (-[c|d|o|i|s|u|k|m])*
>> +               [--(cached|deleted|others|ignored|stage|unmerged|killed|modified)...]
>> +               [-(c|d|o|i|s|u|k|m)...]
> 
> Sort of cute how this saves on repeating the "--" by pulling it out.
> Anyway, nothing new in your patch. :-)

To me, the grammar should express at the token level (not like here),
and anyway, this synopsis is not correct: even if these options are
allowed to be repeated several times on the command line, this is
useless and some of them have the same meaning (and this should be
shown). This way of expressing the grammar induce the reader into
thinking that this is some kind of inner grammar to the command.


Jean-Noël
