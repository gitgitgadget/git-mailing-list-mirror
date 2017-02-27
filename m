Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A5820254
	for <e@80x24.org>; Mon, 27 Feb 2017 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdB0Wn6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:43:58 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35728 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdB0Wnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:43:51 -0500
Received: by mail-lf0-f66.google.com with SMTP id z127so7168000lfa.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=7mbEsGcvXWmd1FxZl3dDylMRFlFoJEue7QhMYvIsN4k=;
        b=udOSPzNtWdIr6A1ZQjHya1KZmExK/ytJ9TZ2Z+N2JNIeW6fZg3GlCSOSvv2TZSCsDF
         uG7V35smF1ODKLY3rJg7tqmCubdhXjbec7r9iE87skghM0dd7T1eSmNdQDjimMnbR1Eu
         dKRZBoaNH6+PS+U3aOMHUOy2CUa0w5Q/FITkhFEEVAcmrk/z3T7YA4cNulIvWlPdCPE/
         mv3/qva3zqYYZBgYEDrRTVG87BOq0g8oJCteWnw1QkMImDbDnrom9/QEb0RjbydmXeHo
         X42Yq4Nbx3n/7aHhb+1t4NLP+rQWhPtgOAkj4urK1dUIl6oE+HZ7HvwgNoWTR+jrHpoE
         f/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7mbEsGcvXWmd1FxZl3dDylMRFlFoJEue7QhMYvIsN4k=;
        b=RCV6gL1cgjRDjKwp0qPBJ7dCJ+lbmbFTSsKsyzoviDG0FtyDqw6w0L8eXw1Wg0nPc7
         9YCl/h20dnQpanJvvN1WQc1Wztra/z6McQblD9RGAGMwiyJFhoLOZruYn5jvt4aSHGVX
         mEktL4Gv0COKmF6pD0QVoUb8OmNpXuH9SJa9YlhKB0o+UCEveSZPK5LTCPKh4wj1pkl+
         MrbUIRWfWeNLZBl35OpkSgtYYd2VYDTGSrxZjEz2rmfBUCK1FRwpfXulZMIAQyalSwGQ
         dEfBfL26Jq7aR2SXUJChEcR7rtMQQ75EAKMkMcT6QY5jsgPMKiFmn/0iBgZj40WeqQDI
         3MgA==
X-Gm-Message-State: AMke39nSHqfeAf2WZS+xgYRcp8g0TFzo7v4OWthQmB0vQOwKf+rWNffAryoqdDMfIubaKQ==
X-Received: by 10.46.14.26 with SMTP id 26mr5190104ljo.76.1488235331563;
        Mon, 27 Feb 2017 14:42:11 -0800 (PST)
Received: from [192.168.1.26] (deg240.neoplus.adsl.tpnet.pl. [83.23.110.240])
        by smtp.googlemail.com with ESMTPSA id m7sm10754503ljb.24.2017.02.27.14.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 14:42:10 -0800 (PST)
Subject: Re: Reference for quote "creating branch is not the issue, merging
 is", in context of Subversion/Git
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        =?UTF-8?Q?Michael_H=c3=bcttermann?= <michael@huettermann.net>,
        git@vger.kernel.org
References: <c25bc18c-d599-93fd-0bad-23e1240e081e@huettermann.net>
 <32232f89-a6f8-be30-278a-bdfedae0716a@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a3960248-46c1-b814-13ef-cf8c0435be9a@gmail.com>
Date:   Mon, 27 Feb 2017 23:42:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <32232f89-a6f8-be30-278a-bdfedae0716a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.02.2017 o 16:19, Igor Djordjevic pisze:
> Hello Michael,
> 
> On 26/02/2017 12:40, Michael Hüttermann wrote:
>> Linus Torvalds made a statement regarding merging/branching and stated
>> (as far as I know) that "creating branch is not the issue, merge is", in
>> context of Subversion/Git.
>> I do not find the origin source for that. Can you please help and point
>> me to a statement or article where Linus elaborated on this?
> 
> Could it be that you think of "Tech Talk: Linus Torvalds on Git"[1]
> (held on May 3, 2007)?
> 
> To give you some clue, here`s an excerpt from Linus' talk/presentation
> (taken from the transcript[2] containing the whole thing):
> 
>   "... Subversion for example, talks very loudly about how they do CVS
>   right by making branching really cheap. It's probably on their main
>   webpage where they probably say branching in subversion is O(1)
>   operation, you can do as many cheap branches as you want. Nevermind
>   that O(1) is actually with pretty large O I think, but even if it
>   takes a millionth of a second to do branching, who cares? It's the
>   wrong thing you are measuring. Nobody is interested in branching,
>   branches are completely useless unless you merge them, and CVS cannot
>   merge anything at all. You can merge things once, but because CVS
>   then forgets what you did, you can never ever merge anything again
>   without getting horrible horrible conflicts. Merging in subversion is
>   a complete disaster. The subversion people kind of acknowledge this
>   and they have a plan, and their plan sucks too. It is incredible how
>   stupid these people are. They've been looking at the wrong problem
>   all the time. Branching is not the issue, merging is..."
> 
> This specific branch/merge performance talk starts at 50:20[3], where
> the part quoted above comes at 51:34[4].

Note also that while "creating branch is not the issue, merge is"
remains true, modern Subversion (post 1.5) makes merging easy thanks
to svn:mergeinfo property.

Though it does it in completely different way than Git and other
"graph of commits" VCS-es, because of the "branch is directory"
philosophy, namely that it keeps information about what was merged
in, rather than finding common ancestor(s) and using this information
for resolving merge.

> 
> Please note that there`s more context before and after this excerpt
> that puts it all into the meant perspective, so you may really want
> to watch/listen/read the whole thing anyway.
> 
> Regards,
> Buga
> 
> [1] https://www.youtube.com/watch?v=4XpnKHJAok8
> [2] https://git.wiki.kernel.org/index.php/LinusTalk200705Transcript
> [3] https://youtu.be/4XpnKHJAok8?t=3020
> [4] https://youtu.be/4XpnKHJAok8?t=3094
> 

