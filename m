Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7332C64
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljdzb/uB"
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4432CF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:18:45 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 77FA0217E0;
	Thu, 19 Oct 2023 15:18:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m5sdXDcnlJKa8ihlF1hmnHatOxE=; b=ljdzb/
	uBJzMXru0t2fNkdK/L0GjFvS0hFWjz0ctDdA8Zj4vog6SGa011kr6wlPdcL3xI7F
	X/jXK0eaIx4Gp9RGz5xFj84Mqcq+O5jbl8U8NFWZjCo+maRq8W+I/GjgePHB4DTm
	ulEhoHtJLQDyddDVtZkHJged9ExpB75luSnik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZngmzBt0bKHhkcNcnR4GbrXaMHAwFLjV
	PnfPd1hupNTUUgi/iQXHegPzf8GO9mfeM+mBXEbVFrYtKq2w+5by60R8Ckv5jnF/
	PV2W6sAk6pgWSZgqZeVAe3wjYuIBp7BO/DS31EGrL4ApUOoMpnrD939Ye/JFr4Vp
	JlfwBuid6Qw=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
	by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 58CA4217DD;
	Thu, 19 Oct 2023 15:18:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B967429C3C;
	Thu, 19 Oct 2023 15:18:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gersha?=
 =?utf-8?Q?usen?=
 <tboegi@web.de>,  Jeff Hostetler <jeffhostetler@github.com>,  Alexander
 Shopov <ash@kambanaria.org>,  Git List <git@vger.kernel.org>,
  jmas@softcatala.org,  alexhenrie24@gmail.com,  ralf.thielow@gmail.com,
  matthias.ruester@gmail.com,  phillip.szelat@gmail.com,  vyruss@hellug.gr,
  christopher.diaz.riv@gmail.com,  jn.avila@free.fr,
  flashcode@flashtux.org,  bagasdotme@gmail.com,  =?utf-8?B?w4Z2YXIgQXJu?=
 =?utf-8?B?ZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  alessandro.menti@alessandromenti.it,
  elongbug@gmail.com,  cwryu@debian.org,  uneedsihyeon@gmail.com,
  arek_koz@o2.pl,  dacs.git@brilhante.top,  "insolor@gmail.com"
 <insolor@gmail.com>,  peter@softwolves.pp.se,  bitigchi@me.com,
  ark@cho.red,  kate@kgthreads.com,  "vnwildman@gmail.com"
 <vnwildman@gmail.com>,  pclouds@gmail.com,  "dyroneteng@gmail.com"
 <dyroneteng@gmail.com>,  "oldsharp@gmail.com" <oldsharp@gmail.com>,
  "lilydjwg@gmail.com" <lilydjwg@gmail.com>,  me@angyi.io,
  "pan93412@gmail.com" <pan93412@gmail.com>,  "franklin@goodhorse.idv.tw"
 <franklin@goodhorse.idv.tw>
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
In-Reply-To: <573f1142-d1de-b379-2f8b-07396c1249ec@jeffhostetler.com> (Jeff
	Hostetler's message of "Thu, 19 Oct 2023 14:07:16 -0400")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	<xmqqzg0gx6k9.fsf@gitster.g>
	<CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
	<xmqqwmvkve83.fsf@gitster.g>
	<CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
	<xmqqcyxaxzxw.fsf@gitster.g>
	<573f1142-d1de-b379-2f8b-07396c1249ec@jeffhostetler.com>
Date: Thu, 19 Oct 2023 12:18:37 -0700
Message-ID: <xmqqjzriwhde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EAC67F8-6EB4-11EE-BFBD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yeah, I think it should be an untranslated trace2 message rather
> than an error.  You're right, the user cannot do anything with
> that information -- and by emitting a "trivial" result, we fall
> back to the normal behavior and cause the client to a regular
> scan. So there is no reason to scare the user.

Thanks for a quick response.  Note that this was something we
discovered while talking about i18n and no immediate action is
required---it is not like we saw a report that tells us that end
users are actively getting confused.

THanks.
