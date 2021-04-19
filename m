Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF8C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8236100B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhDSM5Q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Apr 2021 08:57:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63569 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbhDSM5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 08:57:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13JCuckW072476
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Apr 2021 08:56:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>
Cc:     <avarab@gmail.com>, <jrnieder@gmail.com>, <albertcui@google.com>,
        <gitster@pobox.com>, <matheus.bernardino@usp.br>
References: <YHofmWcIAidkvJiD@google.com>
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
Subject: RE: RFC/Discussion - Submodule UX Improvements
Date:   Mon, 19 Apr 2021 08:56:32 -0400
Message-ID: <00dc01d7351b$6ffc6500$4ff52f00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJbFLMgoJsVHqAp1Cmec2AAO4rv5am0C1yw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Emily Shaffer <emilyshaffer@google.com>
On April 16, 2021 7:37 PM, Emily Shaffer wrote:
> As hinted by a couple recent patches, I'm planning on some pretty big
> submodule work over the next 6 months or so - and Ævar pointed out to me
in
> https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I
> probably should share some of those plans ahead of time. :) So attached is
a
> lightly modified version of the doc that we've been working on internally
at
> Google, focusing on what we think would be an ideal submodule workflow.
> 
> I'm hoping that folks will get a chance to read some or all of it and let
us know
> what sounds cool (or sounds extremely broken). The best spot to start is
> probably the "Overview" section, which describes what the "main path"
would
> look like for a user working on a project with submodules. Most of the
work
> that we're planning on doing is under the "What doesn't already work"
> headings.
> 
> Thanks in advance for any time you spend reading/discussing :)
<big snip>

Just adding my voice here, this is something my teams would be very happy to
consider.

> - Worktrees
> When a user runs 'git worktree add' from the superproject, each submodule
>  in the new worktree should also be created as a worktree of the
corresponding
>  submodule in the original project.
> What doesn't already work:
>   * worktrees and submodules getting along - submodules are now freshly
cloned
>     when creating a superproject worktree

My teams are currently debating the use of submodules (we have gone back and
forth over the years on these) and worktrees (which seem to have some
positive process implications for those more legacy-ish team members more
used to a centralised workflows). I have not seen any worktree/submodule
combinations used but fear the worst - as in I'm pretty sure I know which of
my team members is going to try this. It is probably a separate matter to
make the two get along better.

Cheers,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



