Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30511AAC9
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962047; cv=none; b=jhJVpBix+QCkq8d0wbTmJiut/2SBYBxvKYvCTKFbo8ViFNJlatC4Lmk7QN19vscvHho7rHbLkaZmagCLeegDYUjp9EKvASW1uwmeRU0zxjQ7tbycdlL5mtDCa1RT4098SssHQ4wLKFHX87NUpJLhLiDb53xl6nLGNxl53OdyicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962047; c=relaxed/simple;
	bh=X4gG1Hr55KQIem9gyoN+nl6IbiCOKpf20CHjgv+fHvs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DJ7DZfrihJlRV8JI7MI9gFdR3roRarrDfBJR69hCJ/cQ7MLG5u+CZhk0ZwEmEb5Rb4wK/rdQGGgiOwbqWpK/iVykSZFtSNJIR7Nfs9OwuBux4WtGeLkGlWs0K2/t220AGfyIovlL9cs1lTSn5w7zdDK60m/89/uA+SL72r2eH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dUlwRVUB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dUlwRVUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752962042; x=1753566842;
	i=johannes.schindelin@gmx.de;
	bh=QWITDTAUWll0TfDPk5HHYhIvdge/BwZQN1kcFTkdYI4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dUlwRVUBBZYviFFQKHO63PQvQuTHp7111Vw7IgycDeCy3sOx/I0UgFoctv/78jVw
	 iGHlhMTjb+5+ENKj8nhOSWn0WfhSCCS9sAKV/xpMN1KNF19dXdtjaQVyC/YnWMQSI
	 B1E3nSbgYuuTeOMAxhggR0lPqsB7Y9U+1QvXD0qozXI+54cg96JJnBDAYT7rbAE7F
	 Y+hWiVAKRcaWqJJBWUu38n1aHF1ajjLeofcDbZOp/6mfY9jqQLxljhqbNM7Aw1S+O
	 mChTqXkRJ2h3YbCu+2+LTNauddLBB3oAq+puAu9zi5IITWzxvCAG3SaigSap5Zons
	 d63lUrQxsr/iAMemmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1uKLhq3ndj-00P18B; Sat, 19
 Jul 2025 23:54:01 +0200
Date: Sat, 19 Jul 2025 23:54:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 7/7] github_workflows: install rust
In-Reply-To: <0de0867ab44f316911bd34b9ceddbc8606e938f2.1752784344.git.gitgitgadget@gmail.com>
Message-ID: <835beb3f-cc31-16cc-ea2f-55d70f700cfe@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <0de0867ab44f316911bd34b9ceddbc8606e938f2.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OJTDOVx81laFFsLXaTknFimCCPsZDGgI4JLYdqvlCkpIvi8vXPH
 8gsGkSyKnV8ynZaO40goj065nP8zJdciQKsw3BNG2PCQJi+uDfkwPCD4KacsqGLg/pWP2a7
 siZi+7TXrDEfcjCgpvrVmulRHBdwQuF1TiRSajrmLWaZvrbo58TaIJEnuD+z2ZReTvPKNlk
 3JqEDYaNnH+jfxevEoTXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KwX9uxf5rJk=;Se5ZfCRvAc8u0zuZTLYYdKDFsKD
 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
 tx20E=

Hi Ezekiel,

On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:

> +if [ "$dir_git_root" != "$dir_build" ]; then
> +  src=$dir_rust/target/$rust_target/$libfile
> +  if [ ! -f $src ]; then
> +    echo >&2 "::error:: cannot find path of static library"
> +    exit 5
> +  fi

As I found out the hard way, this error message could be more helpful if
it specified a couple of those variables that play into the failure (or
all of them).

Would you mind changing the error message accordingly?

Thank you,
Johannes
