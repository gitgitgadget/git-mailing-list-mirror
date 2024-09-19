Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BB208D0
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778544; cv=none; b=GnHtqa+ZR+sQ1CcJ9tmZIZSumoobie+VjS3PB5Kh5YB3G62ko2bAfK0zRgg47tt5TapYTwoqFjftbywHqYZ+WYflssJlLpmA5TRpRhasuRhCasb+5w3x4nhws1p070V8jQ7+ZyBuX5uMD+hgFOypLDDxmQ6pafyMZs9ybCz5xpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778544; c=relaxed/simple;
	bh=+EmPOA6xmWRr5e8fUpXO+5VzhMG899SKnQklAn1yryA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oEJyyvkxFIAbzwIEJJqMBPCcTeBw5ljwo0FmrN5o8/bH+uvlfSLJzEGBTwWZNyTVic9GW+pS7xsmnZkCZxnDneTtHUjmNCfVoRbJrTh6wCIeZ6Pt/LW9+kupX7wbtOJD4bFaxNRSkhAaLgRviWDtvftbDTNQlBmB/+of9XgxV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJkm7u4y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJkm7u4y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 883CF2BDD4;
	Thu, 19 Sep 2024 16:42:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+EmPOA6xmWRr
	5e8fUpXO+5VzhMG899SKnQklAn1yryA=; b=rJkm7u4yL4nr/TJ5MUjggNdWS9xO
	iNQxJQop/fGgusWAeI0jVvzswlzyu5AYyRbRp/jCh8DrXtIQiwj+Facf2rf7FLL8
	s7OxN5CCjJ2mUrO+nIZ8qNZYB98kxJzRSJYVMlR3Zfy7yoBsN3OS3lvlI/OYiOJU
	naB9X+d312aBnAE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FAA02BDD3;
	Thu, 19 Sep 2024 16:42:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6E292BDD1;
	Thu, 19 Sep 2024 16:42:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Andrew
 Kreimer" <algonell@gmail.com>,  "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/20] Fix typos
In-Reply-To: <ab9213d5-fb1b-482e-854b-4f5d4e82821a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 19 Sep 2024 22:33:18 +0200")
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
	<ab9213d5-fb1b-482e-854b-4f5d4e82821a@app.fastmail.com>
Date: Thu, 19 Sep 2024 13:42:19 -0700
Message-ID: <xmqq34lv74us.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AAE722DA-76C7-11EF-B955-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> All of these look correct.
>
> Maybe all of the commits could be combined into one commit with the
> message =E2=80=9Ctreewide: fix typos=E2=80=9D.  But that wasn=E2=80=99t=
 asked for last time.[1]
> So I dunno.

It depends.  When done carefully to make sure that nothing textually
conflicts with any topics in flight, a single "treewide" patch is
slightly nicer.  If nothing conflicts with nothing else, either
format is fine.  If something have nasty conflicts (e.g., a refactor
moved the comment with typos far from the original location or even
to a different file), individual patch form is easier to discard the
ones that need to wait.

I do not know which case this 20-patch collection falls into.

Thanks.
