Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF4D1F461
	for <e@80x24.org>; Fri, 17 May 2019 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfEQUyY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 16:54:24 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:39626 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfEQUyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 16:54:24 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id RjrxhUPr6WIpcRjrxhz2k3; Fri, 17 May 2019 21:54:21 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=PEGwgbONAaU5ZfBYytcA:9 a=QEXdDO2ut3YA:10
Subject: Re: How to update Git's metadata without affecting working dir?
To:     Rocky Ji <rockyji3438@gmail.com>, git@vger.kernel.org
References: <CAN2Gq-Rb3v8-8PKmKUGKJ3wP-UvAF2n59a9UGbtjiGibE8q=zg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <b3e170ed-ca5f-c754-892a-d11d4b71d989@iee.org>
Date:   Fri, 17 May 2019 21:54:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAN2Gq-Rb3v8-8PKmKUGKJ3wP-UvAF2n59a9UGbtjiGibE8q=zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfMN+C9FLz+qPlnyXcLsq/GZvJbYtHWGvSBpRdUxgJ0oFFWZQvBaxmejcE1f3EsVNSQ37YgTB1hDjoFpTJsgN2mQsaR2bQ9lLJEjfEbphhCI9A8n+iJOe
 Ag/Y339dIsKlixEfeoYTMYKPjFsh1SjM9qaIrF4xQvSojg+yjFSG40yTrPbMYL+rBx4dcjcD6qBe6tyL8JzSLJK5ctDiVUKZW1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a duplicate of a question on the Git Users list.

On 17/05/2019 18:04, Rocky Ji wrote:
> I am working individually at the moment.
> I have the habit of committing related changes on a regular basis, but
> I push to GitLab only at the end of class session.
>
> -------Events to reproduce the situation--------
>
> Thursday, in school:
> - `git clone https://gitlab.../my-repo`
> - create a few .rst documentation files
> - commit the above changes before I `git push -U origin master`
>
> Friday, in school:
> - start working on new feature, create a test file `test_A.rb`
> - I commit the changes but forget to push
>
> Sunday, **in home**:
> - I `git clone https://gitlab.../my-repo`
> - work on the exciting new feature that popped in my head, create `feature.rb`
> - commit the changes before I `git push -U origin master`
>
> Monday, in school:
> - running `git status` shows `Your branch is ahead of 'origin/master'
> by 1 commit.`
>
> --------end problem reproduction----------------
>
> Questions I have
>
> 1. What will happen if I follow Git's recommendation `use "git push"
> to publish your local commits`?
> 2. How do I resolve this situation? I don't want loose any information
> i.e. preserve `test_A.rb` and `feature.rb` along with their commit
> messages and timestamps.
> 3. Why does Git assume that local-working-dir is "ahead" without
> consulting the Gitlab server first?
> 4. How to make Git "consult" (but not mess the working-dir) GitLab
> repo before starting my day's work?
>
> Thank you.

