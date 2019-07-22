Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CB41F461
	for <e@80x24.org>; Mon, 22 Jul 2019 19:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfGVTf7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 15:35:59 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:49188 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728694AbfGVTf7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jul 2019 15:35:59 -0400
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id pWPAhr75oXiWhpe6IhfdSj; Mon, 22 Jul 2019 19:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1563824158;
        bh=wf9W2zM1XVQFIc61Qp4jcw1L82jlG36wtgOErT9fl04=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=1s8gvAFe90b7R0fRFh/KLOKQ+ywZASE9M5SjKXPdxcrjqw1bMx+aFttXaiNvsFU2s
         FcWx4z8mJpJ3bwGWf1ORPr4bdcz7uGK9MWIU+rgSXC2enF3+zFbnGUyQxqjBahA8oT
         PTzd0NjMfkqGA35mtIhs+ikB4tfuLucZmYdUsBmnpV5U6lkvrhlDQN30VaUToyf9ir
         92JeXFRqsmIRf2e1OFpVqPdudLn161r5cqIJYERqGdu2UoqQ5U9GG6dBFofEwTacmj
         FlTXtQFkZJDbyPsVz3W8EAMursfWi75X/P0e7LfeECy9ZGaZ6gqzbLV3n1PPyOtcIx
         0tg7zPX9qqZOA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:9cdd:550e:128c:d6f0])
        by resomta-ch2-11v.sys.comcast.net with ESMTPSA
        id pe5vhfMM6I3dLpe6AhMOie; Mon, 22 Jul 2019 19:35:56 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Mon, 22 Jul 2019 12:35:35 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #04; Thu, 18)
Message-ID: <20190722193535.GA11274@comcast.net>
References: <xmqqtvbjvull.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvbjvull.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 03:36:06PM -0700, Junio C Hamano wrote:
> * md/list-objects-filter-combo (2019-06-28) 10 commits
> ...
> 
>  There is a bit of interaction with cc/multi-promisor topic, whose
>  conflict resolution I have no confidence in X-<.  Extra sets of
>  eyes are appreciated.
> ...
> 
> * cc/multi-promisor (2019-06-25) 15 commits
> ...
> 
>  There is a bit of interaction with md/list-objects-filter-combo
>  topic, whose conflict resolution I have no confidence in X-<.
>  Extra sets of eyes are appreciated.
> 

Do you still need input on the merge conflicts for these branches? I gave some
input earlier in this message:

https://public-inbox.org/git/20190714231558.GA24609@comcast.net/

- Matt
