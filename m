Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87C13DDD2
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015756; cv=none; b=W60iE4vKbiSkbnmy3XIe1MppjKJomXeJZttncI/+CJF57w/Ev/VIpTaQbtqTAfBtnpp1RGeJ7nzqvP0jdW/uPyq/zq90H5twwdY2oqC7EaMfyqoUFySZdOEuxK9lMVj/+a+vr0rTqn2GHKnEG7JldrJvdLsv0ZgTbAg7mmQ+GWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015756; c=relaxed/simple;
	bh=TQOypNGkgzhw+wYYWLULpIw52DWEHVQQz09y9bfdAFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eG1Uf/uDlCcZ6N/PjLGpTpaf1KQp1dmg2tWtkZuMXJyeXJ2WFfSqpclw9u0vJc0J7lHgNMucAmxboYHCerfgjezxvRpoJ2zM41+iE7nssXpBdmZAjTzKQCiN5KFu9UqrQ0rCZVz5KVnKMvaOcc0tJRtK4+vje29TlvM4sggCQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YSGekqw9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YSGekqw9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0526F21F7D;
	Mon,  6 May 2024 13:15:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TQOypNGkgzhw
	+wYYWLULpIw52DWEHVQQz09y9bfdAFc=; b=YSGekqw9+g10IlWd8VmQghlS+A0w
	z1/p0kcJ384jjgAjzt4hhZ6Ct92xk0R0K1veGXTveUOUZHoMhlxfPKSl1c7LgSCw
	lGHO+BAAUC2kl+gBTca/0XgdCtLDNyLwLCGsMK1MkXrDbpX1nPqUxRwh5A6uP11k
	VMFlTsFrKghiOZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F07DD21F7C;
	Mon,  6 May 2024 13:15:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 630F521F7B;
	Mon,  6 May 2024 13:15:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  =?utf-8?Q?L=C3=A9onard?= Michelet <leonard@lebasic.com>
Subject: Re: [PATCH] po: fix typo in French =?utf-8?Q?=22aper=C3=A7u=22?=
In-Reply-To: <44cfb9fc-2757-497c-a870-4186d00abbe1@kdbg.org> (Johannes Sixt's
	message of "Sun, 5 May 2024 17:47:54 +0200")
References: <ZjVDhAvfrR8d_Hok@tapette.crustytoothpaste.net>
	<20240503201452.3355520-1-sandals@crustytoothpaste.net>
	<44cfb9fc-2757-497c-a870-4186d00abbe1@kdbg.org>
Date: Mon, 06 May 2024 10:15:51 -0700
Message-ID: <xmqqpltyzws8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4A940DC8-0BCC-11EF-892D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.05.24 um 22:14 schrieb brian m. carlson:
>> -msgstr "* Fichier binaire (pas d'apper=C3=A7u du contenu)."
>> +msgstr "* Fichier binaire (pas d'aper=C3=A7u du contenu)."
>
> Thanks! While queuing, I amended the subject line with the customary
> 'git-gui:' prefix.
>
> It'll take a week or so until I've a public repository ready.

Thanks.  I'll make sure that we'll update a few documents that
mentions git-gui maintenance.
