Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A9446A5
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363296; cv=none; b=gcqR4ROqZQMQxVo7/UiEoksUihYlg5D6YPGWqu+uVZvRdtHSZZB2uPB0y99rjphPpYnOzav8nE20vOmTCT/eDm1A+a+dlltl9oOwFXg4tF38aFvRmghi69ctN6cq8KP2iicmYfU+Nb+J+E6WBbbYszyy9gYpstaZISzb/jWwLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363296; c=relaxed/simple;
	bh=9eU7nJezJ78A3Rtgoxj7gDxXLHpddtMOAHVY8L4eGiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C54bFoYoybaR0eHyzSjVVCKPbY5TcW9NPlI/MBLuEMTkczhLLUb/zYMpUZYXDdTcE5s7V92dpO9tNoVaNazAchZY/Mg/DObH2zDaEBGga4NJ3Eq+8Xel7T2vCWnxsf4FoWJoKDZs+OJ3wTfq4I/5wZaT19Been3hj1zy2uIqUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FFKRBuQh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FFKRBuQh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 154651D0E20;
	Mon, 19 Feb 2024 12:21:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9eU7nJezJ78A3Rtgoxj7gDxXLHpddtMOAHVY8L
	4eGiw=; b=FFKRBuQh2EaygtTwqjyE3NK4QpwkwgQUXuvEezno1pobeWpHpPN1WD
	8pOIk6H+CCBCcqlN7J7EQtLeMLYPfTsREmgNKiNB3GtloSqX28o2RWkZGqxrTO88
	GKezRMOGM6KM7Uc61Bi+RlZD1SkquV8ZXlNDyjpTsH+JBQ4SkPvw8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C3021D0E1F;
	Mon, 19 Feb 2024 12:21:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68CC71D0E1E;
	Mon, 19 Feb 2024 12:21:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git l10n discussion group <git-l10n@googlegroups.com>,  Git List
 <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,  Arkadii
 Yakovets <ark@cho.red>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Emir SARI
 <emir_sari@icloud.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Jordi Mas <jmas@softcatala.org>,
  Peter Krefting <peter@softwolves.pp.se>,  Ralf Thielow
 <ralf.thielow@gmail.com>,  Teng Long <dyroneteng@gmail.com>,  Yi-Jyun Pan
 <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.44.0 round 3
In-Reply-To: <20240219010141.5616-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 19 Feb 2024 09:01:41 +0800")
References: <20240219010141.5616-1-worldhello.net@gmail.com>
Date: Mon, 19 Feb 2024 09:21:32 -0800
Message-ID: <xmqqttm4cqub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 540A7FE4-CF4B-11EE-877A-25B3960A682E-77302942!pb-smtp2.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.44.0.
>
> The following changes since commit 3e0d3cd5c7def4808247caf168e17f2bbf47892b:
>
>   Merge branch 'jx/dirstat-parseopt-help' (2024-02-15 15:14:48 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.44.0-rnd3
>
> for you to fetch changes up to 5fdd5b989cbe5096d44e89861a92b2dd47c279d9:
>
>   l10n: zh_TW: Git 2.44 (2024-02-18 21:03:43 +0800)

Thanks.
