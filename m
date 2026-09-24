Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF0477282
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252714; cv=none; b=MfysStm9vqDsVhz26UQVRBqZabffcjLKiU05/qGaRArZ1HFDNb16Dt+2UvuINsJyN4q0vcwHgMcMLMekGXk6q4Ola9TtwJIXHaMRcPgRFjRrQD4MGB46hpqT63BHF/54aOsZ4f0NjcB33TVjQ4MnuX/QzPs/LsnNOnd29nBxxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252714; c=relaxed/simple;
	bh=inVUNmvAJBaecBNo00Nmx3Ed1K/qhS+VpS17VawIwqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxPEM/b0/tboWoFAJT04Y7LbSEXadNSnNU+z/XSTgrQfVqCqD4ZwSgILNFwHGMXbCOhpHDdUUYVrEe8+B9HyI3Z/qOpSSw/aqhiJFoV/+yAom5dMqtGDiWyreUC0i00o0AQBDu51WnFG95IufHFaNvxOIAxIe9ugwz1XS3jneC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hrChb6MxPz7T2WX
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:25:03 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hrChR0TmjzRnlY;
	Thu, 24 Sep 2026 14:24:54 +0200 (CEST)
Message-ID: <5724f206-e0b4-49eb-baf4-6f5b76d90013@kdbg.org>
Date: Thu, 24 Sep 2026 14:24:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: add Afrikaans translation
Content-Language: en-US
To: =?UTF-8?Q?St=C3=A9fan_Driaan_Turvey?= <stefanturvey1912@gmail.com>
Cc: =?UTF-8?Q?St=C3=A9fan_Driaan_Turvey_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2238.git.1790229073946.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2238.git.1790229073946.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 24.09.26 um 07:51 schrieb Stéfan Driaan Turvey via GitGitGadget:
>  po/af.po | 2733 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2733 insertions(+)
>  create mode 100644 po/af.po
On thing that is not mentioned in po/README, yet, is that new languages
must be registered in po/meson.build.

I wouldn't mind seeing no location information in a new .po file, i.e.,
passing it through `msgcat --no-location`. There are instructions in
git.git's po/README.md near "Preparing a "XX.po" file for commit" how to
automate this with a clean-filter without losing location information in
the checked-out file. You'd have to add "af.po
filter=gettext-no-location" to your .git/info/attributes to make it work
until I update the repository's .gitattributes.

-- Hannes

