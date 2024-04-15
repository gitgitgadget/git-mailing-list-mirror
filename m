Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBF8BEF
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201190; cv=none; b=DVx/bkTNFzVkHT/Yf/5lfSNyZT32WeA1LnEMZys26W13X1FyPo3j2asoX8G440LC/e/DGsk3L/fkXBJKgh0hv7CGC8DuYvbzpnMC0/cwpMD7x9kRYOY0sMxksKIuEAJwDAqQkzNgCoSO6rmtBCHcQyGCn9VieVWbSrlDqET/uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201190; c=relaxed/simple;
	bh=Axb+A6jqEKiYsu0GpPgttBLQ03wq4U/LupXPFBKmE4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqFL7o8MyuYvGEOWZ1vCvBXrJJfp8Np+VgOSypW9Tuije0u7YN+LBhpb5j2GLAwupnyv7V4fuHBuSfz7e9UASWKLEU2Mk89uQdB1GDditz8EEK1NpGEDwgwVsxEwqLMe5h7KavbdbPcofpmOHeXscyeWqXbJIB7EWh/B9Yd0hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vBkq2eAL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vBkq2eAL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78E411FBB28;
	Mon, 15 Apr 2024 13:10:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Axb+A6jqEKiY
	su0GpPgttBLQ03wq4U/LupXPFBKmE4E=; b=vBkq2eALwK53AnlH3MNsrJtthfMK
	3ifte7qUHQkAdej0Fzy3SfW1FUjpaUg0Ml7ZZuDk794BBAaTuM8gqG0r1UhPBvgV
	E74tE6U3RryMS1jcDQeKxo5iO2Phk/enruYV1pKbbjnXPlGkNLYPIRRdstJbHT1H
	qN4iFP7Jbtk+B+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BDE1FBB27;
	Mon, 15 Apr 2024 13:10:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC41F1FBB26;
	Mon, 15 Apr 2024 13:10:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: ttdlyu <ttdlyu@163.com>
Cc: =?utf-8?B?56eD5aS054Gv56y86bG8?= via GitGitGadget
 <gitgitgadget@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] doc: git.txt-Change "--user-formats" to
 "--user-interfaces"
In-Reply-To: <1bd1d875.c81.18eda82e0cb.Coremail.ttdlyu@163.com>
	(ttdlyu@163.com's message of "Sun, 14 Apr 2024 10:49:54 +0800 (CST)")
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
	<pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
	<af548abd00485e161c2e409b0b9fa80a3a061cc8.1712822221.git.gitgitgadget@gmail.com>
	<xmqqpluvu5vk.fsf@gitster.g>
	<1bd1d875.c81.18eda82e0cb.Coremail.ttdlyu@163.com>
Date: Mon, 15 Apr 2024 10:10:36 -0700
Message-ID: <xmqqh6g2pn5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 14719C92-FB4B-11EE-8E87-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

ttdlyu  <ttdlyu@163.com> writes:

> Sorry, to be honest, I haven=E2=80=99t read this document carefully bef=
ore, I=20
> will find time to read it carefully.

Thanks.
