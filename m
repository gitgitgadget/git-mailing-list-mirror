Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A515A8
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sl+6i3hJ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC371D6810;
	Tue, 26 Dec 2023 13:30:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EL90fbSTzVWZ
	md3jjJdGi2zxaFw6s0mLP0eIN+WL3CU=; b=Sl+6i3hJNmoYyo3ThXuQMyk45puo
	yMEF/LMylIIcgxZToq6vlvmZ/NHedSlujrUQb0h3XlWWIlum16A6kuY9LRHnpoll
	lSkPcduV7H3Jx25fDPySwTDV990ciIZjiUJ6NWlVEEFDEN8k519DuUOh5siOPmjp
	GTN2EkkMaaU/LWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2C1E1D680F;
	Tue, 26 Dec 2023 13:30:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C61D41D680E;
	Tue, 26 Dec 2023 13:30:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 0/2] Fix doc placeholders
In-Reply-To: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 25 Dec 2023 21:21:25
	+0000")
References: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 10:30:13 -0800
Message-ID: <xmqqzfxwhl56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CFDA5EC8-A41C-11EE-81F0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While setting up a check of (the absence of) translations of commands,
> options and environment variable in the manpages in the manpage transla=
tion
> project, some false positives appeared.
>
> Here is a series that enforces the formatting rules for placeholders in
> documentation and help.

Nice.  Will take a look and then queue.  Thanks.

>
> Jean-No=C3=ABl Avila (2):
>   doc: enforce dashes in placeholders
>   doc: enforce placeholders in documentation
>
>  Documentation/diff-options.txt             |  2 +-
>  Documentation/git-blame.txt                |  2 +-
>  Documentation/git-bugreport.txt            |  4 ++--
>  Documentation/git-commit-graph.txt         |  2 +-
>  Documentation/git-config.txt               |  8 ++++----
>  Documentation/git-cvsserver.txt            |  4 ++--
>  Documentation/git-daemon.txt               | 10 +++++-----
>  Documentation/git-diagnose.txt             |  2 +-
>  Documentation/git-difftool.txt             |  2 +-
>  Documentation/git-fast-import.txt          |  4 ++--
>  Documentation/git-fetch.txt                |  4 ++--
>  Documentation/git-filter-branch.txt        |  6 +++---
>  Documentation/git-format-patch.txt         | 20 ++++++++++----------
>  Documentation/git-mv.txt                   |  2 +-
>  Documentation/git-notes.txt                |  2 +-
>  Documentation/git-replace.txt              |  6 +++---
>  Documentation/git-revert.txt               |  4 ++--
>  Documentation/git-send-email.txt           |  2 +-
>  Documentation/git-status.txt               |  4 ++--
>  Documentation/git-submodule.txt            |  4 ++--
>  Documentation/git-svn.txt                  | 18 +++++++++---------
>  Documentation/git-tag.txt                  |  2 +-
>  Documentation/git.txt                      |  4 ++--
>  Documentation/gitdiffcore.txt              |  8 ++++----
>  Documentation/gitformat-index.txt          |  4 ++--
>  Documentation/githooks.txt                 |  8 ++++----
>  Documentation/gitk.txt                     |  4 ++--
>  Documentation/gitprotocol-capabilities.txt |  2 +-
>  Documentation/gitprotocol-http.txt         | 14 +++++++-------
>  Documentation/gitprotocol-v2.txt           |  8 ++++----
>  Documentation/gitsubmodules.txt            |  4 ++--
>  Documentation/gitweb.conf.txt              | 10 +++++-----
>  Documentation/gitweb.txt                   |  2 +-
>  Documentation/trace2-target-values.txt     |  2 +-
>  Documentation/urls.txt                     |  8 ++++----
>  Documentation/user-manual.txt              |  4 ++--
>  builtin/commit-graph.c                     |  2 +-
>  37 files changed, 99 insertions(+), 99 deletions(-)
>
>
> base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1626%=
2Fjnavila%2Ffix_doc_placeholders-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1626/jna=
vila/fix_doc_placeholders-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1626
