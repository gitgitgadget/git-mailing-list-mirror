Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0FE1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeCZMmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:42:11 -0400
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:39486 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751174AbeCZMmK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Mar 2018 08:42:10 -0400
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01a-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1f0RRl-0005B3-N5; Mon, 26 Mar 2018 14:42:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id EF69460FA7;
        Mon, 26 Mar 2018 14:41:56 +0200 (CEST)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6oZ9R4tEEc_Y; Mon, 26 Mar 2018 14:41:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 0030660F89;
        Mon, 26 Mar 2018 14:41:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6aC8hNC9pryA; Mon, 26 Mar 2018 14:41:55 +0200 (CEST)
Received: from moylip (dhcp-13-119.lip.ens-lyon.fr [140.77.13.119])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 286A160FA7;
        Mon, 26 Mar 2018 14:41:53 +0200 (CEST)
References: <20180323085636.GA24416@sigill.intra.peff.net> <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com> <20180326081036.GA18714@sigill.intra.peff.net>
User-agent: mu4e 1.0; emacs 24.5.1
From:   git@matthieu-moy.fr
To:     Jeff King <peff@peff.net>
Cc:     Aaron Greenberg <p@aaronjgreenberg.com>, git@matthieu-moy.fr,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] branch: implement shortcut to delete last branch
In-reply-to: <20180326081036.GA18714@sigill.intra.peff.net>
Date:   Mon, 26 Mar 2018 14:41:49 +0200
Message-ID: <86r2o7nh4i.fsf@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5rUJsVprZGgveFZVYihIVyN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0exmmFiHB7avpoopFHkMnEcVOsiN+cJA5OG37cU6C+FlP8ay4xbplgLY6IV/n/aa98s
 JlGnLI8YwLCaizEvfGy3iRH5H1NZZ9a093+cpLAhZOFbSD3u8HyLgGOQKCi94WQ9PORkrfOthgRd
 Qb0exFfilbHtbFYVmmyNP/jzd7CC6hBx0MWsIqDBZyeY119OkrYm3pJKSVRBN+I5nGXeFBhR7KZT
 JJG/1QRnwAzHw/oJ71MrvcKT3OLEBfHO5lAWu7aSbNMfDZ116RqRx3EC702SiTAX5EzOJCY6Pi9Z
 4E/rf0cnVwbwxyMyZnCDJmCieRLZ8URFrivgdwjOQrRU+1Ge/OnGwtjMKtidReTfBdor2F6m4Pfu
 bH3ZJ97oDfyklYWgtkyaRaxq6tVl++pE5oOcO0dvzPl2k+QS4nxKfCqVGp1M/P71l2+KHsw09jT1
 Z67bBsjMdijZeyDE3ECgL33n9XVroYRVFMZL2VzRYXaTv/CPV84KuuMSDkiKym8LD0JaIU5yJDQe
 C13k2HN9fQ5zHDeqqFz43py4SDhdaHkWssajzpjZWFLqOdluSrWAyQmSOYSemIdOmN9X670ITwR/
 UgNvrtB9bsmpsF+4iM69qJiUYEsSaqMUwH0+iNjyCZYJ7RAFswEcFH7rJLbjpKKBuz5bllaTjk+C
 zO9xnXyYSBMAiUpwfunvhqooUg076ijRhrgM8WxzPlTstF3NxW2KMocoEKq5mAVr+rmh1Zt/HX17
 Qxx9YYWGOowrAI2hr7Sw8qqAnKUkBPG6kfvhB9Ahu1/rdU1t/SWu+yxj6TsASx82jXwiERsw3+C8
 klxvJiqHrJ+RfComsJFdhSHVgOsYBG5BLm7+k//sHeY7X7HLSbHJWR8MgJZ2TDgUJQ5pFgyARfBL
 GQ9unhVZ7R0yfx2pvxXZOQJ8rt7HFGNV1P5zrtsGyMx2KNl7IMTcQKAvfcfw8GRayCj1nt8Z9AjG
 E+NWkNbgdZf7qeZ58fEgU/LmElpuAl3CsSvydZb2tqff/DEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for Cc-ing me, and sorry for not being very responsive these
days :-\.

Jeff King writes:

> On Fri, Mar 23, 2018 at 10:40:34PM +0000, Aaron Greenberg wrote:
>
>> I can appreciate Matthieu's points on the use of "-" in destructive
>> commands. As of this writing, git-merge supports the "-" shorthand,
>> which while not destructive, is at least _mutative_. Also,
>> "git branch -d" is not destructive in the same way that "rm -rf" is
>> destructive since you can recover the branch using the reflog.
>
> There's a slight subtlety there with the reflog, because "branch -d"
> actually _does_ delete the reflog for the branch. By definition if
> you've found the branch with "-" then it was just checked out, so you at
> least have the old tip. But the branch's whole reflog is gone for good.
>
> That said, I'd still be OK with it.

I don't have objection either.

Anyway, we're supporting this "-" shortcut in more and more commands
(partly because it's a nice microproject, but it probably makes sense),
so the "consistency" argument becomes more and more important, and is
probably more important than the (relative) safety of not having the
shortcut.

>> One thing to consider is that approval of this patch extends the
>> implementation of the "-" shorthand in a piecemeal, rather than
>> consistent, way (implementing it in a consistent way was the goal of
>> the patch set you mentioned in your previous email.) Is that okay? Or
>> is it better to pick up the consistent approach where it was left?
>
> I don't have a real opinion on whether it should be implemented
> everywhere or not. But IMHO it's OK to do it piecemeal for now either
> way, unless we're really sure it's time to move to respecting it
> everywhere. Because we can always convert a
> piecemeal-but-covers-everything state to centralized parsing as a
> cleanup.

Not sure whether it's already been mentionned here, but a previous
attempt is here:

  https://public-inbox.org/git/1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com/

My understanding is that the actual code is quite straightforward, but
1) it needs a few cleanup patches to be done correctly, and 2) there are
corner-cases to deal with like avoiding a commit message like "merge
branch '-' into 'foo'". Regarding 2), any piecemeal implementation with
proper tests is a step in the right direction.

--
Matthieu Moy
https://matthieu-moy.fr/
