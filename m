Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AF4683;
	Tue, 17 Dec 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394489; cv=none; b=EU1UrHpuUCU1EgdhI0mXBMzOa42quLC2NqPxZsF4EYJkMxC/a5MJIeM1DfCx3I4dc/+WsD3UNSkZfWqtIokMYib67uyj3x+zswvwv8enpsolZb0yTPYLcpK+YugICx9eimCOOhpRVK85nMwIRAO2iGjsNeq5KXm0zc3DIQgxLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394489; c=relaxed/simple;
	bh=MlW0bhXCIfOQ+2BcpaS+4C3WZbmTKrT7okw9Lw1jzpI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoWIo9VRxQY2TqeycXD/UA6yIJ0J1zGsJDG+CgA3VMoQw198oyyvBmgRvtlD+PXBQxMHOX1SCj4Cob6eH74rLFu7jE5HxCzT3wrV68+jpCjB00IMFtc5W0jV12xWnrtJpIju7X6cwW/QzBUPwuCo87ZAlkRT0t1TiPL6HwWTTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BH07TZL1657451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 00:07:30 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqfrmn4hr9.fsf@gitster.g>
In-Reply-To: <xmqqfrmn4hr9.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc0
Date: Mon, 16 Dec 2024 19:07:25 -0500
Organization: Nexbridge Inc.
Message-ID: <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFEfEaRNrZ6uu0wI6oVXmgPkoCy2rQXNl5g
Content-Language: en-ca

On December 16, 2024 1:15 PM, Junio C Hamano wrote:
>An early preview release Git v2.48.0-rc0 is now available for testing =
at the usual
>places.  It is comprised of 446 non-merge commits since v2.47.0, =
contributed by 66
>people, 26 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the 'v2.48.0-rc0' =
tag and the
>'master' branch that the tag points at:
>
>  url =3D https://git.kernel.org/pub/scm/git/git
>  url =3D https://kernel.googlesource.com/pub/scm/git/git
>  url =3D git://repo.or.cz/alt-git.git
>  url =3D https://github.com/gitster/git

Did I miss something about GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable being =
removed
from the test suite? That was available under 2.47.0 but if I supply it =
now, the tests
crash at git init.

Confused a little
--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



