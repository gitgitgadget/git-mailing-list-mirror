Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E527C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 18:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiAOS3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 13:29:20 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:36346 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbiAOS3T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 13:29:19 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n8nni-0002uK-9m;
        Sat, 15 Jan 2022 18:29:18 +0000
Message-ID: <c9cd9e57-c9d0-63a4-d533-cbd141cf095b@iee.email>
Date:   Sat, 15 Jan 2022 18:29:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Fwd: [gitgitgadget/git] README.md: add CodingGuidelines and a link
 for Translators (PR #1115)
Content-Language: en-GB
References: <55336cbf-9915-27fc-82ca-8e85c8320199@iee.email>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <55336cbf-9915-27fc-82ca-8e85c8320199@iee.email>
X-Forwarded-Message-Id: <55336cbf-9915-27fc-82ca-8e85c8320199@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Dscho pointed out I should reply to the list not GGG. Hope this works

-------- Forwarded Message --------
Subject: 	Re: [gitgitgadget/git] README.md: add CodingGuidelines and a
link for Translators (PR #1115)
Date: 	Sat, 15 Jan 2022 10:45:43 +0000
From: 	Philip Oakley <philipoakley@iee.email>
To: 	gitgitgadget/git
<reply+AAG7HJ4LJ4YFCNJJ6NT7PPF75X5VTEVBNHHEDSVTJA@reply.github.com>,
gitgitgadget[bot] <notifications@github.com>, gitgitgadget/git
<git@noreply.github.com>
CC: 	Mention <mention@noreply.github.com>



On 15/01/2022 00:50, gitgitgadget[bot] wrote:
> On the Git mailing list
> <https://lore.kernel.org/git/xmqqv8yl6d0f.fsf@gitster.g>, Junio C
> Hamano wrote (reply to this
> <https://github.com/gitgitgadget/gitgitgadget/wiki/ReplyToThis>):
>
> Philip Oakley <philipoakley@iee.email> writes: > Unfortunately it `[]`
> is not working for me for the new additions. > GitHub magic? Let's
> step back a bit. Is there somebody reading README.md as a more generic
> MarkDown? I do not think our build procedure creates any rendered
> document from it.
GitHub will auto render the README.md at the bottom of the git.git home
page, and will render any .md files when they are visited. I just
checked GitLab which looks to do the same rendering.

I prepared the changes because of a user question on the "Git for Human
Beings" git-users list
https://groups.google.com/d/msgid/git-users/aa68b9c8-4cf4-4193-8af3-79d7e3feafbbn%40googlegroups.com
about some linter issues with C99 and an offer to help.

Despite having answered such questions before it still took a while to
find the right pointers for the user, hence the proposed clarifications.

> My recollection was that we moved from README.txt to README.md for the
> sole purpose of showing it https://github.com/git/git/ as more than
> just a plain text, so it is a hard requirement that GitHub flavored
> MarkDown renderer is happy with whatever we write in the file. If
> GitHub flavored MarkDown only supports [] and breaks with (), then
> there is no need for further discussion. We must stick to [] that has
> been working for us in the file. On the other hand, if both () and []
> work well at GitHub, I am OK to replace [] to (), so that it shows
> well at GitHub and also it can be used with other MarkDown renderers.

Oddly it appears that the [] was only working for the original text, but
that () was needed for my new text. I'm not able to explain why, but
didn't want too much churn within the patch.

> I prefer, from the organizational point of view, to see two patches,
> in this order, if we were to go that way. [PATCH 1/2] README: link to
> more contributor documents which uses [] (not ()). After this,
> README.md uses only [], including the two links you add in this step.
> And then [PATCH 2/2] README: use "()", not "[]", to please more
> MarkDown processors which replaces all uses of [] with (). That would
> allow us to queue both, try them out, and we can back out [2/2] if
> GitHub's renderer does not like the result.
Already been there. GitHub would only render the old text as links when
I pushed to my repo and viewed the README.md in my browser, so 2/2 would
need to go first, but without any obvious need...

I was hoping someone might know why? It feels very screwy to me.
---

follow up
I'll redo the series as
1/2 : use "()", not "[]", to please Markdown processors
2/2 : README: link to more contributor documents
