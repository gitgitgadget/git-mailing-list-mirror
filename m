Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2712D7393
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319904; cv=none; b=fnk7l3eYFxil8tID5LeCH9yXK2lUC2uexZo3vxK3HR4gUV1aeLItWPZBaxnhbg2UYCahW64QKuab5e1tHy9sQxvB5P0T9foZYc3m7Y5OCRzGVqxWTCeCvNDoN4v7GvN7EiV2NKjcXKzL8N8E7SHPOMVtEv53rGCuPy3sH/PAXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319904; c=relaxed/simple;
	bh=ehsNFkMr2KLsXXtY+AwoTgtjsp9iN0OoDyY+4VlrzWo=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NdojhbmGvOJ+TRLthlAlUGu7zLbk9mML2Q9jcjxmZBSVz5TVYilDmzmVZoD5hAOIXh9zdALu7KmN/XrD07x4llS04iNajG1RsG4aIyzUVfseXlCtdI53IZZqQr/2BwCjXU9DDLtF/RotKTG9B9jFGisfNrZd3UfD5mwJ38x9Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 60DFncoI148835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 15:49:38 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Manuel Rego Casasnovas'" <rego@igalia.com>, <git@vger.kernel.org>
References: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com>
In-Reply-To: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com>
Subject: RE: git shortlog --committer vs --committer=<pattern>
Date: Tue, 13 Jan 2026 10:49:32 -0500
Organization: Nexbridge Inc.
Message-ID: <018701dc84a4$39555970$ac000c50$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQERmRoTD/v82/K6ZL5Eq2JmOn97NrbmFdHQ
X-Antivirus: Norton (VPS 260113-4, 1/13/2026), Outbound message
X-Antivirus-Status: Clean

On January 13, 2026 10:23 AM, Manuel Rego Casasnovas wrote:
>Doing something like this in a Git repository returns an error (git =
version 2.51.0):
>$ git shortlog --committer=3Dfoo
>error: option `committer' takes no value
>
>However the option "--committer=3D<pattern>" is in the documentation:
>https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---
>committerpattern
>
>But it seems to be in conflict with "--committer":
>https://git-scm.com/docs/git-shortlog#Documentation/git-shortlog.txt---
>committer
>
>It would be nice to either allow using "--committer=3D<pattern>" for =
shortlog, or if
>that's not possible fix the documentation.

I do not see --committer=3D<pattern>, but do see --committer pattern in =
the online
help and documentation. --committer is an alias for --group=3Dcommitter.
Pattern applies to the log entries.

