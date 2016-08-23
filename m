Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291481FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbcHWRcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:32:08 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36213 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbcHWRcH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:32:07 -0400
Received: by mail-ua0-f174.google.com with SMTP id 97so256719344uav.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/DPGhMtnNOs/MsfpdY17N7vf6jpmYiokCi4p4MQTRfs=;
        b=ZWH5HHt4elLf9CWMQF1Yer7wo0JPBKlx89XbVGote4Sv7zbExxhwkPwPYWptbmzFtq
         fEYrj/lUnDgxlFre2HKTEBatb1OOQ65aP2U+kxXZYOAjhCQ8vK9WqhvzR9eQVzOsTSCG
         UaPUhl9ZgNBcQZKwpxTt+dY4Tdlx+NBrXpM2dh39AM73m7KLyLimUyXoLdj2ZEb47mow
         aEdwGnqf+x9LRCEMw03f7ReJzaTlu5RvoLzepx0zsz4p8Iv+LkO8p0G7BwEO5oaPfvIf
         7iBWTrMS+LeOOUxzqfYRwVZMvCFb/VlM+h9By/RcFcq3Au1XZ+en91SzFDpbVFzj0j5s
         bB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/DPGhMtnNOs/MsfpdY17N7vf6jpmYiokCi4p4MQTRfs=;
        b=eDRzKLIkQLXOgqN+oRag+IYSmIlyDyeETw+IUCaCfJbd3UV66fe2Xm5PfHXoQ5ZVEX
         jadytwXNBjxjth0zPnSB5tQ4wBpgUjhkZ74M6Orz/8mTU3ZcOJqYqu5Q8ycmC99griLB
         kg71XF/9dVP5Dvr440gt/73rCe9j8Ls4hA9y77g4ZFx86sCExnrXbTt6Iq9BvZ8p6zmB
         X4bwiQAYWNsSa1UA0YRxM7jEIpvLSe1gpExO/S7oyJ17A0LA2rMMlccCK8rWBmYnVyJu
         SSex/PWQF9H68ZNki3D1AHf6CbfOwox0SiOXGThHpec8ZsXu7JhFmrS7HE0oktsmlX3F
         K9iQ==
X-Gm-Message-State: AEkoousIxDP7Oj7ezvAIXsLrJ7yW4WL5x7NBDowCif9bOp7n4wznS94SEzwXR3pj86bHUctG54xe0Ju/ObLWdQ==
X-Received: by 10.159.34.177 with SMTP id 46mr15059082uan.111.1471973483808;
 Tue, 23 Aug 2016 10:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.85.4 with HTTP; Tue, 23 Aug 2016 10:31:23 -0700 (PDT)
In-Reply-To: <xmqqh9abwg4j.fsf@gitster.mtv.corp.google.com>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com> <xmqqh9abwg4j.fsf@gitster.mtv.corp.google.com>
From:   Lucian Smith <lucianoelsmitho@gmail.com>
Date:   Tue, 23 Aug 2016 10:31:23 -0700
Message-ID: <CAHLmBr3+3WccbYTm1v2_jd+hR6rygJQfPtH6+MMP-xPLjEy72w@mail.gmail.com>
Subject: Re: git-svn bridge and line endings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Windows doesn't have any problem reading files with any form of crlf.
The main issue we have run into thus far is that if I create a new
file in Windows, it's going to have crlf, and if I check it in that
way through this svn process, the file is then stored with crlfs,
which git does not expect.  A wide variety of problems results.

-Lucian

On Tue, Aug 23, 2016 at 10:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lucian Smith <lucianoelsmitho@gmail.com> writes:
>
>> The setup is that we have a git repository on github, and I've checked
>> out a branch on my Windows machine using Tortoise svn.  I make
>> changes, commit them, and the branch is updated.  In general, this
>> works fine.
>
> Hmph, doesn't Windows port ship with core.autocrlf these days?
