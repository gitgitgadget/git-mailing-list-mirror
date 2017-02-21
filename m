Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13872201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 15:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbdBUPzb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 10:55:31 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:35924 "EHLO
        homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752253AbdBUPzV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 10:55:21 -0500
Received: from homiemail-a6.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id EBB5559807D
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:content-type; s=bit-booster.com; bh=ShKRi18oRJ6r3LmvFkZYTao/
        Ntk=; b=hT4qOiBBDh4CroaAKOq6B93zdPHBZARsS24gbDAIznceN7xgSG+E8/KX
        1o728A3YGya7AYiuSPErbAlwwMWN+/SdFlv6d/0PeZwnEeMBOTBcc7fyyeiJ05RL
        7NgVNlXyLIG1Ih3SCVD0Caa2fOI9/lP8EcCwVJ7mQ9v+XUSrI94=
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com [209.85.214.48])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a6.g.dreamhost.com (Postfix) with ESMTPSA id CC585598074
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 07:55:19 -0800 (PST)
Received: by mail-it0-f48.google.com with SMTP id 203so47959350ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 07:55:19 -0800 (PST)
X-Gm-Message-State: AMke39n6rBlvYVQi8HjBeLdqcYFRKgBXfYWMJKF5LUO0q2fAbQIArYOdHmd9XOz79bgPi1fsqCu/sYEKvwzEnA==
X-Received: by 10.107.6.215 with SMTP id f84mr20545541ioi.210.1487692515921;
 Tue, 21 Feb 2017 07:55:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.16.83 with HTTP; Tue, 21 Feb 2017 07:55:15 -0800 (PST)
In-Reply-To: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Tue, 21 Feb 2017 07:55:15 -0800
X-Gmail-Original-Message-ID: <CAAj3zPzrD+R6kDdqR3C7aYTDjaE+Y5zN+MfoXe5EuH4ZPxroHA@mail.gmail.com>
Message-ID: <CAAj3zPzrD+R6kDdqR3C7aYTDjaE+Y5zN+MfoXe5EuH4ZPxroHA@mail.gmail.com>
Subject: Re: Git trademark status and policy
To:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2017 at 6:26 PM, Jeff King <peff@peff.net> wrote:
> As many of you already know, the Git project (as a member of Software
> Freedom Conservancy) holds a trademark on "Git".  This email will try to
> lay out a bit of the history and procedure around the enforcement of
> that trademark, along with some open questions about policy.
>
> I'll use "we" in the text below, which will generally mean the Git
> Project Leadership Committee (PLC). I.e., the people who represent the
> Git project as part of Conservancy -- me, Junio Hamano, and Shawn
> Pearce.
>
> We approached Conservancy in Feb 2013 about getting a trademark on Git
> to ensure that anything calling itself "Git" remained interoperable with
> Git. Conservancy's lawyer drafted the USPTO application and submitted it
> that summer. The trademark was granted in late 2014 (more on that delay
> in a moment).
>
> Concurrently, we developed a written trademark policy, which you can
> find here:
>
>   https://git-scm.com/trademark
>
> This was started from a template that Conservancy uses and customized by
> Conservancy and the Git PLC.
>
> While the original idea was to prevent people from forking the
> software, breaking compatibility, and still calling it Git, the policy
> covers several other cases.
>
> One is that you can't imply successorship. So you also can't fork the
> software, call it "Git++", and then tell everybody your implementation
> is the next big thing.
>
> Another is that you can't use the mark in a way that implies association
> with or endorsement by the Git project. To some degree this is necessary
> to prevent dilution of the mark for other uses, but there are also cases
> we directly want to prevent.
>
> For example, imagine a software project which is only tangentially
> related to Git. It might use Git as a side effect, or might just be
> "Git-like" in the sense of being a distributed system with chained
> hashes. Let's say as an example that it does backups. We'd prefer it
> not call itself GitBackups. We don't endorse it, and it's just using the
> name to imply association that isn't there. You can come up with similar
> hypotheticals: GitMail that stores mailing list archives in Git, or
> GitWiki that uses Git as a backing store.
>
> Those are all fictitious examples (actually, there _are_ real projects
> that do each of those things, but they gave themselves much more unique
> names). But they're indicative of some of the cases we've seen. I'm
> intentionally not giving the real names here, because my point isn't to
> shame any particular projects, but to discuss general policy.
>
> Careful readers among you may now be wondering about GitHub, GitLab,
> Gitolite, etc. And now we get back to why it took over a year to get the
> trademark granted.
>
> The USPTO initially rejected our application as confusingly similar to
> the existing trademark on GitHub, which was filed in 2008. While one
> might imagine where the "Git" in GitHub comes from, by the time we
> applied to the USPTO, both marks had been widely used in parallel for
> years.  So we worked out an agreement with GitHub which basically says
> "we are mutually OK with the other trademark existing".
>
> (There was another delay caused by a competing application from a
> proprietary version control company that wanted to re-brand portions of
> their system as "GitFocused" (not the real name, but similar in spirit).
> We argued our right to the name and refused to settle; they eventually
> withdrew their application).
>
> So GitHub is essentially outside the scope of the trademark policy, due
> to the history. We also decided to explicitly grandfather some major
> projects that were using similar portmanteaus, but which had generally
> been good citizens of the Git ecosystem (building on Git in a useful
> way, not breaking compatibility). Those include GitLab, JGit, libgit2,
> and some others. The reasoning was generally that it would be a big pain
> for those projects, which have established their own brands, to have to
> switch names. It's hard to hold them responsible for picking a name that
> violated a policy that didn't yet exist.
>
> If the "libgit2" project were starting from scratch today, we'd probably
> ask it to use a different name (because the name may imply that it's an
> official successor). However, we effectively granted permission for this
> use and it would be unfair to disrupt that.
>
> There's one other policy point that has come up: the written policy
> disallows the use of "Git" or the logo on merchandise. This is something
> people have asked about it (e.g., somebody made some Git stress balls,
> and another person was printing keycaps with a Git logo). We have always
> granted it, but wanted to reserve the right in case there was some use
> that we hadn't anticipated that would be confusing or unsavory.
>
> Enforcement of the policy is done as cases are brought to the attention
> of Conservancy and the Git PLC. Sometimes people mail Conservancy
> directly, and sometimes a use is noticed by the Git PLC, which mails
> Conservancy.  In either case, Conservancy's lawyer pings the Git PLC,
> and we decide what to do about it, with advice from the lawyer. The end
> result is usually a letter from the lawyer politely asking them to stop
> using the trademark.
>
> So how does the Git PLC make decisions? We generally try to follow the
> policy in an equitable way, but there are a lot of corner cases. Here
> are some rules of thumb we've worked out:
>
>   - Things that are only tangentially related to Git are out of policy
>     (e.g., if you had a service which rewards bitcoin for people's
>     commits, we'd prefer it not be branded GitRewards).
>
>   - Anything that claims to be Git but does not interoperate is out.
>     We haven't had to use that one yet.
>
>   - Portmanteaus ("GitFoo" or "FooGit") are out. Most of the cases run
>     into this rule. For instance, we asked GitHub to not to use "DGit"
>     to refer to their replicated Git solution, and they[1] rebranded.
>     We also asked "GitTorrent" not to use that name based on this rule.
>
>   - Commands like "git-foo" (so you run "git foo") are generally OK.
>     This is Git's well-known extension mechanism, so it doesn't really
>     imply endorsement (on the other hand, you do not get to complain if
>     you choose too generic a name and conflict with somebody else's use
>     of the same git-foo name).
>
>   - When "git-foo" exists, we've approved "Git Foo" as a matching
>     project name, but we haven't decided on a general rule to cover this
>     case.  The only example here is "Git LFS".
>
> So that's more or less where we're at now.  In my opinion, a few open
> questions are:
>
>   1. Is the portmanteau clause a good idea? GitTorrent is a possibly
>      interesting case there. It's an open source project trying to
>      make a torrent-like protocol for Git. That's something we'd like to
>      have happen. But does the name imply more endorsement than we're
>      willing to give (especially at an early stage)?
>
>   2. Is it a problem that the grandfathering of some names may create a
>      branding advantage? Under the policy today, we wouldn't grant
>      "GitHub" or "GitLab". Does that give an unfair advantage to the
>      incumbents?
>
>      I think the answer is "yes", but the Git PLC is also not sure that
>      there is a good solution. If we'd thought about trademark issues
>      much earlier, we would have been in different circumstances and
>      probably would have made different decisions. But we didn't, so we
>      have to live with how things developed in the meantime.
>
>      Loosening now would be a mistake as it would cause a lot of
>      confusion around the trademark and make it harder for us to stop
>      the uses that we really care about stopping now.
>
>   3. Was granting "Git LFS" the right call? I think the project is a good
>      one and has worked well with the greater Git community. But I think
>      the name has implied some level of "officialness". We obviously
>      need to allow "git-lfs" as a name. But should the policy have said
>      "you can call this LFS, and the command is git-lfs, but don't say
>      'Git LFS'". I'm not sure.
>
>      One option would have been to ask "git-foo" to prefer "Foo for Git"
>      instead of "Git Foo" in their branding (it's too late now for "Git
>      LFS", so this is a hypothetical question for future requests now).
>
>   4. I think the merchandise clause has worked fine, and in general the
>      plan is to grant it in most cases. I have trouble thinking of an
>      item I _wouldn't_ want the Git logo on, and I'd rather err on the
>      side of permissiveness than be the arbiter of taste. And having the
>      Git logo on merchandise generally raises awareness of Git.
>
>      But perhaps people have stronger opinions (either about the type of
>      item, or perhaps the practices of the manufacturer producing it).
>      It's hard to predict how a particular item would impact how people
>      see the Git brand.
>
> -Peff
>
> [1] I used "they" to refer to GitHub, but as many of you know, I am also
>     employed by GitHub. If you are wondering how that works, I generally
>     abstain from any decisions regarding GitHub (and that includes the
>     "Git LFS" decision, which was a project started by GitHub). That
>     leaves two voting PLC members for those decisions; Conservancy gets
>     a tie-breaking vote, but it has never come up.



Is "Gitter" allowed?   (https://gitter.im/).

More info here:

https://en.wikipedia.org/wiki/Gitter

Also, their twitter handle is @gitchat.

Not sure I'd even classify "gitter" as a portmanteau.



- Sylvie
