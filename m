Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD649443
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049653; cv=none; b=XiIbl/ZU8wI+EOkXiAEmFe+YItJyL17DhagdUnjNtAJhVWnKZpL22O8xCXzHCAe1y3fc1/sWIACBKzLYgpQHwPeim6Wuxjxl2GOPHsgXSAFnfGwmDb8XA34jgs9qzpFfBuYliDtVE8rW8NIsrxLOxV6PN8ynIlm88FOPM/jtJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049653; c=relaxed/simple;
	bh=B0Jt/7ihQbMKFJEMvpXvDHww6ppa9wiHhE2KqQtSyjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cad0XxzzpsyJ8dnEfRZkPQI5YQV0QtGH2J4c6EnfzD9OS9+cVYSwL7xQaw0aABHPrVwkAuvD9zUm8wf2nTzxd9h6i6CSY0jnJj8G2iPIMb45R1WEFkt/N0wCwUrhvNCjHgndcqoxb4ajPOBFTvfUZ7emzbW6VL3bHA38m+m/8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gjt1Z4PZNz7QZM9
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 15:47:30 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gjt1N6MTXzRnlv;
	Sun, 21 Jun 2026 15:47:20 +0200 (CEST)
Message-ID: <a0035bda-68ae-4998-8e2e-f62d3bae14ef@kdbg.org>
Date: Sun, 21 Jun 2026 15:47:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org>
 <CAHwyqnWM8GpYWOLdMtaF1YJ9mTRBtK0NCQeZE4AorO==7Mz2tg@mail.gmail.com>
 <c98bc105-f868-43bd-8268-52eb56e5a7c5@kdbg.org>
 <CAHwyqnU45DKGMfhJ1e3FmaebRUWkYb39pojPU2TBgOEDvgv-DQ@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHwyqnU45DKGMfhJ1e3FmaebRUWkYb39pojPU2TBgOEDvgv-DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.26 um 15:32 schrieb Harald Nordgren:
> Same series or a new series alongside this one?
Don't start a new thread. Since you are using Gitgitgadget, I think this
means that it should be the "same series", whatever the means for you.

-- Hannes

