Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6A13D628
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763638; cv=none; b=sIKAkAGpK9sJ4aAvhVaNfznTA3E+FYnI3af3f+Q2HSm26V1dsMstoi6Ma8EuPDBEavrz9tukC0MEOUBg3qfNgNHgoODqFBQ0sCfmrG41ie0yP42ybghLD08cyLavMZbLOSQzvlQ1R1SiShXAijQVn/llrO010vgsRkgQjwXX4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763638; c=relaxed/simple;
	bh=F7GnkDzUmDlQmJuvslGHw2gqBdK5dv2g/cDmgcheAmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmUtHWDiywdIPN27ZJCng56RiL5ManyEmSA6VjpgcjQxuFDxFNHZDBnEvun+P6wJlQ2SjfyvrWf8C6UUYgbKcb2aiizGpjWytO+YslSzBbxD2nXYod+GLKv7z5sdU1nx3HV07JXp2+USAMLDUemAxnWobaCtL8A38JAl/dJpdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l9ztBoVr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l9ztBoVr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 006EA1E4A9;
	Tue, 23 Jul 2024 15:40:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F7GnkDzUmDlQmJuvslGHw2gqBdK5dv2g/cDmgc
	heAmM=; b=l9ztBoVrBDBQegc2VjfNhny6vVkyvfUScfd8xTHmF+ogWMvnoTnG/a
	AYBl/9zZxXkeY2miIskssPvMN2PEFVUlqcD/QeVcJWA40h++TMpLEs5MApEFyIsT
	KzUi+NXHA2JN4Fzj31vaue1SSvf8i5GEy1xpjOigrY2paX+xvBWto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC82A1E4A7;
	Tue, 23 Jul 2024 15:40:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24CBB1E4A6;
	Tue, 23 Jul 2024 15:40:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH 5/8] git-prompt: add some missing quotes
In-Reply-To: <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1721762306.git.gitgitgadget@gmail.com>
	(Avi Halachmi via GitGitGadget's message of "Tue, 23 Jul 2024 19:18:23
	+0000")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1721762306.git.gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 12:40:27 -0700
Message-ID: <xmqqjzhb28yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A8AD6EC-492B-11EF-9A16-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
>
> The issues which this commit fixes are unlikely to be broken
> in real life, but the fixes improve correctness, and would prevent
> bugs in some uncommon cases, such as weird IFS values.
>
> Listing some portability guideline here for future reference.
>
> I'm leaving it to someone else to decide whether to include
> it in the file itself, place is as a new file, or not.

Check Documentation/CodingGuidelines; I think we have something to
say about local var="val" construct to help dash.

We allowed liberal uses of bash-ism in this file, as it was
initially written for bash anyway.  If we were rewriting the prompt
scripts to be usable by other shells, great.  But then we'd want to
make sure it adheres to existing coding guidelines we have.


