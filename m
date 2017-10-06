Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6161FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbdJFRxo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:53:44 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:38782 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752514AbdJFRxn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 13:53:43 -0400
Received: from app01-neu.ox.hosteurope.de ([92.51.170.135] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1e0Wof-0004f6-97; Fri, 06 Oct 2017 19:53:41 +0200
Date:   Fri, 6 Oct 2017 19:53:41 +0200 (CEST)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Message-ID: <1641255580.85206.1507312421166@ox.hosteurope.de>
In-Reply-To: <CAGZ79kbp=ewvdR8gXptwDjDdtM3TdC8qp1qR8XhETa7_CKgqRQ@mail.gmail.com>
References: <20171005212344.22887-1-thomas.braun@virtuell-zuhause.de>
 <CAGZ79kbp=ewvdR8gXptwDjDdtM3TdC8qp1qR8XhETa7_CKgqRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] completion: Add forgotten describe options
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev10
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507312422;f372e2f5;
X-HE-SMSGID: 1e0Wof-0004f6-97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Stefan Beller <sbeller@google.com> hat am 6. Oktober 2017 um 00:17 geschrieben:
> On Thu, Oct 5, 2017 at 2:23 PM, Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:

Hi Stefan,

> > completion: Add forgotten describe options
> 
> When/Why was it forgotten? git-blame thinks it was me in b0176ce6b5
> (builtin/describe: introduce --broken flag, 2017-03-21)
> Which do you add? (dirty and broken)
> 
> I had these questions when reading the subject (which is the
> equivalent of reading the output of `git log --oneline` in the future)
> I think a better wording might be
> 
>     completion: add --broken and --dirty to describe
> 
>     When the flags for broken and dirty were implemented in
>     b0176ce6b5 (builtin/describe: introduce --broken flag, 2017-03-21)
>     and 9f67d2e827 (Teach "git describe" --dirty option, 2009-10-21)
>     the completion was not updated, although these flags are useful
>     completions. Add them.

Thanks for the review. Your commit message is (obviously) much better than mine. Reroll follows.

> > ---
> 
> The patch looks correct.
> 

Thanks,
Thomas
