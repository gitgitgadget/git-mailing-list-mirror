Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72106C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277DC207E8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgKJOEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:04:33 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:58383 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgKJOEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 09:04:33 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kcUG0-000Bln-Cj; Tue, 10 Nov 2020 14:04:25 +0000
Subject: Re: Extending and updating gitglossary
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
 <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
 <85pn4tnk8u.fsf@gmail.com> <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
 <xmqqtuu3k6jf.fsf@gitster.c.googlers.com> <85zh3ujq9c.fsf_-_@gmail.com>
 <8d43335d-a0b4-511e-f132-057343234503@iee.email> <85imaej8nh.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8b6d49e3-fdb8-ce63-650e-c937a2da2c7a@iee.email>
Date:   Tue, 10 Nov 2020 14:04:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <85imaej8nh.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On 10/11/2020 01:35, Jakub Narębski wrote:
> Hello Philip,
>
> Philip Oakley <philipoakley@iee.email> writes:
>> On 06/11/2020 18:26, Jakub Narębski wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>> Philip Oakley <philipoakley@iee.email> writes:
>>>>
>>>>> This may be not part of the the main project, but could you consider, if
>>>>> time permits, also adding some entries into the Git Glossary (`git help
>>>>> glossary`) for the various terms we are using here and elsewhere, e.g.
>>>>> 'topological levels', 'generation number', 'corrected commit date' (and
>>>>> its fancy technical name for the use of date heuristics e.g. the
>>>>> 'chronological ordering';).
>>>>>
>>>>> The glossary can provide a reference, once the issues are resolved. The
>>>>> History Simplification and Commit Ordering section of git-log maybe a
>>>>> useful guide to some of the terms that would link to the glossary.
>>>> Ah, I first thought that Documentation/rev-list-options.txt (which
>>>> is the relevant part of "git log" documentation you mention here)
>>>> already have references to deep technical terms explained in the
>>>> glossary and you are suggesting Abhishek to mimic the arrangement by
>>>> adding new and agreed-upon terms to the glossary and referring to
>>>> them from the commit-graph documentation updated by this series.
>>>>
>>>> But sadly that is not the case.  What you are saying is that you
>>>> noticed that rev-list-options.txt needs a similar "the terms we use
>>>> to explain these two sections should be defined and explained in the
>>>> glossary (if they are not) and new references to glossary should be
>>>> added there" update.
> What terms you feel need glossary entry?
While it was Junio that made the comment, I'd agree that we should be
using the glossary to explain, in a general sense, the terms that are
used is a specialist sense. As the user community expands, their natural
understanding of some of the terms diminishes.
>
>>>> In any case, that is a very good suggestion.  I agree that updating
>>>> "git log" doc may be outside the scope of Abhishek's theme, but it
>>>> would be very good to have such an update by anybody ;-)
>>> The only possible problem I see with this suggestion is that some of
>>> those terms (like 'topological levels' and 'corrected commit date') are
>>> technical terms that should be not of concern for Git user, only for
>>> developers working on Git.  (However one could encounter the term
>>> "generation number" in `git commit-graph verify` output.)
> To be more precise, I think that user-facing glossary should include
> only terms that appear in user-facing documentation and in output
> messages of Git commands (with the possible exception of maybe output
> messages of some low-level plumbing).
And where implied, the underlying concepts when they aren't obvious, or
lack general terms (e.g. the 'staging area' discussions)
>
> I think that the developer-facing glossary should include terms that
> appear in technical documentation, and in commit messages in Git
> history.
>
>> However we do mention "topolog*"  in a number of the manual pages, and
>> rather less, as yet, in the technical pages.
>>
>> "Lexicographic" and "chronological" are in the same group of fancy
>> technical words ;-)
> I think that 'topological level' would appear only in technical
> documentation; if it would be the case then there is no reason to add it
> to user-facing glossary (to gitglossary manpage).
>
> 'Topological order' or 'topological sort', 'lexicographical order' and
> 'chronological order' are not Git-specific terms, and there are no
> Git-specific ambiguities.  I am therefore a bit unsure about adding them
> to *Git* glossary.

It is that they aren't terms used in normal speech, so many folks do not
comprehend the implied precision that the docs assume, nor the problems
they may hide.
>
> - In computer science, a _topological sort_ or _topological_ ordering of
>   a directed graph is a linear ordering of its vertices such that for
>   every directed edge uv from vertex u to vertex v, u comes before v in
>   the ordering.
Does this imply that those who aren't computer scientists shouldn't be
using Git?
>
>   For Git it means that top to bottom, commits always appear before
>   their parents. With `--graph` or `--topo-order` Git also avoids
>   showing commits on multiple lines of history intermixed.
>
> - In mathematics, the _lexicographic_ or _lexicographical order_ (also
>   known as lexical order, dictionary order, etc.) is a generalization of
>   the alphabetical order.
>
>   For Git it is simply alphabetical order. 
ASCII order, Case sensitivity, Special characters, etc.
>
> - _Chronological order_ is the arrangement of things following one after
>   another in time; or in other words date order.
Given that most  résumés (the thing most folk see that asks for date
order) is latest first, does this clarify which way chronological is? (I
see this regularly in my other volunteer work).
>
>   Note that `git log --date-order` commits also always appear before
>   their parents, but otherwise commits are shown in the commit timestamp
>   order (committer date order)

>
>>> I don't think adding technical terms that the user won't encounter in
>>> the documentation or among messages that Git outputs would be not a good
>>> idea.  It could confuse users, rather than help them.
>>>
>>> Conversely, perhaps we should add Documentation/technical/glossary.txt
>>> to help developers.
>> I would agree that the Glossary probably ought to be split into the
>> primary, secondary and background terms so that the core concepts are
>> separated from the academic/developer style terms.
> I don't thing we need three separate layers; in my opinion separating
> terms that user of Git might encounter from terms that somebody working
> on developing Git may encounter would be enough.
>
> The technical glossary / dictionary could also help onboarding...
>
>> Git does rip up most of what folks think about version "control",
>> usually based on the imperfect replication of physical artefacts.
> I don't quite understand what you wanted to say there.  Could you
> explain in more detail, please?
Background, I see Git & Version Control from an engineers view point,
rather than developers view.

In the "real" world there are no perfect copies, we serialise key items
so that we can track their degradation, and replace them when required.
We attempt to "Control" what is happening. Our documentation and
monitoring systems have layers of control to ensure only suitably
qualified persons may access and inspect critical items, can record and
access previous status reports, etc. There is only one "Mona Lisa", with
critical access controls, even though there are 'copies'
https://en.wikipedia.org/wiki/Mona_Lisa#Early_versions_and_copies.
Almost all of our terminology for configuration control comes from the
'real' world, i.e. pre-modern computing.

Git turns all that on its head. We can make perfect duplicates (they're
not copies, not replicas..). The Object name is immutable. It's either
right or wrong (exempt the SHAttered sha-1 breakage; were moving to
sha-256). Git does *not* provide any access control. It supports the
'software freedoms' by distributing the control to the user. The
repository is a version storage system, and the OIDs allow easy
authentication between folks that they are looking at the same object,
and all its implied descendants.

Git has ripped up classical 'real' world version control. In many areas
we need new or alternative terms, and documents that explain them to
screen writers(*) and the many other non CS-major users of Git (and some
engineers;-)

(*) there's a diff pattern for them, IIRC, or at least one was proposed.
>
>>> P.S. By the way, when looking at Documentation/glossary-content.txt, I
>>> have noticed few obsolescent entries, like "Git archive", few that have
>>> description that soon could be or is obsolete and would need updating,
>>> like "master" (when default branch switch to "main"), or "object
>>> identifier" and "SHA-1" (when Git switches away from SHA-1 as hash
>>> function).
>> The obsolescent items can be updated. I'm expecting that the 'main' and
>> 'SHA-' changes will eventually be picked up as part of the respective
>> patch series, hopefully as part of the global replacements.
> Here I meant that "Git archive" entry is not important anymore, as I
> think there are no active users of GNU arch version control system (no
> "arch people"); arch's last release was in 2006, and its replacement,
> Bazaar (or 'bzr') doesn't use this term. So I think it can be safely
> removed in 2020, after 14 years after last release of arch.
>
> In most cases "SHA-1" in the descriptions of terms in glossary should be
> replaced by "object identifier" (to be more generic).  This can be
> safely done before switch to NewHash is ready and announced.
>
> Best,
--
Philip
