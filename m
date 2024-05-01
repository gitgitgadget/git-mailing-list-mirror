Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D8D2FE;
	Wed,  1 May 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585210; cv=none; b=Bvh7xA7g7Z2wvossY3IzAadGMk8F7P+o6sK+O/fmEMhuBA/eY4IxBuUalO/jCz80mdxKbf5RJVEF+ZZsc7VnBqznYadm7JRGdiy2VUah6UyhSv+KSP2JnuNWtEeoQ0FsYlf8Sm4h9Z5lz33IvgFfLWrmiOgYJWLx/QVNh83yn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585210; c=relaxed/simple;
	bh=M2iwevICI26coArTB8sBeIjerkidsmo8KUM0dh1FZwE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9cXM8s/GX4/y3+w7CNHpflOT6HLHzZhsykMfkyS3GJ2cRLsYoKo2ETi9z6S8IlLVgcEtCJy9NoKOwqm0R2VdrnWLFgqacHRCQt69yrbcTizrsmXcLwPEwRTfmj2/3ZcObBrwpejDlkyfbrx9r5k5kTWhGV0XNfyAJSIeBZNoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 441Hdubw1468678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 17:39:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq8r0ww0sj.fsf@gitster.g>
In-Reply-To: <xmqq8r0ww0sj.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.45.0
Date: Wed, 1 May 2024 13:39:50 -0400
Organization: Nexbridge Inc.
Message-ID: <0be901da9bee$950bc830$bf235890$@nexbridge.com>
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
Thread-Index: AQLjnmWw6HuMyEOTwKLAihfvlQppS69wn8uA
Content-Language: en-ca

On Monday, April 29, 2024 1:12 PM, Junio C Hamano wrote:
>The latest feature release Git v2.45.0 is now available at the
>usual places.  It is comprised of 540 non-merge commits since
>v2.44.0, contributed by 96 people, 38 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/
>
>The following public repositories all have a copy of the 'v2.45.0'
>tag and the 'master' branch that the tag points at:
>
>  url =3D https://git.kernel.org/pub/scm/git/git
>  url =3D https://kernel.googlesource.com/pub/scm/git/git
>  url =3D git://repo.or.cz/alt-git.git
>  url =3D https://github.com/gitster/git

The HPE NonStop builds for git 2.45.0 are available at the ITUGLIB =
website at =
https://ituglib.connect-community.org/apps/Ituglib/SrchOpenSrcLib.xhtml.

Thanks to the entire git and ITUGLIB teams for making these happen.

Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



