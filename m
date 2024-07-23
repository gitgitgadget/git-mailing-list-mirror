Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805413BAD5
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777784; cv=none; b=AYp8DZOSLWTjCr+6B+W6feddRI0dnC5NdLMQRLp/hG/BZoI5Ra8ibEy4Xw3n5mC7k98w5nkBIVQ7P/2uFFzLYBbOGun0DpODd/CVXN8i6Q7/XjgJLzWbwdmAplIgZtrJ24zX4MPT9RO/ujn50PU9mFDuDoKlkLK1VX6yde9nOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777784; c=relaxed/simple;
	bh=Pp4NgPfE9juAjs3mM53ayEWVq2GFQphXSsx1opFQhEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wyrb63kzcHzPU30D1ZL7jLqLYSmGvu7qFM/xze/tiyWtevb0I/9LDMZD+3susffmiUpR72MBDHbHmo8ieEg2Kx1KZYmO4AKWwHxx3dJ8AglRQHgY864fVh12+XfaZSUUSIUHCQETtZ4laimj+pX7A+HEcNKXQwlNfOb6brw3Nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fmPgDBDr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fmPgDBDr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 380BA30E2C;
	Tue, 23 Jul 2024 19:36:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Pp4NgPfE9juA
	js3mM53ayEWVq2GFQphXSsx1opFQhEg=; b=fmPgDBDrtuI8O7W3ptF+X64GI3Sd
	sV9N5rmvtRF8qS0UrQvsalt39UUx6bKvOeVSTJJDmzesHYmWikPHGFtA+QhjPJtT
	mXRWRRXFmqZfrNHWqnL5CsbK3jDiEGlq5dH+7dXCEj+0lCYRCYBgROCnatE7x1Dt
	yGu/nsZcDo9rRRw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F57830E2B;
	Tue, 23 Jul 2024 19:36:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91A8530E2A;
	Tue, 23 Jul 2024 19:36:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/3] doc: introduce a synopsis custom paragraph attribute
In-Reply-To: <704f0333ef17c0e3596ba7ef7976ba6584345eff.1721774680.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 23 Jul 2024
	22:44:38 +0000")
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<704f0333ef17c0e3596ba7ef7976ba6584345eff.1721774680.git.gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 16:36:20 -0700
Message-ID: <xmqqo76nznnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5E0E789E-494C-11EF-85A4-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +ifdef::backend-docbook[]
> +ifdef::doctype-manpage[]
> +[paradef-default]
> +#synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed -E 's!&lt;=
[a-z-]+&gt;!<emphasis>\\0</emphasis>!g' -E 's!([a-z-]+)!<literal>\\1</lit=
eral>!g'"
> +synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"perl -pe 's!([\=
[\] |()>]|^)([=3D+a-zA-Z0-9-:+=3D]+)!\\1<literal>\\2</literal>!g;s!(&lt\\=
;[a-zA-Z0-9-.]+&gt\\;)!<emphasis>\\1</emphasis>!g'"
> +#synopsis-style=3Dtemplate=3D"verseparagraph"

This has three candidate definitions, but two are commented out?

> +endif::doctype-manpage[]
> +endif::backend-docbook[]
> +
> +ifdef::backend-xhtml11[]
> +[paradef-default]
> +synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"perl -pe 's!([\=
[\] |()>]|^)([+a-zA-Z0-9-:+=3D]+)!\\1<code>\\2</code>!g;s!(&lt\\;[a-zA-z0=
-9-.]+&gt\\;)!<em>\\1</em>!g'"
> +endif::backend-xhtml11[]

With this update, do we now assume that anybody who want to format
the documentation from source must have a minimally working Perl on
their $PATH?  It probably is an OK requirement to have.
