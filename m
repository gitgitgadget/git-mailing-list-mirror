Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717471917DF
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692768; cv=none; b=WhNbEXMV6pyAKECthpWK7bVgLVG6vHjAlYY0MbVk2eW/yUOEXeZMEGE8Mi4fjmw0H0ROx5aAhcZIIHRCXnXYIus1mVTZTthpraz3t2by1oPtknw0YYKrLR2WbkyGo0AzVmOIO/ShiX8d3LTyfeoaYN+ip05iVedp9DnWkJfv1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692768; c=relaxed/simple;
	bh=xuCne/zgOoFvpU7/1nB2IAJD+jyiG6MgVQyRVLojgYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5gzxdJb5dGnOi3id5FzaNt8Xoa6s6jQ04cF/m0pa2oGGcHWXGW2HoS+seWaYCC4D0ReSXZQMPWmU0Y9NJorh/CPAxZ30wpa6yulb0YhUw4MlZO3OXNHMNmmLsW5IQkHdY2+bWgaZOG80iF9TYZdO8lm7poc/lLSX9xcUmkfhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JfevBkO+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JfevBkO+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 537732AEEF;
	Mon, 26 Aug 2024 13:19:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xuCne/zgOoFvpU7/1nB2IAJD+jyiG6MgVQyRVL
	ojgYk=; b=JfevBkO++Wf3dBD9VCR/txkRW+diapCPcCdEt4NaApoO5ItsSWtxEj
	iDtdU7Q4ylUXRRjPPPVenSX2nHaaXvhwsTKVzUMNXpF6OmzTmoFcC/j5TPzHChRu
	SojMEPFBZeKFcVSbVYE1g94B5nOR5x5Lvxl7/HM+SiuuBWH6OwQ60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A4952AEED;
	Mon, 26 Aug 2024 13:19:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B150E2AEEC;
	Mon, 26 Aug 2024 13:19:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
In-Reply-To: <8c1c031b-4f36-4825-93ef-408c50b0ee2f@gmail.com> (Celeste Liu's
	message of "Mon, 26 Aug 2024 23:56:44 +0800")
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
	<Zsgh4LacdOt8N69o@tanuki>
	<6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
	<ZswfgYsZrzY6kc1E@tanuki> <xmqqa5gznwf9.fsf@gitster.g>
	<8c1c031b-4f36-4825-93ef-408c50b0ee2f@gmail.com>
Date: Mon, 26 Aug 2024 10:19:17 -0700
Message-ID: <xmqq34mrkxre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53D23E04-63CF-11EF-8977-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Celeste Liu <coelacanthushex@gmail.com> writes:

> And is there need a new patch to fix this? Or you will fix it directly?
>> 
>> The synopsis should lose "=<regexp>" part, as the option does not
>> take any arguments.

It is a separate documentation bug.  We can fix it separately.

----- >8 --------- >8 --------- >8 -----
Subject: git-config.1: two random small fixes

The synopsis says --regexp=<regexp> but the --regexp option is a
Boolean that says "the name given is not literal, but a pattern to
match the name".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
index 65c645d461..1ee5c89ba2 100644
--- c/Documentation/git-config.txt
+++ w/Documentation/git-config.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
 'git config rename-section' [<file-option>] <old-name> <new-name>
