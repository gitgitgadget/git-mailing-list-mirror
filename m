Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F4D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdHJSSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:18:42 -0400
Received: from [195.159.176.226] ([195.159.176.226]:34494 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbdHJSSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:18:32 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dfs2I-0006B4-Kg
        for git@vger.kernel.org; Thu, 10 Aug 2017 20:18:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: Re: Not understanding with git wants to copy one file to another
Date:   Thu, 10 Aug 2017 14:18:12 -0400
Organization: Still searching...
Message-ID: <87efsj70d7.fsf@local.lan>
References: <87mv7773tp.fsf@local.lan>
        <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:q5oFhYxCd/NhsTZB5CJ6/h8ZOO8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Aug 10, 2017 at 10:03 AM, Harry Putnam <reader@newsguy.com> wrote:

[...]

Harry wrote:
>> Here are two that are at least kind of similar but would never be seen
>> as the same:
>>
>> < 192.168.1.43      m2.local.lan       m2       # 00-90-F5-A1-F9-E5
>>> 192.168.1.43    m2.local.lan        m2         # win 7

 Stefan B replied:
> The diff machinery has a threshold for when it assumes
> a copy/move of a file. (e.g. "A file is assumed copied when
> at least 55% of lines are equal")
>
> https://git-scm.com/docs/git-diff
>
> See -C and -M option.
>
> git-status seems to use this machinery as well, but does
> not expose the options?

Well, now I'm even more confused.  What actually happens? Is either
file changed? Is only one file kept?

On the surface it sounds like complete anathema to what git is all
about.

However, I know a tool this sophisticated is not doing something just
outright stupid... so must be really missing the point here.

I get the way you can make -M stricter or not... but I didn't call
git-diff to see that copy thing comeup.

I called git commit.

There must be some way to set stricter guidlines to calling things
copies.

But then I must really not get it because it still seems almost silly
to consider one file a copy of another if only 55% is the same.

What am I missing?



