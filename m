Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0855DC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7951C21475
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="ZYgRfPjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQHnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:43:42 -0400
Received: from huan5.mail.rambler.ru ([81.19.78.4]:60878 "EHLO
        huan5.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 03:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=RgSeOHeEhEzsxa7dsEl6vuBCpSm6lYuCx4SxQ0TaAho=; b=ZYgRfPjEAqf3UImvmXzerKgi2u
        5vH8tccI8h2CXtNfIrJrt9Pr/fNXx1xLSngylFxEI1sQ/j+Oh3/P69Piw3YAnKU899LLRoLlvTczm
        LrlBheLGNv+T33IVPMF1ZVXlMQ/OaSnsU2sHnmzPT4whC6LaceV/uJE00uR3vJKWc2z0=;
Received: from [UNAVAILABLE] ([194.190.114.28]:38116 helo=localhost)
        by huan5.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlSjU-0008Pl-8Y
        for git@vger.kernel.org; Wed, 17 Jun 2020 10:43:40 +0300
Date:   Wed, 17 Jun 2020 10:45:21 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     Git <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200617074521.GA18445@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com>
 <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
 <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com>
 <20200616083405.GA17381@legohost>
 <CABPp-BGV-CVZ5swYNQpF-su3+yc1=P96g-tKxKtcrgvxhA+AYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGV-CVZ5swYNQpF-su3+yc1=P96g-tKxKtcrgvxhA+AYA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 12:33:18PM -0700, Elijah Newren wrote:
> Please stop.

ok, but what do you talk about, Elijah? Here ault men talk about serious
things. If you have something to say on the topic, you are welcome. You can do
it in any form - we will try to understand you. Otherwise, please don't waste
our time. The ethics club is elsewhere.

> Bringing up reasons why proposed changes would or even
> might cause harm are perfectly welcome, especially if details and
> examples can be provided.  (In fact, it would be a lot more helpful
> than simply asserting that the change would be very harmful.)  Name

Elijah, it would be a lot more helpful if you read the thread. Here
not only me already wrote about various reasons why this change is bad.
And we didn't see at least one technical reason why this is good.
Just politics speaches.

Two really important reasons:

1. This setting need to *very-very small* count of people.
2. The future default value of this setting will break *many* projects and
   people stable workflow.
 
So, why we need this? Because now one country have some *internal* troubles
(this is sad, but the code isn't to blame for this)? And why the whole world
need to suffer from this situation? I think some people here don't understand
the moment. Don't understand the consequences. This project is not your
personal project, Elijah. It isn't even american. Why billions of people
should to suffer? Because of white american's chauvinism? I think some people
here don't understand the responsibility to the world for their actions.

If anybody is intrested in git users opinion(not github PR-man or PR-man of
any other monster company), then he can simply read it here:

https://www.change.org/p/github-do-not-rename-the-default-branch-from-master-to-main

> Emails like this one from you are not wanted and not welcome within
> this project.  Please go read the project's Code of Conduct
> (https://git.kernel.org/pub/scm/git/git.git/tree/CODE_OF_CONDUCT.md)

Elijah, my english is bad, i can't understand this document. Sorry. I think
this is a discrimination of non-english speakers. Why no translations?


-- 
Олег Неманов (Oleg Nemanov)
