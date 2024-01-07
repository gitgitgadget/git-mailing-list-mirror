Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A701125DE
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="KAXko9eQ"
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id 16034FBFA7E
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704611685;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=3na0QAkcHbY6rZYrkQN6akeoc4XgSsKv/V7oaTUl8ww=;
	b=KAXko9eQYwmeNe54RhyL70Fn7Sh5JntMUbbfR4q9Gs7GebWBfZ8F4c4fBm67qUfb
	/NdzXvx+UpsIxSy7mD9sN6Rg+3+Od5kyeSLEMCRDcJv1xWitqemvoAgAlzKpI2rRlmF
	vjTvGu6LekKI3i/jAtAnzFIQPjCikbTvLRd9Pl5/ZxR/uK0aLvK53G1babCuDLNLAZX
	Df6wFhJfC8EmsgCgk44/esKn1YtGRoiQN7RKtjCviNPTceoSKvt4TlgdbNaLa75k/XL
	k0XsVtWbWLyx3zTq7KuXHx2YVzsdM9k+YJhpYQD7ueUwEWtj+Zf3gGyWzNoMoJ4X8sI
	cTBz3fZhkQ==
Date: Sun, 7 Jan 2024 08:14:45 +0100 (CET)
From: Trix Knotts <enderk@tuta.io>
To: Git <git@vger.kernel.org>
Message-ID: <NnXlX4H--3-9@tuta.io>
In-Reply-To: <NnXUPNo--3-9@tuta.io>
References: <NnXUPNo--3-9@tuta.io>
Subject: Re: git config --global needs to be run in a git directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

My bad, I had `--global` after the item to be configured.
--
Trix Knotts (she/they)



Jan 6, 2024, 11:56 PM by enderk@tuta.io:

> Hi! This is a minor issue, but I noticed when I ran `git config --global` from my home directory it gave me this error: `fatal: not in a git directory`. I was able to resolve this simply by moving to a git directory on my machine and rerunning it, so it is not really a big issue. However, I think for convenience it would be nice to be able to run global things like this anywhere. What do y'all think? Would this be easy to change?
>
> BTW this is my first time emailing the git mailing list, so sorry if I did something wrong. Please let me know if so!
>
> --
> Trix Knotts (she/they)
>

