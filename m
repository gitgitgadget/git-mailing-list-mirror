Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D73219E1
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456289; cv=none; b=nf/c7duslcuc2WAuwBGnm2bq4ipps0r/nw0shbSKjOrWcIWEtp/69QWuJPR4SUxE/sjlj+G++rUyN/Ls8X23O9HZ9G1MIrveLoQ6BGgGxDXUrl3U0L43xIbAa3hCTTKgmytp3Mr2McrbPF3P2aZuXnGCGHviHr5fpOpC7rQ1dZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456289; c=relaxed/simple;
	bh=rh7RHKgKrKBsrfD9NqUfc/IYUVQD3XUshq2wRm+0dpI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JKlRAD+KUVzLPkUynZ+7Sy3wf9uTdK5kNQH2RsIXL5ZT4cZeC4uB7fQopgXYmfpve4WVCVCKmXnodJzYaDa+UTC35/+AG3IIKdsd0YB4KKaF1n+amH/Qr+7Z00V1pZJ9xlHIKifNWZOZwHVRq5eoIM8grOE6VuEjXwLcidfDjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46VK4Zrw3310537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 20:04:35 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Josh Steadmon'" <steadmon@google.com>,
        "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "=?iso-8859-1?Q?'Ren=E9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
References: <cover.1722415748.git.ps@pks.im> <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im> <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
In-Reply-To: <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
Subject: RE: [RFC PATCH 1/3] t: import the clar unit testing framework
Date: Wed, 31 Jul 2024 16:04:29 -0400
Organization: Nexbridge Inc.
Message-ID: <00a801dae384$de2780d0$9a768270$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQE8qfSQAlNXoAuzPgHRYA==

On Wednesday, July 31, 2024 2:27 PM, Josh Steadmon wrote:
>On 2024.07.31 11:04, Patrick Steinhardt wrote:
>> Import the clar unit testing framework at commit faa8419 (Merge pull
>> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The
>> framework will be wired up in subsequent commits.
>
>Rather than forking our own copy of clar, could we just add it as a
submodule
>instead?

What are the requirements to build/use this?

