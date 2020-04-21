Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28700C38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57D320782
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uY4fdV9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDUA5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:57:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64284 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUA5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 20:57:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D3AB5B296;
        Mon, 20 Apr 2020 20:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dLQHxEbbg1hQmceGY+NfbmHwhqA=; b=uY4fdV
        9fz/6DTpY0J/dXoVkZr9wvnJYE29eAfblKzSvGu/M0DnbgPume52RBSXbd9JllFz
        IESQNol3t0QV5ra1RHAN+mLeOBaqqcAAeq1GLsaP50VgpKMhwwcEK10NyWi6bCyP
        gh9pHwFubJyMWFsMa3QFmYaTFQzeE2pZtyB4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XemmHMzqlRs7G00QgF7Irg5JsAJQ+fiS
        KSqVV5KdjM0HXiIlO26REEGwCzL+uOeDqlPpW7pBnSUfj7Tglv0ZuCyrHxg65fgp
        SnZ6F7IeemwkL1/lsY3qlmFCSGExW+Nl0TgmxdrX0pWhIUIoO4NnUNF1E9ONOaFU
        qshvWH1whoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 919B15B295;
        Mon, 20 Apr 2020 20:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19B325B294;
        Mon, 20 Apr 2020 20:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
        <20200413140918.4778-2-shouryashukla.oo@gmail.com>
Date:   Mon, 20 Apr 2020 17:57:17 -0700
In-Reply-To: <20200413140918.4778-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 13 Apr 2020 19:39:18 +0530")
Message-ID: <xmqqsggxpseq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C69F0DC-836B-11EA-B2DB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

>+ [[changing-remote-of-the-repository]]
>+ I want to change the remote of my repository. How do I do that?::

>+ 	A remote is an identifier for a location to which Git pushes
>+ 	your changes as well as fetches any new changes(if
>+ 	any).

You push changes to a repository.
You fetch changes from a repository.

Hence, "a location, which you push changes to, as well as fetch new
changes from, if any."  But a lot more people fetch from repositories
than push to repositories, so "a location, which you fetch changes from,
as well as push your changes to." may be easier to follow by audiences.

In any case there is one crucial and precious thing in what you
wrote here.  A remote is a name for *A* location, even if you have
two URLs (i.e. one used for fetching from, and another used for
pushing to).  They are to name logically the same place, only the
way you reach may be different.  For example, you may have an
unauthenticated https:// URL for fetching, while the URL you use to
the repository may be ssh:// URL.  But the important point is that
these URLs are about the same repository---if you push over ssh://
URL your changes, you would be able to see the changes over https://
URL that you use for fetching.

>+      There might be different circumstances in which one
>+ 	might need to change the remote:

Sure.

>+ 		1. One might want to update the url of their remote;
>+ 		in that case, the command to use is, `git remote
>+ 		set-url <name> <newurl>`.

Yes, this truly is "changing" the old one by replacing its old URL
with a new URL.

>+ 		2. One might want to have two different remotes for
>+ 		fetching and pushing; this generally happens in case
>+ 		of triangular workflows.  In this case, it is
>+ 		advisable to create a separate remote just for
>+ 		fetching/pushing.

Yes, by definition, triangular is about fetching from somebody else
and publishing to your own place for others to fetch, so you'd need
two remotes, as you are not talking with a single repository.

But I find your phrasing quite confusing.

"advisable to have two remotes, one for fetching and the other for
pushing" would probably be a lot more correct.

And I can understand why you did not write so, and instead ended up
with your version.  In order to reach the goal of having two (one
for push and one for fetch), you would "create a separate remote" as
you are likely to already have one for one direction (in other
words, you didn't want to say "advisable to create two remotes").

You wrote "create a separate remote just for fetching/pushing" and
made the direction of the new one vague, because you do not know if
that existing one is for fetching or pushing,

But I suspect that all of the above would not be as clear to those
who need their questions answered as to somebody like me who knows
what you want to say already.  And you do not want to explain things
in a way that only is understood by experts.  How about rephrasing
the above more like so?

	2. One may want to fetch from one repository and push to
	anther repository---this is often called a "triangular"
	workflow.  As you'd probably have one remote that you use
	for fetching already created when you cloned the project,
	you would want to create a separate remote to record the URL
	you push to.

>+ But, another way can be to change
>+ 		the push url using the `--push` option in the `git
>+ 		set-url` command.

Do not recommend this when you describe a triangular workflow; it is
confusing to readers.  Keeping separate fetch and push URLs for a
single remote is not triangular.  

Describe it separately as a different use case, e.g.

	3. You may want to push to a repository over a network
	protocol different from the one you use to fetch from the
	repository.  Perhaps you want unauthenticated https:// URL
	for fetching from, and use ssh:// URL when you push to, the
	same remote.  In such a case, ...

Other than the above nits I picked, overall it is a good idea to
raise this question in the FAQ, I would think.

Thanks.
