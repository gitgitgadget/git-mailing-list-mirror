Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540154FA0
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTm7fdl9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D96901D6C94;
	Mon,  8 Jan 2024 14:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J1XhYPju91Ar
	n9q8lpjiNI8C4VE3Muf3QFXmi94xswk=; b=PTm7fdl91P/Ao9SJkkf8rP0qCvBX
	R6mNOJPriCkc05f1/XOMNvmrht7GDDIyPsCF4WC2pcWZdzQQAxufkDEvLDtF1XVu
	NenwLTsune30zrXLjX3uX3GrQpXkEEW6kU3ef/hosgkClEKjib1gOeb5QrkPj5LV
	DY8TUu8ezCeit9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D03151D6C93;
	Mon,  8 Jan 2024 14:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F4271D6C92;
	Mon,  8 Jan 2024 14:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  j6t@kdbg.org
Subject: Re: [PATCH v7 1/1] mingw: give more details about unsafe
 directory's ownership
In-Reply-To: <20240108173837.20480-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Mon, 8 Jan 2024 18:38:37 +0100")
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
	<20240108173837.20480-1-soekkle@freenet.de>
	<20240108173837.20480-2-soekkle@freenet.de>
Date: Mon, 08 Jan 2024 11:18:44 -0800
Message-ID: <xmqqle8zk50r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BDFC4142-AE5A-11EE-9F98-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

S=C3=B6ren Krecker <soekkle@freenet.de> writes:

> Add domain/username in error message, if owner sid of repository and
> user sid are not equal on windows systems.

Will queue.  "git am --whitespace=3Dfix" noticed numerous whitespace
breakages in the patch, which has been corrected on the receiving
end.  Please make sure your future patches will not have such
problems.

Thanks.


$ git am -s3c ./+sk-v7-mingw-ownership-report
Applying: mingw: give more details about unsafe directory's ownership
.git/rebase-apply/patch:23: trailing whitespace.
			  &pe_use);=20
.git/rebase-apply/patch:27: trailing whitespace.
	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user);=20
.git/rebase-apply/patch:45: trailing whitespace.
			LPSTR str1, str2, str3, str4, to_free1 =3D NULL,=20
warning: 3 lines add whitespace errors.
.git/rebase-apply/patch:23: trailing whitespace.
			  &pe_use);=20
.git/rebase-apply/patch:27: trailing whitespace.
	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user);=20
.git/rebase-apply/patch:45: trailing whitespace.
			LPSTR str1, str2, str3, str4, to_free1 =3D NULL,=20
warning: 3 lines applied after fixing whitespace errors.
Using index info to reconstruct a base tree...
M	compat/mingw.c
Falling back to patching base and 3-way merge...
Auto-merging compat/mingw.c
