Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB119E97A
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120418; cv=none; b=JrGNzA90OnK5oubc454sNJzLNBfCQqkeQRGlcM0EHKlBk+JrE6gJBUrDRTkZh0PABxSjcjrD5yC5rLB7iBn2/GvJeSFsYj3KzQQcGGrS14g5JxFjZdgeD6ioDJX/6fJOJNokUTdC7bVpdHTKqudG38smZZGZKBE6tdMMJcQrC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120418; c=relaxed/simple;
	bh=+20pgPs/qQ8gbPoM4pw/LRFnioPLa48vJl90fdoXW6A=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/pbcskUAy+bpLhnYmJJwAO2O8lUBoii34odChREBFdH/eF8gLNNt36fbSAIKJISQEUj9ZZGe9nyk42xe5WP3QyE5LoZcqXy1+GiROHrKdAB2dUQW6XqNXfrL9uNgO899BBwpga46vHP1YixUDKM16/ZShkxWGxB09h/iXWYAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48NJeETX1000120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 19:40:14 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Alistair Cairns'" <alistairc3@gmail.com>, <git@vger.kernel.org>
References: <4E002778-B3D4-49FA-A514-B2423CE8838E@gmail.com>
In-Reply-To: <4E002778-B3D4-49FA-A514-B2423CE8838E@gmail.com>
Subject: RE: Username bug
Date: Mon, 23 Sep 2024 15:40:08 -0400
Organization: Nexbridge Inc.
Message-ID: <00d301db0df0$693896b0$3ba9c410$@nexbridge.com>
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
Thread-Index: AQLduzzm48PT7aHo20QM1MS8BfPtYbBgagKQ

On September 23, 2024 3:01 PM, Alistair Cairns wrote:
>I recently changed my username but it resulted in adding the new one to =
the old
>one and now I can=E2=80=99t even try changing it again to the name I =
want because now it
>says the name already exists! Github Community has it well described in
>conversation #69890. =E2=80=98Username did not change=E2=80=99. I am =
unable to expand the
>window to see what the solution is. Is there anyone who knows?

I think this is an issue for GitHub, not core git. You might want to =
change your discussion to an Issue on that website.
--Randall

