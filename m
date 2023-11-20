Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQ/q8miC"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B3BA
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 17:29:19 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AA4E33C24E;
	Sun, 19 Nov 2023 20:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3BRWLuQtaHb4yT3Q1XV3KnwoJR9kr/MYlD4YZr
	AP41M=; b=QQ/q8miC7BsMaIJkORe9QJk9a1z2/VlrRhRhfjlVrjW2MHpD+M6iha
	RrPvjBJdnID2mDGU9zs4q/pthC+OBmdvdhfQpnfPgZJxpruN/HdeSd39fGb9ONwo
	VHf9LUqwhEvzjhZLE27DxybIWDMoF6Bi/UflIvApUzehfs7gifMdk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A2D9D3C24D;
	Sun, 19 Nov 2023 20:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 458743C24C;
	Sun, 19 Nov 2023 20:29:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git l10n discussion group <git-l10n@googlegroups.com>,  Alexander Shopov
 <ash@kambanaria.org>,  Arkadii Yakovets <ark@cho.red>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Emir SARI <emir_sari@icloud.com>,  =?utf-8?Q?Jea?=
 =?utf-8?Q?n-No=C3=ABl?=
 Avila <jn.avila@free.fr>,  Jordi Mas <jmas@softcatala.org>,  Peter
 Krefting <peter@softwolves.pp.se>,  Ralf Thielow <ralf.thielow@gmail.com>,
  Teng Long <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>,  Git
 List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.43.0 round 2
In-Reply-To: <20231120001309.24434-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 20 Nov 2023 08:13:09 +0800")
References: <20231120001309.24434-1-worldhello.net@gmail.com>
Date: Mon, 20 Nov 2023 10:29:07 +0900
Message-ID: <xmqqr0klnrfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 33E1FD04-8744-11EE-AE35-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.43.0.
>
> The following changes since commit cfb8a6e9a93adbe81efca66e6110c9b4d2e57169:
>
>   Git 2.43-rc2 (2023-11-14 15:14:45 +0900)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.43.0-rnd2
>
> for you to fetch changes up to d30343266793525abd82c15fcb246d892f474d92:
>
>   Merge branch 'l10n/zh-TW/2023-11-19' of github.com:l10n-tw/git-po (2023-11-20 07:57:09 +0800)

Thanks.  Will do.
