Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.53.57.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857705;
	b=lOrqNvbOl1tUnvCCaeMZCqB/HYopMWZj6kDav06zf2uIJ0KFGsc6LI4+RGRhgzW28QXp
	 QOOiF6vCpfIH7xtBE8JeHvqv9YKU/ElCCzJ32QLk1vAAfbDVkyCE/a+vqnl8gRtndt+7r
	 luhKru92uazn8o9dqAIYAbgQ1/+NyBuK+nfkMggdu+bbKDbtxQh/GHPO0PBXsmQlfcPRr
	 q4LLo7K6rSXsD4bIGw8X7LxG8n20OPoA+vlzCaSN2PBJZ1yDbbUDBMhfsFiXuJIBJF8TB
	 etR1ES8XgK++EA3msA96+QZybW62j4/Cc4L4Hrie+LY96PLIayH2+sncbK/jE/Y+oLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857705;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=NDMDzqE7ikW9lwmQg2VY+EMZfhEXypp5p+luTaFXaIk=;
	b=i332CQYtKaFYvN26/Afmil+OfqsrahEPhApeTh2xjLms39ccqW/QaRwPuLnUb1hipOF2
	 umka93svOKdFgFcwesbMyyV1NVFd2idcfrFwRfwbtXq5gLZpEeQbK6+2PAcdVSsCt57Di
	 sOCh4WtSQXmjB+M5r+qLzFTmmJtCFNFqPZekOeg+6VKai7+ipH4aUzmuebEBUj6zC3htf
	 lQKcFlN+i0YdG8a+ZcKaZNRYbaEm7QdwbvKjbf1sueIjQvoL9JhjLpv3JdSO7zwrVtV9l
	 46+tzNnP5ODTLJnqDhS3d0aP/QXg1ueJ4zUXmUvot4gMGwA/GVGNa8pR6JNMwdZJyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=donquinleone.com;
	spf=pass smtp.mailfrom=donquinleone.com;
	dkim=pass header.d=donquinleone.com header.i=@donquinleone.com header.a=rsa-sha256 header.s=hermes header.b=TKRxKjwI;
	arc=none smtp.remote-ip=185.53.57.44
Received: from woden.albient.com (woden.albient.com [185.53.57.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54218606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54218606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=donquinleone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=donquinleone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=donquinleone.com header.i=@donquinleone.com header.a=rsa-sha256 header.s=hermes header.b=TKRxKjwI
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 96ACD432B5;
	Sat, 24 Oct 2026 17:01:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=donquinleone.com;
	s=hermes; t=1792857696;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NDMDzqE7ikW9lwmQg2VY+EMZfhEXypp5p+luTaFXaIk=;
	b=TKRxKjwIAjlW6PQgq+UU9QKPvs1Ip6Bua3ldWW4TTVSiRHbnvagyDZ+UVqf4zb0+y1/1NE
	x4TxgNUoWS4IXA7+1uvmUIe4QffvuH1xslM6CXUcrELFGs7IKjbVIUriNQuu2gHTJYZDa0
	Gl6aPnk3mnuwfR+zh2oQ8ANWYn4IMJHcvvoCGnkmilLWT38BHZIuSYJXdWV54YFKpSi6ZD
	PBqBtj2cv9WgQLUiTb+slOPjn7Vdzc7nKxUeSt+LRyVpnkem1eaxL97R27IjhttXWYlVzH
	mF0JPpDpgln+mX63/NOEm+sRzoS34ybx8zaQCqNCmhwSarx4tQ5JQYpb3QM3nQ==
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 17:01:35 +0100
From: DonQuinleone <don@donquinleone.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
In-Reply-To: <CALnO6CAAoMLZP4MBzgBa96RYMMReyxKXObb2JELqkBe=LBUVLg@mail.gmail.com>
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com>
 <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
 <CAHwyqnWi6E=idoP2+1FdeEE4-o3D20xJfsc4Dutt6R30c===xQ@mail.gmail.com>
 <CALnO6CAAoMLZP4MBzgBa96RYMMReyxKXObb2JELqkBe=LBUVLg@mail.gmail.com>
Message-ID: <ba149000e13634ffcc5dc51e4d584a56@donquinleone.com>
X-Sender: don@donquinleone.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None

Hi Ben, Harald,

Thanks both, this has been really helpful. I've tried each suggestion
against the reproduction script with Git 2.56.0, and here's where I've
got to.

D. Ben Knoble wrote:
> In this case, if "topic@{upstream}" was "origin/master", though,
> "--delete-merged=origin/*" would work, no?

Yes. With push.default=current, "git switch -c topic origin/master"
and a plain "git push origin topic", the dry run offers to delete topic
once the pull request is merged, with no code change at all. So the gap
is only for people who follow the hosting services' advice and run
"git push -u", which points @{upstream} at the topic's own remote
branch. That's the setup I'd hoped to help, and I suspect it's a common
one, but I agree the better long-term fix there is teaching the
triangular setup. A document like the one you mentioned would be very
welcome.

Harald Nordgren wrote:
> Why do we need the `--into` at all?

Ben has covered it, but in short: once the upstream is gone there is
nothing left for --delete-merged to check against, and Junio ruled out
Git choosing a substitute (HEAD, or the remote's default branch). So
the commit has to come from the user, and --into was simply a way to
name it.

D. Ben Knoble wrote:
> Rereading our docs for git-branch(1), I think what this RFC is
> looking for is
> 
>     git branch --list --merged=origin/main | xargs git branch -d

That was my hope too, but it doesn't quite get there in the
reproduction:

   $ git branch --list --merged=origin/master | xargs git branch -d
   error: branch '*' not found
   error: cannot delete branch 'master' used by worktree at '...'
   error: the branch 'topic' is not fully merged

The first two are just the listing format, and for-each-ref would avoid
them. The third is the interesting one. "git branch -d" checks topic
against its upstream, which is gone, so it falls back to HEAD, and
master is behind origin/master. The commit that selected the branch is
not the commit that checks it, so the proof is lost at the pipe. Only
-D gets through, and that drops the check altogether. (The listing also
picks up master itself, and would pick up any branch that has been
created but not yet committed to.)

To me that points to the shape you sketched for (B), with one change:
when -d is given list filters, the --merged commit is the proof as well
as a filter.

   $ git branch --upstream-gone --merged=origin/master      # list
   $ git branch -d --upstream-gone --merged=origin/master   # delete

In the -d form:

  - --merged needs an explicit commit; there is no HEAD default, so
    nothing is inferred;
  - each selected branch is deleted only if its tip is reachable from
    that commit, in place of the usual upstream-or-HEAD check;
  - a branch checked out in any worktree is still refused, and
    branch.<name>.deleteMerged=false would be honoured;
  - --upstream-gone and the existing --forked narrow the selection, so
    it doesn't sweep up master or a branch that hasn't been pushed yet.

"git branch -d --merged=..." is rejected with the usage message today,
so this adds a form rather than changing one, and --delete-merged stays
exactly as it is. In the RFC I worried that this would make -d a second
bulk-delete mode, but given your point about composability I now think
that's the better trade. It avoids both an option that only means
something next to another option and sub-values packed into one
argument, which I hope answers both of your concerns. I'd welcome being
told otherwise.

So, updating my two questions:

  1. Is "selection is not proof" an acceptable basis for deleting
     gone-upstream branches at all, when the proof is a commit the user
     names explicitly?

  2. Ben, Harald: is a filtered -d, with an explicit --merged as the
     proof, the shape you'd want? If so, I'd start with --upstream-gone
     as a listing filter on its own, since it's useful without the
     delete half (it replaces grepping "git branch -vv" for ": gone]"),
     and follow with the -d part as a second patch.

Thanks again,

~ Don
