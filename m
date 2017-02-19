Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B132201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 06:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdBSGfm (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 01:35:42 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36187 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdBSGfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 01:35:41 -0500
Received: by mail-qk0-f174.google.com with SMTP id x71so8244495qkb.3
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 22:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OmE4MfUlZHpowXl9hlDipOpzz82RUcQWZ95cxKBQui0=;
        b=ms1CoHkeTWTo8XfkXaGLu68qlmcFYsdXeumBn3YLGR9++tBZvKG1pRIIaO9H3Qz2Sh
         Ywym8vXVxokQUzcqsW+uAf9uYdEfUgb5nu8o3I5TfTfkjnQefLS9A905Eb5ogeC2YH2B
         Dd9Lcgnm6VEFHwzIY3NkPqpSde7Rp7KqjLsw4W99KPqX/5rlITtP9frnXr9druLUd4iy
         xYs3Oyyh7cr6L0RBWRzKMoV5iMAELO4yAxuuKagKY/wvYbTatL+SX1hnTCr/uDmzqq1w
         ZtVeRnLCPGXeIm0zwbQoN8Hejjb+D1qPFrV11/jTyYrTrboiOBq8TJU/qSaer0ZHbjRE
         xXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OmE4MfUlZHpowXl9hlDipOpzz82RUcQWZ95cxKBQui0=;
        b=WqqPNWD27hQaUjJVqO+KpWKqExFhMjYyShMSgq81Pi/3tuyADoB/GMcPT0LZiVNTE8
         tnk2sFyWAqpVW8Ii0iMEhdnxnUJbh1T40Z285El7Ojqtu4sf3aPMvvbxIOTO8XLS9sSu
         yosBJD2fwnKp6iqTwop1kr5aLbTfVU7hQe6BUg4Uqg3SCyvJT5j99ceD2dGuzTPIaTEG
         wn6Ri89LPI3BfdMcWr/5tub5dn8+Gp/qP4s2pK/Dh8crJS6An7QtjQnlUbAXbY6c6dkM
         9DoaCfcF6xWubQG3x9uvZMbc1hlLi9G3JYRe1wY6mU4ZIouQSFE5XfJ6mS6RhGEpe2LF
         h09Q==
X-Gm-Message-State: AMke39m/fUWUOU8aC37sjFjRJdmIsKDboUcfpbuvYmlgLsMLo4pC3MIWwUCBKb+gDDj19yZLH2lvpeUmcqwD+w==
X-Received: by 10.55.102.199 with SMTP id a190mr6536459qkc.277.1487486140113;
 Sat, 18 Feb 2017 22:35:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.52.198 with HTTP; Sat, 18 Feb 2017 22:35:39 -0800 (PST)
In-Reply-To: <CAOc6etZxkspqafifjPTbRDoVBt0XuOLbhiuY9bFTD2Wjtxw-HQ@mail.gmail.com>
References: <CAOc6etYz6+FzDRbkLS2SB9=F9DP18=6uLKdfCN3D3yd2Gug-tw@mail.gmail.com>
 <20170217051755.fx2ueizsprw2vida@sigill.intra.peff.net> <CAOc6etZxkspqafifjPTbRDoVBt0XuOLbhiuY9bFTD2Wjtxw-HQ@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 19 Feb 2017 00:35:39 -0600
Message-ID: <CAOc6etY39Pi72U3ibtF94oh4xqzP4SB3VEj8QJOhX-GobTOTRA@mail.gmail.com>
Subject: Re: difflame improvements
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 1:01 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Thu, Feb 16, 2017 at 11:17 PM, Jeff King <peff@peff.net> wrote:
>
>> This isn't difflame's fault; that's what "git blame" tells you about
>> that line. But since I already told difflame "v2.6.5..HEAD", it would
>> probably make sense to similarly limit the blame to that range. That
>> turns up a boundary commit for the line. Which is _also_ not helpful,
>> but at least the tool is telling me that the line came from before
>> v2.6.5, and I don't really need to care much about it.
>
>
> I'm running my own tests on difflame and I have a theory about "when"
> it breaks.... at least one of the cases when it breaks:
>
> Analysis for deleted lines is being driven by git blame --reverse.
> What I have noticed is that it "breaks" when blame --reverse drives
> the analysis into revisions where "treeish1" is not part of their
> history (like, bringing analysis "to the sides" of treeish1 instead of
> keeping analysis in revisions in the history of treeish2 that have
> treeish1 as one of their ancestors.... which is definitely a valid
> case for analysis, anyway). In this case, blame --reverse stops being
> helpful.
>

At the cost of being slower, I just pushed to master the best results yet.

The workaround I developed for the case I described on the previous
mail ended up providing much better results overall so I ended up
replacing the whole merge-analysis logic with it.

Thanks for your kind help and comments, Peff. Let me know how it goes.
