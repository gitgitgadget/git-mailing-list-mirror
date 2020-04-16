Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FEBC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71EF21BE5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYOnikQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgDPTgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:36:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52627 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgDPTgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 15:36:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 372BAB4235;
        Thu, 16 Apr 2020 15:36:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nd0dW7dURR2IlfPRzBpPqiuNtyM=; b=NYOnik
        Qt+mAxht33nbSjN3cMjHrHQeyhYX+fjrW+BoYrRyJGS7gdPbQ5vv4WUp+wrKJAIy
        clPIoO872K7WdqhZFVfZrCAIZIdE7Hrzy2SFOc7JxEF4JBJWccrOgvqZFjrAHOl5
        hd9UY3PpSa1EvG2xvuQm6dFq3QXIM2doBWHbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uk1Iit3L9xu6H3E13s9e+8O1FaeCm7cQ
        vK/xb2dDgEy1lZROS9SnVAPQvFDxAAUnr2apQ6uhc3d5V1PXi+/OybdqEhRIb6nC
        GqEPIe+tyMAWoqNCiVwpqcqe+w9f+YWEpRtnMiDaIRjWrryKWM05r1JgisZNxFZR
        OMqsUgcRpyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EB9EB4234;
        Thu, 16 Apr 2020 15:36:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ADA0B4232;
        Thu, 16 Apr 2020 15:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
        <20200413140918.4778-2-shouryashukla.oo@gmail.com>
Date:   Thu, 16 Apr 2020 12:36:06 -0700
In-Reply-To: <20200413140918.4778-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 13 Apr 2020 19:39:18 +0530")
Message-ID: <xmqq5zdzz0ih.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84F32690-8019-11EA-B915-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +[[checking-out]]

> +What is checking out a commit/branch? How do I perform one?::

> +	In Git terminology, a 'checkout' serves three purposes, namely:

Well, whoever is asking the question knows what s/he wants to do is
to check out a commit/branch and not "grab a version of files from
different tree", so this is answering a question that is not asked.

Teaching the distinction of two kinds of checkout [*] may be
important, but then we should do so by answering a different
question ;-)

	Side note.  There are not three but two variants.  There is
	no conceptual difference between checking out a branch and
	moving to detached HEAD.  They are both to prepare extending
	the history that led to the commit (either the commit that
	was checked out, or the commit at the tip of the branch that
	was checked out); what is done to the resulting history is
	the only difference (if you work on detached HEAD, you can
	decide which branch to update with after you are finished
	working, if you stay on a branch, you are committed to
	update that branch at the time of checking it out).

> +		1. Go to another commit; I would be "checking out"
> +		to that commit and enter a "detached HEAD" state,

"Check out" is a direct verb, i.e. "check out the commit", not
"check out to the commit".  The same thing can be said to other uses
in your document about checking out a path out of a tree-ish.

> +		meaning, that the "pointer" called HEAD which tells
> +		me where I am right now in my working tree is not
> +		where it generally should be, i.e., referring to a
> +		named branch(say, master).  Instead the
> +		aforementioned pointer is referring to the specified
> +		commit. I can now work upon the checked out commit
> +		and make any changes or just inspect the files at
> +		that state.
> +
> +		2. Go to a different version of a particular file;

Who is "going" and where?  Isn't it easier to understand if you
explained that "checking out a path out of a tree-ish" is to grab a
copy of the blob (which is at the path in the tree-ish) and update
the working tree with it?  "Replace a file in the working tree with
the same file in a different commit", perhaps?

> +		let's say I want to go to a particular version of a

"go to" -> "have" would make this understandable, at least to me.

> +		file in my working tree. I can again "checkout" to
> +		that particular version(i.e., going to a particular
> +		commit where certain changes were made). This can be
> +		done by entering the SHA1 of the commit in question.
> +
> +		3. Go to another branch or create another branch; I
> +		would be "checking out" to another tree in my local
> +		repository. One might expect to enter a detached
> +		HEAD here as well but in fact does not.

It is unclear why one would expect such a behaviour.  Is this really
a frequently asked question?

> +             This is
> +		because HEAD would point to the tip of the checked
> +		out branch, something which is not a characteristic
> +		of a detached HEAD.

> ++
> +To checkout to a commit, one can either pass the SHA1 of the
> +commit to be checked out or a reference to it w.r.t.  the HEAD.

I do not know what you mean by "or a reference to it w.r.t the
HEAD" here..

> +To checkout to a particular version of a file, one can use `git
> +checkout <SHA1/reference> <file>`.  

You are getting confused here.  This part belogs to #2 above,
i.e. grabbing a path out of a tree-ish as a way to help growing the
current line of the history (either branch or the detached HEAD) you
are working on.  Not an appropriate sentence to have in the section
for #3, which is about switching the line of history you are going
to grow.

> + To checkout to an already
> +existing branch, one should use `git checkout <branch-name>`. To
> +simultaneously create and checkout to a branch, one can use the
> +`-b` option in the aforementioned command.

Yes.  But drop "to" from "check out to".  You "check out a branch",
not "check out to a branch".

> +One can observe how versatile the checkout command is, yet due to
> +simplify things even further, two commands were introduced in
> +version 2.23 of Git so as to break down the functionalities of
> +`git checkout` and make it learning the command easier for a
> +beginner.

Drop "even further".  A common complaint was that it was too
versatile and introducing two separate commands for its two (again,
not three) uses was done to make it simpler and easier to learn and
use.

> +The commands being `git switch` and `git restore`.
> ++
> +`git restore` combines the first two features of the checkout as
> +well as functionalities of `git reset` and `git revert` at one
> +place so as to improve the functionality of the command.

Are you sure?  I thought you artificially split "switch" into #1
(switch to a detached HEAD) and #3 (switch to a branch) and
described "check out paths out of tree-ish to the working tree" as
#2, which is what "git restore" is.

> +`git switch` perfoms the third functionality of the `git checkout`
> +command, i.e., manipulating branches(creation).

Ditto.  Detach, orphan, creation, and plain branch switching all
fall into "switch"'s purview.

The distinction to keep in mind is if you are checking out a line of
history to work on, or if you are sticking to the current line of
history and manipulating working tree files by grabbing contents of
paths out of a different tree-ish.

Again, I am not sure why we need to have separate description about
two primary modes of "git checkout" here, instead of making sure we
have serviceable explanation in "git checkout" manual page and point
it from here, if "what are two modes of checkout?" is a frequently
asked question.  For those who started their Git experience with
"switch" and "restore" without touching "checkout", the distinction
may not even have to be explained.

Thanks.
