Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3971FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeCEUUS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:20:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42850 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeCEUUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:20:18 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F06D11F404;
        Mon,  5 Mar 2018 20:20:17 +0000 (UTC)
Date:   Mon, 5 Mar 2018 20:20:17 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
Message-ID: <20180305202017.GA26533@whir>
References: <20180304112237.19254-1-asheiduk@gmail.com>
 <20180304112237.19254-2-asheiduk@gmail.com>
 <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com>
 <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> 2018-03-05 2:42 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
> > Doesn't such a behavior change deserve being documented (and possibly tests)?
> 
> The old behaviour was neither documented nor tested - the
> change did not break any test after all.

I consider that too low of a bar to justify a behavior change
which can negatively affect users.
