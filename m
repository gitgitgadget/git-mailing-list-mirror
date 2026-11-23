Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452777;
	b=rWsPtVtIdWtLw++ftDa1IKPi3iuuA8S7iak4AtzmjxSMMel9/iDOOU9YsT+RwuefSLRK
	 XNjTMalVoON97eiJOrYWjkwFZa1u01wSyRq1feJmh/CcnYdJZD9CIlaaoXm09FFKack9C
	 ldyQyRCQ0X5SQ44OIUPRusXbYNZuk9lFdMo1wo9wqenjEMC5SgYP7XM02D+ZSGhs9kvsb
	 6lQq6XOKlofreORI1Vvww9rD/Q/yQ/28Ttje4MgllQIu1AugdtuGNtVJCxwSt4v1zWXVN
	 6NgPohE6uyp3eLIU/D7H5Ij/aVYnQ/aQmYgvuSxUCtA9wSX7vdrRhHc1atcsC4PjqjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452777;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=TbaCFiX8gTvoas+XRk1YZeNP1KahaaO1o/J6naar1Jg=;
	b=jc/ok9w+BJy1I06CpDZ8+LjCoDGzDkQjyQu7zg+CNQc7MnYzqH75He0orpfStMZSAVoQ
	 UKD1j6kq6dEi5RS/HVgzTtwJwvD7ntKnpjj1nn/e97SWa5g5WclNL6UrLQX4p8k0pr9K9
	 oXm+1mRyeQRHDM5rHhFHLEZgGkwUpB+SzjwMWsfUdIWVKNONfFFCJkzL/o3JDWPkcv4+F
	 5yUHqRMPqFjEJfo/09Jv/wnlYvjMnay+HI/WQVRRhebOfc3Db9Qlh70syZG+BvZKnZhUi
	 8k0DxulHswn88CPmB7xNAYO+NHcFGO0zslQTKZjnARrcyNB2B7NABqdwM2Y1TyZirxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=OJa+RTJJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04417606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04417606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=OJa+RTJJ
ARC-Seal: i=1; a=rsa-sha256; t=1795452760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G0zSTmNSAoE67L6/6EpCjN9aSxoPQTpSZ1qc1g3WOeBXJO6KdhhWENnVVPUkAp8XQlQTNcXHXhmvjEDPT5UbDNcLoj+igxKfZ5amO2kLTdJBBqYPfgccnX+Ke0n+NlXuxmOZI64oRzxa+G/Zp+QYGmVyFKU2VcYxn1lVkEL8Plk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795452760; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TbaCFiX8gTvoas+XRk1YZeNP1KahaaO1o/J6naar1Jg=; 
	b=G+RIyV6np2jtFI51s5yd42VGsbl/+ribRu7oFJqBcb94rBrWbci+IO2IhJ6DsPAz/262lhpV05YHk1ewQ7xIYtCYRo0P1czHf/0VVUxFxCpjZXHNRtV97DENIX6V4t12CDcg0aD78JrqIKrjN/vAZVRzvSxqz2uhe/LPsYCNkv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=OJa+RTJJidNMuuC6fJB+tr+kCKiMgrbbxTemWGgRbmgQLQ9v0vEx/K+jiLmvCbZP0OcuQDzdOPrm4aPGpSn+xNVKLSNIExQH02rrYWqj3E92Mm+6XxO3nKW1604gZrDdO0CyVLM+8JYzk52BkdLrcAxuPtbOLabjzCrBI1PSi3s=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=TbaCFiX8gTvoas+XRk1YZeNP1KahaaO1o/J6naar1Jg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795452757963860.3816173133582;
	Mon, 23 Nov 2026 08:52:37 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wasswa Edson <edsonwasswa54@gmail.com>,
	git@vger.kernel.org,
	Tanga Joris <tangajoris@gmail.com>
Subject: Re: [PATCH v2 0/3] credential: parse subcommands with OPT_SUBCOMMAND
Date: Mon, 23 Nov 2026 08:52:31 -0800
Message-ID: <20261123165231.58660-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq5wxnd0k5.fsf@gitster.g>
References: <xmqq5wxnd0k5.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Junio C Hamano <gitster@pobox.com> writes:

> Outside of a trivially obvious fix or a quick nod from a known area
> expert (e.g., Dscho or J6t on a Windows-specific patch) or the original
> author of the code being touched, it is hard for bystanders to tell from
> a one-line "Looks good to me" how deeply the reviewer thought through
> the changes.

Thanks Junio, that is a fair point and a helpful suggestion.

> One trick I sometimes use when giving a positive review is to walk
> through the patch aloud, explaining in my own words what the old and new
> code do and why the tricky parts are handled correctly.  That way,
> others can see that a second pair of eyes really understood and agreed
> with the approach (or the author can correct me if I misread something).

Here is what I did, so it is visible.

I applied the three patches on the base named in the cover letter
(37b3475fb5) and built each commit on its own. t0300 and t0450 pass at
each step (t0300: 56, 56 and 60 tests). On the final commit I ran t03*
and t04*, t9902, and t0300 with GIT_TEST_DEFAULT_HASH=sha256. All
pass.

To check that the tests catch the change, I ran the new t0300 tests
against a build without the series (4 fail), and removed the "too many
arguments" check (test 60 fails). Keeping "credential" in
adoc-help-mismatches makes t0450 fail, so dropping that line is
needed.

I compared an unpatched build with the patched one on about 50 command
lines, including real input on stdin for fill, approve and reject.
For valid input, output and exit codes match. The differences are in
-h, "--", --git-completion-helper, and the error messages for a
missing, unknown or extra argument. The two small points I found are
in my reply to 3/3 [1]. One good result: "git credential bogus" blocks
on stdin on the old build, and exits 129 right away now.

Why I think the approach is right:

1/3: "capability" was documented and implemented but missing from the
usage string. Adding it, and marking the SYNOPSIS [verse] so that
t0450 can extract it, makes -h and the man page agree. The "credential"
line in adoc-help-mismatches then has to go, or t0450 reports the
breakage as fixed.

2/3: each subcommand keeps the same steps as before: approve and
reject read the credential and set the helper capabilities, fill reads
and fills, and capability reads nothing. Only the order changes, so an
unknown name is rejected before stdin is read. The old code read stdin
first, which is why "git credential bogus" blocked. The functions
keep using the_repository and leave the repo argument unused, which is
right because "git credential" runs with RUN_SETUP_GENTLY and repo is
NULL outside a repository.

3/3: OPT_SUBCOMMAND is used without the "optional subcommand" flag, so
a missing subcommand is reported and the function pointer cannot be
NULL. Each subcommand re-parses its own arguments with an empty option
table, so -h, an unknown option and a leftover argument are each
handled where the subcommand lives. The usage arrays are static, and
the option table is only used before it goes out of scope. Calling
parse_options() is what makes --git-completion-helper work, and
dropping NO_PARSEOPT lists the command in --list-cmds=parseopt, which
the completion script consults.

The remaining differences are that "--" and "--end-of-options" are
consumed by the parser, so the subcommand then runs, as it does for
"git refs verify --" and "git reflog list --". Reading the old and new
code side by side, I did not find a case where input that was
accepted before behaves differently.

I also thought about smaller versions. One shared usage string would
be shorter, but "git credential fill -h" would then show the usage of
the whole command, and the per-subcommand usage is how "git refs" and
"git reflog" do it. Stopping after 2/3 would already fix the usage
string and the stdin hang, but "git credential" would still have no
per-subcommand -h, no "need a subcommand" or "unknown subcommand"
errors, and no --git-completion-helper. I think the series as sent is
the better balance.

I also searched the list archive for a competing series and found
none.

As for how I review and respond: I usually keep my replies short when
a patch looks right to me and works as expected, which is why my first
reply was brief. You are right that a one-liner does not show what I
checked. I am still new to this area, so I will explain my thinking in
future reviews.

Thanks,
Laveesh

[1] https://lore.kernel.org/git/20261123023542.88325-1-laveeshb@laveeshbansal.com/
