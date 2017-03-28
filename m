Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D751FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 05:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbdC1Fwv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 01:52:51 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36196 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbdC1Fwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 01:52:50 -0400
Received: by mail-lf0-f44.google.com with SMTP id x137so32226305lff.3
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7ThO9pSXcRNDsYPcl8Vuxy3oCYFR527nXcIN2ajjAXA=;
        b=TOLv25VszAbLaL/XNiDjvFOp6CekxV4SHdNuBzFSI6uTUKoMnhtT1rjkmHSB8TS/Oa
         001K8U68O6b/Z9E8aI1EYhjN9LeMGLwDqmwYocfs5SsdWbw8HTMz6E5opbl2igZU9NW6
         OLWt3vtm21Hli3vQfT30uphMcF41ouVZPxkjF7pZNPLdL95fAjCyRrCOcOXGCg4tsPOS
         ZAMcwV97wg2A7crPjmDsf/SldwmdCmc7R57SV6UdwS7JHlXDJPb4xfC5xRezijoknoL/
         yOlqz2YX6ifNNNdX+Fzcr430nEF5kQDI6PUjQlgsoY6vwb47U8HpCJQ8M3ToaDNSCwk2
         O/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7ThO9pSXcRNDsYPcl8Vuxy3oCYFR527nXcIN2ajjAXA=;
        b=ucTE06c30BUXvuP7PssOWmmNTwSAEPmXOmDfXdcp8jE4sucmJVRQkN3gw8QRTbvCmO
         drZcN9R8NKQlTzhP5e8icmhYLTXb7lCQAObz1VL5mqljglsQ2XuT300iYUbsifM2fIKM
         shpVNpPd9v50xOqw8wBtOzynwQuAFIZYaa7kL6UB0FW/g6XOlyjAbza6ixjoJ6jGOQjT
         P1sM+XRdJegx13JHbyoLVcPP0UV3DD5gMIdzc3FnDj8y6eD5OQ3JTsLBuz3kWnsrs0Cl
         t5C+zkKrLAH23d5XlVusB1tfnHfq+u7ZiCM100i3OBfv20Ybph7yqmcqKSikQjx7PiBK
         kDOg==
X-Gm-Message-State: AFeK/H0E2MYEcuJN1GkeSunJoLoc7E6N7oMbfNKlByC5o91mm4Y+Klnki0wFS7luPnKSpjJ5WrBmy6QPVzYD6Q==
X-Received: by 10.46.74.2 with SMTP id x2mr965785lja.87.1490680362835; Mon, 27
 Mar 2017 22:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Mon, 27 Mar 2017 22:52:42 -0700 (PDT)
In-Reply-To: <20170327221707.GA34039@mango1>
References: <20170327221707.GA34039@mango1>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Mar 2017 07:52:42 +0200
Message-ID: <CAP8UFD19+-xB-tPnY8Njfyci=wztnoZsEgx0UTqrJBEeTj_X-w@mail.gmail.com>
Subject: Re: [GSoC] Proposal Discussion
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 28, 2017 at 12:17 AM, Devin Lehmacher <lehmacdj@gmail.com> wrote:
> Hello everyone,
>
> I am a student studying Computer Science at Cornell University. I
> already completed a microproject, Move ~/.git-credential-cache/socket to
> $XDG_CACHE_HOME/credential/socket a week and a half ago or so.

Nice. It would be better though if you could provide a link to the
thread where your microproject was discussed. If it has been merged to
master, you could also provide the merge commit. Otherwise please tell
what is its branch name and current status in the last "What's cooking
in git.git" email from Junio.

> I am interested in 2 different projects and would like some advice on
> them, to help me decide which one to submit a proposal for.
>
> 1. `git rebase -i` conversion.
>    I was initially the most interested in this project but realize that
>    after having a very busy week last week that Ivan Tham started
>    [discussion][1] about this project. Would it be appropriate to submit
>    a proposal for a project that someone else also wants to work on?

Yes, it is ok. Obviously only one student/proposal can be selected for
a given project, but as anyway the main constraint for us is usually
the number of available mentors, there is a low chance that this would
prevent us from selecting one more student than we could otherwise
select.

You could also submit 2 proposals if you have time to work on more than one.

> 2. formatting tool improvements.
>    There are four different git commands mentioned [here][2] as possible
>    tools to improve as can be seen in the email. Of those I think it
>    would make the most sense to extend `git name-rev`. It seems best
>    suited to the desired behavior. It would need to be extended to
>    understand rev's that refer to objects rather than just a commit-ish
>    and also add formatting support similar to the information that log
>    and for-each-ref can output. Since this doesn't seem like much work,
>    would it be feasible to generalize and somewhat standardize all of
>    the formatting commands?

Yeah, I think it would be good. It might involve a lot of discussion
though and this could slow your project.
So if you really want to do it, my advice is to try to start the
discussion as soon as possible, that is now.

To do that you could for example Cc people involved in the email
discussions, and try to come up with concrete proposals about how to
generalize and standardize the formatting commands.

Thanks,
Christian.
