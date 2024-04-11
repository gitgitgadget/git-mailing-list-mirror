Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D03139CF6
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859075; cv=none; b=FhPvn7da0LmvF+b+HRo3mHMZXWO8H7KgnjkZF/iRzF3tz8uBxnsF3cpPWM0SbayRAEwclf68J4tJYwlsLFaxf1f6FHDG4RF4emd7VSXoTjChuZmk+iG8jMpqflhqrwJJP/V8NRANuv6NOH/BMY9jdimAEHONnMkBXv98cR2RD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859075; c=relaxed/simple;
	bh=NpRYeapsu75d2O8XvvRq66VBkbWzEavgXuZcoEBvmCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EluU2l5SQia6D1vwKDBrSsCaXE5Yj5R8kJwciCpvW7o8Ae9aotFlqLrM8R913EikzFR6fbvv6QcZYjVNeSvN9dUw2gbc3NviJxWiYr7EeQBLu852pczBocOqo1lrHiPRYe7yArEDoNTu7CqXVtaH9EeppHiu0HyGPjBhvVEAY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fHEebXGo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHEebXGo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE281EA88D;
	Thu, 11 Apr 2024 14:11:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NpRYeapsu75d
	2O8XvvRq66VBkbWzEavgXuZcoEBvmCE=; b=fHEebXGolGghVlXgVEWMtzUVSEPo
	F26HhEeCwYK0SBo5+DH/WorYGM88BhIJq4NApFKeYGj/kcOfrgK1+J5++iC7n7u/
	xy/X00HIV9glaHf4sl8g40Lu0rz9CeyPHiVBtCF+hvD8i4OYAhTQ/eWFaWuIvS3+
	CksMpQXzTDpxt1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A533B1EA88C;
	Thu, 11 Apr 2024 14:11:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 213CD1EA88B;
	Thu, 11 Apr 2024 14:11:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?56eD5aS054Gv56y86bG8IHZpYSBHaXRHaXRHYWRnZXQ=?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?56eD5aS054Gv56y86bG8?= <ttdlyu@163.com>
Subject: Re: [PATCH v2 2/2] doc: git.txt-Change "--user-formats" to
 "--user-interfaces"
In-Reply-To: <af548abd00485e161c2e409b0b9fa80a3a061cc8.1712822221.git.gitgitgadget@gmail.com>
	(=?utf-8?B?Iueng+WktOeBr+esvOmxvA==?= via GitGitGadget"'s message of "Thu,
 11 Apr 2024 07:57:01
	+0000")
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
	<pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
	<af548abd00485e161c2e409b0b9fa80a3a061cc8.1712822221.git.gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 11:11:11 -0700
Message-ID: <xmqqpluvu5vk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E0F6B952-F82E-11EE-A32E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC via GitGitGadget" <gitgitg=
adget@gmail.com> writes:

> From: =3D?UTF-8?q?=3DE7=3DA7=3D83=3DE5=3DA4=3DB4=3DE7=3D81=3DAF=3DE7=3D=
AC=3DBC=3DE9=3DB1=3DBC?=3D
>  <ttdlyu@163.com>
>
> Signed-off-by: =E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC <ttdlyu@16=
3.com>

Have you followed Documentation/SubmittingPatches document,
especially the part marked with [[real-name]]?

Just double checking.
