Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDA3947AB
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664999; cv=none; b=i2dzEYd/swlgD/iDyI3h/EnV58Q3/Gd5pdLKtzvv0LghiMFWuNOfAgtH/b1fLAfYQO33mLtFDR7JrS83G6GY2U0KvI8qTyc3Flc+02ZyYimbqzj5V8nDAZMcFgRu3GcVPAMZJSa2FVhB3nuEwe/PA8614Ca8VuQ7mseAM224KM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664999; c=relaxed/simple;
	bh=jRea7++4MmOpMpx1v+qafXH55j+/qA+x3hY9OKbIESk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcLpNtIqkcGvzzl0cLMha7Gp4bPCGDXamu8X666qI3hpyfuYEo5cevocuX+rW18aWoWiIyM8l7Ke67vW0PNKcDCu7LuxYZRMR1RmWh5+nzl76PoZDturD2Qb6jiuRiJVjItsyBQBncbKi7RC0piGAERT1/QdgFVGG1dZkcEdZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fZFB30rlfzRnlJ;
	Mon, 16 Mar 2026 13:43:07 +0100 (CET)
Message-ID: <433b3d05-ce7a-469a-8775-f6cc055fd92c@kdbg.org>
Date: Mon, 16 Mar 2026 13:43:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] l10n: add .gitattributes to simplify location
 filtering
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Alexander Shopov <ash@kambanaria.org>,
 Mikel Forcada <mikel.forcada@gmail.com>,
 Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Dimitriy Ryazantcev <DJm00n@mail.ru>, Peter Krefting
 <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>,
 Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>, Teng Long <dyroneteng@gmail.com>,
 Yi-Jyun Pan <pan93412@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773497547.git.worldhello.net@gmail.com>
 <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
 <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org>
 <CANYiYbEiDi3-MputSiHi0RZJa+BUe_6viT9HTVz+aJiSwCiw7g@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CANYiYbEiDi3-MputSiHi0RZJa+BUe_6viT9HTVz+aJiSwCiw7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.03.26 um 04:21 schrieb Jiang Xin:
> This also reminds me to rethink the naming of the following filters.
> Judging from the msgcat --no-location option, “location” refers to
> filename + line number, so defining the filters like this may be more
> appropriate:
> 
> ```shell
> git config --global filter.gettext-no-location.clean \
>            "msgcat --no-location -"
> 
> git config --global filter.gettext-no-line-number.clean \
>            "msgcat --add-location=file -"
> ```
I fully agree with this naming convention.

-- Hannes

