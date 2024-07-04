Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8F1AE87B
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103655; cv=none; b=q/MkSSWhsx+0tOjW4tfAQCHiuRVL4zTOU1WmojZvGDQgPZ1rRqlqqX6sma7UJFds3XybA5VA9DSLMs3hssHbEadz3hVpvdORZVxzC85rzcGYN2IYO4Lda0BBBQgfcq5MMPbFuHBsZdAkZ+DjaC65xKcWhhZo3cecu7L5hDgHCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103655; c=relaxed/simple;
	bh=4XvmpkFOeAbxrBSpX1TnzZ5et3lVDfybzXgxnCtOikQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkX7ORF3Tthhq1Tm6rEyn6Vixf156WR5xEcaSwxiKSuG1JIREwL66UhbA/o2O6pZaru6zWHdbjImjYCjOfdIskojK6qE1mt0efwxAR3+m4mx8Puasne4df7Ag1WBh3J2qQSTzJUhqLaPvE3mpbftw7hQ3F98igcTuWwEPZntFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 464EY5po2419915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 14:34:05 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Abraham Zsombor Nagy'" <abrahamzsombornagy@gmail.com>,
        <git@vger.kernel.org>
References: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
In-Reply-To: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
Subject: RE: Unable to push to git server
Date: Thu, 4 Jul 2024 10:33:59 -0400
Organization: Nexbridge Inc.
Message-ID: <08e701dace1f$388be050$a9a3a0f0$@nexbridge.com>
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
Thread-Index: AQFrWY4iENBmw4H5pHVPakRrFzvPSrLFhzoA
Content-Language: en-ca

On Thursday, July 4, 2024 9:56 AM, Abraham Zsombor Nagy wrote:
>I'm trying to push my code to GitHub, however I'm unable to do so:
>
>abris@dell:~/Projects/maradandohalo/server$ git push --set-upstream =
origin main
>Username for 'https://github.com': nazsombor Password for
>'https://nazsombor@github.com':
>fatal: protocol error: bad line length 175
>send-pack: unexpected disconnect while reading sideband packet
>error: failed to push some refs to
>'https://github.com/nazsombor/maradandohalo.git'
>Enumerating objects: 31, done.
>Counting objects: 100% (31/31), done.
>Delta compression using up to 16 threads Compressing objects: 100% =
(22/22),
>done.
>
>I use Debian 12. I tried this with the git installed via apt as well =
with the git compiled
>from source code. Git version: 2.45.GIT
>
>I also asked this question first on StackOverflow:
>https://stackoverflow.com/questions/78670914/git-fatal-protocol-error-ba=
d-line-
>length-173

As far as I know, GitHub changed to use personal access tokens to =
authentication for HTTPS push rather than password. Have you tried SSH?
--Randall

