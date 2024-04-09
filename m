Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DE4F881
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627357; cv=none; b=XPko/XiD74vn017CsICq3MIPdi9eu6OeJaxLT1JVme9iZrvraZcDboJbcCAyrqDd5XncZiJXyxfsCGqcIdqouwSO/8wIHJxkZSKxbw446NxCzroVchqeixVcCFZclb7TH1IjIP2ffXwLG7y5+NihX3b8mvzQ/bLjHZQthgisC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627357; c=relaxed/simple;
	bh=b2OIbqlrt83oodNLt10vmbZYXvGwJAbLWuXb9oiPL88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OxE1yVkiMUXFZ+Zt0AEX/VeVJZpHPdfwn1ujSUvc15cCMopgEoCvheepG3BFv756wyOqzKJmBVUFcTqPD4Tmk7GrAcYZMqLGsQn8+Yk7MNTXfZFvkXs22DaoY8gpUOvqZQOV4Dia9G8dRpO6bHazcXAIe0S7b3M/khgqRhsfxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q4RNIlcs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q4RNIlcs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDC6B1F6B4B;
	Mon,  8 Apr 2024 21:49:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b2OIbqlrt83oodNLt10vmbZYXvGwJAbLWuXb9o
	iPL88=; b=q4RNIlcsCfTgAhNfbFcr5PRSAo2ocT85/yNWkL5Cej9ZVpfVmD05UC
	oze5O7LwJ0nst74BRdbk6z+zLiwgiidxIGQJ5Gl19YXwLNCmssHfIt0HWzWg2v+p
	BfhLbVZBN35n7zj8FPxhtMbZ1bA3PYOnhKpN/YFcEDhlHGoIHZYCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E56F61F6B4A;
	Mon,  8 Apr 2024 21:49:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BAA01F6B48;
	Mon,  8 Apr 2024 21:49:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 3/8] SubmittingPatches: mention GitGitGadget
In-Reply-To: <owlyle5ns5me.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Mon, 08 Apr 2024 18:10:33 -0700")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<6e6950afa6e6e884ee89ac24c05b50dcc722657d.1712366536.git.gitgitgadget@gmail.com>
	<xmqqy19rp6od.fsf@gitster.g> <owlyle5ns5me.fsf@fine.c.googlers.com>
Date: Mon, 08 Apr 2024 18:49:13 -0700
Message-ID: <xmqqzfu32tly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E6BC60C-F613-11EE-A358-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

>>     Note: we outline the procedure using `format-patch` plus
>>     `send-email`, but you can also use GitGitGadget to send in your
>>     patches (see MyFirstContribution document).
>
> Ah, of course. Will update.

Sure. "can also" -> "can instead", I think.
