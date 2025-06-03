Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4C253F3D
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990026; cv=none; b=OrKx7Cf9kSPyrPhRDytaR7Irb51tq0jQEtSfBLJwiWHOpYO+Wf3f92UeWGgjOge55Nc2DwK5i78JG3M6PAzLDbxh7SScAmeucZEQNYhh+7YxpYL6vojEyzLOF9MeURVChG8xHnKH8guIVH+kX1hepZTnDc28cwQIepOVh0vwSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990026; c=relaxed/simple;
	bh=p+J3b9sbM1rV1E5LjsFsO+jH2sF9vkwTIMNM0K+85VE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GpILoY7jS+Yh3g8j74tgAEp1yNvTRHpyS+q1kYezk9ubj3s9DKSmUTg8Lf/aMWEdQ+Cn1YZ/D4vbg6OjnH4v++LF/CGuUKzrexmVAF2raRHhCw1bhVUuRHmNU1IHpQFPzwbCGwp853rIu3hDDNc3SwdCggv/mi6Ajh0Wx4oBUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([185.122.133.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 553MXWXx249122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 22:33:33 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqsekgn4gk.fsf@gitster.g>
In-Reply-To: <xmqqsekgn4gk.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed 
Date: Tue, 3 Jun 2025 18:33:26 -0400
Organization: Nexbridge Inc.
Message-ID: <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvU11de0Db8TU/sQ5K/IINPh0JRqw==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250603-6, 6/3/2025), Outbound message
X-Antivirus-Status: Clean

On June 3, 2025 1:03 PM, Junio C Hamano wrote:
>A release candidate Git v2.50.0-rc1 is now available for testing at
>the usual places.  It is comprised of 592 non-merge commits since
>v2.49.0, contributed by 84 people, 33 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the
>'v2.50.0-rc1' tag and the 'master' branch that the tag points at:
>
>  url =3D https://git.kernel.org/pub/scm/git/git
>  url =3D https://kernel.googlesource.com/pub/scm/git/git
>  url =3D git://repo.or.cz/alt-git.git
>  url =3D https://github.com/gitster/git

I hit a new issue during the test phase.

Makefile:200: recipe for target 'lib/tclIndex' failed

Is there any way to suppress this? I don't think we need TCL - don't =
have it anyway on NonStop.

Regards and thanks,
Randall

