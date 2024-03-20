Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9261CD1D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935541; cv=none; b=m3H15qSL85mOrcni+vEndqQIgFrYk9kvUzcsx7GANudwRXb5JTPmNN48tHiejE3FLWsHruTwcdhX+PZO1esSBeG+XLbyERtbRK4lbZSsaxQzTCFc0fTlAU3L6CaPARQdVI1DN6SOsaQCRDkGhwN8IgxMli3M4f2Ixzwyx9BzicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935541; c=relaxed/simple;
	bh=eRl1C/iRcLTTAPagZx7i11jFuHrSyCH7FF24tzmkY7A=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nFBvl4lK2Ki/3qa6C+PYSW6RGGwpSbDLkgBD7mLe8vmukBWZQaBmkemtyVAV68g5oigrS894GwLWumsR1VOdSEmhev1FIqpaQOOX8wcuPA1ngTpct0zIGSy8YiBy+BsprAwyC/wkLx44a8byBKZzqMehaCqi30frb8oPl7BIVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42KBq9823219945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 11:52:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <jjb8256@sina.com>, <git@vger.kernel.org>
References: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
In-Reply-To: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
Subject: RE: git push error
Date: Wed, 20 Mar 2024 07:52:03 -0400
Organization: Nexbridge Inc.
Message-ID: <02ef01da7abd$0a33b760$1e9b2620$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQE8nt8QPdMmKGtSjIgdtpMjeZevTrJ8O4Vg

On Wednesday, March 20, 2024 3:17 AM, jjb8256@sina.com wrote:
>    git push =
=E6=97=B6=E5=8F=91=E7=8E=B0=E5=A6=82=E4=B8=8B=E6=8A=A5=E9=94=99=EF=BC=8C=E5=
=B0=9D=E8=AF=95=E6=97=A0=E6=B3=95=E4=BF=AE=E6=94=B9=EF=BC=8C=E8=AF=B7=E5=B8=
=AE=E5=BF=99=EF=BC=8C=E8=B0=A2=E8=B0=A2=EF=BC=81
>
>$ git push
>Enumerating objects: 9, done.
>Counting objects: 100% (8/8), done.
>Delta compression using up to 8 threads
>Compressing objects: 100% (5/5), done.
>Writing objects: 100% (5/5), 701 bytes | 233.00 KiB/s, done.
>Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>remote: The gitlab-shell hooks have been migrated to Gitaly, see
>https://gitlab.com/gitlab-org/gitaly/issues/1226
>To http://10.11.15.10/ks-rd-fw/git-train-2022.git
> ! [remote rejected] develop -> develop (pre-receive hook declined)
>error: failed to push some refs to =
'http://10.11.15.10/ks-rd-fw/git-train-2022.git'

This looks like a problem with the pre-receive hook on your GitLab =
installation on the server-side, or that script is rejecting the push. =
This probably should be referred to the GitLab team for support =
(possibly at your company).

--Randall

