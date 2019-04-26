Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A45C31F453
	for <e@80x24.org>; Fri, 26 Apr 2019 05:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDZFxj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 01:53:39 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46854 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZFxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 01:53:39 -0400
Received: by mail-pf1-f171.google.com with SMTP id j11so1108121pff.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMiCcpU3Ycsr0b/soIDMr18poV+q7jKPsya7yiqTJgU=;
        b=rLkDmJV8p51qAo+1Mla5dCQfvB9a2m9f7RG2dQS2aO+ZqXBEwmwBSEYZBIeCo5nIyh
         3+uq3bbZR0vZ3JyKwDLRST6RHgLTme39hQ0BDBRWX55FaLIrwgH6GsFfrkGe/82UpHyT
         O/4vsr/TJFaF+DC79/MHZcDNps2rusFADwZthEcgSBfL2LeD+npcZq/C/n8SEwd1SuAw
         YvaNwPkMc2TDXJnyXlsY2Z3pdbaA90/Jv/Z5p1Qvu/igf5ewmcL8mAfY68qahLI+1uBs
         qxxL022FZQSYLIQZ/FAMhpvh5vAw4yXsamTRqhX2U7GT3/GcxIj/QuLOrXqicQsPWqQZ
         LRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMiCcpU3Ycsr0b/soIDMr18poV+q7jKPsya7yiqTJgU=;
        b=MCpitk28IejhaOezMCEx6/E2mKB1atq9eNYgfCRoA3Ka8gFa691ox5/gs44Z3Fvw0Z
         bq2WB8y48CP6tClGrLXV2a5f8WN4xgXAoWqLwj0koNDRdKjVfbPaY9NDEDc3yZQAy+cv
         ULSzeJ5inQQcyFUPgIIuYyilorxkL5r3NYSq+Kqq2AXOdR6G6fZsFAdN2jtu57eBEXmZ
         njvDFOnFBqTIgmL68/2z7mdypPgRpmcMv8U5+jsGRbgnLR94FrLOex5mlxD9tfJh8yDr
         EeHfljMJYAJB38gR8tx2lBIQQIPYKQgCzwRDugjWveQJz0gPfzw5uJR7pBegjEIgRiWc
         CHUw==
X-Gm-Message-State: APjAAAV9smIRKzw5EkaTou24IHgEnayslpqq/1Q2dd8XoWkjUL39wWTM
        GG/xBkdQz7fVW35TNGNvyjQQoau0bk5h4g==
X-Google-Smtp-Source: APXvYqyqFXLQKKyxPGDzBcZvIlj1IEF7JpV1ZWpN1py+e50aORKBSvCYFu+fJt8OZJXAVK8sX5JKuA==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr41550192pgl.308.1556258017795;
        Thu, 25 Apr 2019 22:53:37 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:588e:48c6:712:f2cf])
        by smtp.gmail.com with ESMTPSA id 4sm5616076pfj.45.2019.04.25.22.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:53:36 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 25 Apr 2019 22:53:35 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
Message-ID: <20190426055335.GA16651@Taylors-MBP.hsd1.wa.comcast.net>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
 <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 02:41:38PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Apr 25, 2019 at 07:15:06PM +0900, Junio C Hamano wrote:
> >> * tb/unexpected (2019-04-10) 7 commits
> >>   (merged to 'next' on 2019-04-25 at c49927fca0)
> >>  + rev-list: detect broken root trees
> >>  + rev-list: let traversal die when --missing is not in use
> >>  + get_commit_tree(): return NULL for broken tree
> >>  + list-objects.c: handle unexpected non-tree entries
> >>  + list-objects.c: handle unexpected non-blob entries
> >>  + t: introduce tests for unexpected object types
> >>  + t: move 'hex2oct' into test-lib-functions.sh
> >>
> >>  Code tightening against a "wrong" object appearing where an object
> >>  of a different type is expected, instead of blindly assuming that
> >>  the connection between objects are correctly made.
> >>
> >>  Will merge to 'master'.
> >
> > Thanks for picking this up. Before you merge to master, I want to make
> > sure that the whole series was taken in.
> >
> > I can see the first four of these landed on 'next' (in
> > 5c07647d98...b49e74eac4), but I'm having some difficulty finding the
> > later three.
> >
> > Did you pick these up as well?
>
> Sorry, but I do not follow.
>
> $ git log --oneline master..c49927fca0^2
> 97dd512af7 rev-list: detect broken root trees
> ee4dfee227 rev-list: let traversal die when --missing is not in use
> 834876630b get_commit_tree(): return NULL for broken tree
> b49e74eac4 list-objects.c: handle unexpected non-tree entries
> 23c204455b list-objects.c: handle unexpected non-blob entries
> 0616617c7e t: introduce tests for unexpected object types
> 5c07647d98 t: move 'hex2oct' into test-lib-functions.sh
>
> Do you mean you do not have b49e74eac4..c49927fca0?  I do not think
> the topic was merged in multiple steps (iow, at c49927fca0^ the
> whole 7 commits were not in 'next', and after c49927fca0, all 7 are
> in).  So I am not sure what you are asking.  IOW, if you have b49e74
> in your copy of 'next', it is impossible not to have the others.

Ah, I _can_ see the merge in my local copy (fetched from
https://github.com/git/git) as c49927fca0 (Merge branch 'tb/unexpected'
into next, 2019-04-25).

I looked for the commits themselves with:

  $ git log --author=Taylor

on 'next', but only found the first four. I'm sure there's a logical
explanation of why this happened, but I'm not sure what it is :-).

> The merge itself can be seen at one of the authoritative repositories
>
> https://git.kernel.org/pub/scm/git/git.git/commit/?h=next&id=c49927fca0de4c213ae9b21dcb7eafb80e453d27
>
> Unfortunately, I do not know how to ask GitHub web UI to give us a
> simple "log --oneline" equivalent of list like gitweb did (sadly
> cgit is not much better wrt this), but I think clicking on the
> parent link starting from here
>
> https://github.com/git/git/commit/c49927fca0de4c213ae9b21dcb7eafb80e453d27
>
> and remembering (or writing down X-<) the commit names would
> eventually give us the equivalent.
>
> In any case, thanks for working on this topic.

Thanks for explaining, and it was my pleasure.

Thanks,
Taylor
