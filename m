Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261027;
	b=LylFaAT0MuKPNvUDfypX7QJh3oQssHFrzJDuR8N2X7NqVZgVkCipQpYWdrzcXQ+NltCF
	 r5cl+yg8cfOdvYXl0fUbqt8/vxF5fu6HzmtajfIJQvS+3AOiPq6Bn+plyU53VPoUKnAuP
	 zekh7crB3jBJKN8aCtxiDjBw6IXTONPzfRf/aAdD2EHiTSdD4HsS3N2sAXHNrQhhJcs9w
	 xdp+hGnnrJjdLr6UuLAPCb05NaWqU3CqMr/5rK+NZYNT4FHVj6BAycKV5WP1WBcDLbm/u
	 nSssVhsjjFjnrXaWqMAkGjLM2cL3jDvguwnBfIAUDakCQQPbHuQX54RkBEbc7ia1c9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261027;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=jX9N1N/VmD/XLmWZePAN+lsSYbAshwUQCwQYvGyNhYQ=;
	b=X8E4ND5Awfxq2iSlaCcbLMtKye+QgkLaK2MOR8+juL7K3lTRfn2aeRM7Wy17QuViwMVh
	 F1akTGUq2UgTSdDPQFpc4ptzncdKKrkss2pFNCyjE2eK/92wnYFsV9Y5KifYurGsK/0r0
	 pAVEyrgr8kh80uIBG4+viA6+skFgG9s1DaWtwNdPzD5lJnXHJWOQa0ybzFPdt0HoQlBQE
	 8Oq2gXqszNgUl7z6lR8yodokitR0/i+PSfqrCayulDRC7lTPC7jO5THftKf6u+PQXzbYo
	 2TtJtzNg7+VQqg8dfiO1CSZz2zF+HWJUJHaPCJNOvz/k0RWDm1Z309gt3/L3iJzfXHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09461606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09461606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69T83Htp004981-69T83Htr004981
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 29 Oct 2026 10:03:18 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xML6T-00C8bm-MC;
	Thu, 29 Oct 2026 10:03:17 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 10:03:17 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id c1646631;
	Thu, 29 Oct 2026 08:03:17 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:03:17 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Omri Sarig <omri.sarig13@gmail.com>
CC: <git@vger.kernel.org>, Li Chen <me@linux.beauty>, Julia Evans
	<julia@jvns.ca>, Junio C Hamano <gitster@pobox.com>, Phillip Wood
	<phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4] doc: git-rebase: update incompatible options
Message-ID: <20261029080317.wWchf%taahol@utu.fi>
In-Reply-To: <20261025110759.204336-1-omri.sarig13@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXkgYAAEEBAEYRh8HBwwoDB0G
 DQQFRgcaD0YdA0hYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZ
 W0gCHQQBCSgCHgYbRgsJSFhIWV1IBQ0oBAEGHRBGCg0JHRwRSFhIWlpIBwUaAUYbCRoBD1lbKA8FCQEERgsHBUhYSFpeSBgAAQQEARhGHwcHDCgMHQYNBAVGBxoPRh0D
 SFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=jX9N1N/VmD/XLmWZePAN+lsSYbAshwUQCwQYvGyNhYQ=;
 b=ZWUdTaWy7neKQ7V9g3dZcqCNl0UJOtadBJYzLnzdoP9Le6hdgd8wdAfnCjl6XMwX9jszLT0yR8ld
	38TvyXC4QPrZFvKaZ6S/zT4sZGYaDo66JkAqyOreP+ZPAHKflETnKMWcBKn1UVvvyf+YeFOpMZJr
	prvXGVJwXRt7xgYBSJbmh38gRZYeQiLK+D5NLZRYoyJMt//R/gzdYc/gAHu5hIzvkgmD7N22dGaF
	oJ5C6GOgWQ9sbK0LKXi7Mi7vZtKiNxIDl12GQMlWoOL4bpHXOP/KqOs6v7TVDl70QPX6qY5a9wLm
	gIF6U9NsJMl26Mket/EHN30V7AOnpfOVH2w3iQ==

[administrivia]
  Please send subsequent rerolls as direct replies to the v4 patch message
  (git send-email --in-reply-to= ).

Omri Sarig <omri.sarig13@gmail.com> wrote:

> A few options in the rebase manual page link to the "INCOMPATIBLE
> OPTIONS" section, but they are no longer incompatible with any other
> option:
> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>   incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>   the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>   section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>   2021-09-07) removed the `--preserve-merges` option from rebase, which
>   removes all incompatibility references to `--ignore-date,
>   --reset-author-date` and `--signoff`.
> 

Okay.  "INCOMPATIBLE OPTIONS" says nothing about "--allow-empty-message",
"--ignore-date", "--reset-author-date", and "--signoff", so links from those
sections to incomp opts have to go.

Well observed!

> Additionally, since 414d924beb (rebase: teach rebase --keep-base,
> 2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
> it is not mentioned in the INCOMPATIBLE OPTIONS section.
> 

"--onto" is mentioned in incomp opts, but the description doesn't link there.

Just steal the correct wording from the v3 where you had it already right. :-)

> Update the description of these options, to have correct references to
> the INCOMPATIBLE OPTIONS section.
> 
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
> 
> Thank you for the review!
> 
> Changes in V2:
> - Update commit message per the review comments from Phillip (Thanks for the
>   review!).
> - Add `--onto` to INCOMPATIBLE OPTIONS.
> 
> Changes in V3:
> - Downcase "Update" in commit title
> 
> Changes in V4:
> - Update the commit message per review comments.
> - Rebase the patch to be compatible with the maint branch.
> 
> The main difference in git-rebase.adoc between the maintenance branch and the
> main branch was created in 2fc11e3382 (doc: add more AsciiDoc cross-references,
> 2026-09-25), which turned all the "See also..." lines into links. This created
> conflicts with the removed lines, which I've solved.
> I was not sure what is the correct way to add the new INCOMPATIBLE OPTION line
> in this patch. As I see it, this line can be aligned with the current version
> of the file (without the link), or "correct" for the final version of the file
> (with the link). Here, I opted to adding this line in the aligned form for the
> maintenance branch. This will require some work when merging this change to the
> main branch, as this new line will have to be updated.

Excellent!  The patch now applies cleanly to 'maint'.  When this topic has
settled down (i.e. merged to 'next'), you would perhaps like to send a followup
patch as a separate topic.  Such patch would look something like this, if you are
interested:


diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6190479966..e9c463da57 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -216,13 +216,13 @@ OPTIONS
 	existing branch name.
 +
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 See <<TRANSPLANTING,TRANSPLANTING A TOPIC BRANCH WITH --ONTO>>
 above for examples.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
@@ -497,13 +497,13 @@ applying (in terms of the author date).
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
 	via linkgit:git-interpret-trailers[1]. This option implies
 	`--force-rebase`.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see <<SPLITTING_COMMITS,SPLITTING COMMITS>> below).


> I was not sure if this is the correct strategy. If the right way to do it, is
> to add the "final" version of the line, please let me know, and I'll provide a
> V5.
> 
> Thank you for the support in helping me get this through.
> 
>  Documentation/git-rebase.adoc | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..f1f675d311 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -217,6 +217,8 @@ OPTIONS
>  As a special case, you may use "A\...B" as a shortcut for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>  
>  See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
>  
> @@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
>  	and this option would override that behavior, allowing commits
>  	with empty messages to be rebased.  Now commits with an empty
>  	message do not cause rebasing to halt.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  -m::
>  --merge::
> @@ -487,15 +487,11 @@ applying (in terms of the author date).
>  	Instead of using the author date of the original commit, use
>  	the current time as the	author date of the rebased commit.  This
>  	option implies `--force-rebase`.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  --signoff::
>  	Add a `Signed-off-by` trailer to all the rebased commits. Note
>  	that if `--interactive` is given then only commits marked to be
>  	picked, edited or reworded will have the trailer added.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  --trailer=<trailer>::
>  	Append the given trailer to every rebased commit message, processed

The changes are good to go, but see my nit for the commit log message.

--Tuomas
