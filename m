Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C23D382
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZyjLH0P"
Received: from pb-sasl-trial2.pobox.com (pb-sasl-trial2.pobox.com [64.147.108.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863D116
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 13:17:01 -0700 (PDT)
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 90F2A3133C;
	Thu, 19 Oct 2023 16:16:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TQSlzfceLE4g
	SNMBxwl05YBchLj6HwgcVYjWSDokiGM=; b=XZyjLH0PRp941nELHHgswVuj8Vzb
	BuV5WoKdz/VUKSJMpRfXIOGhXkV+lxc9jeGeVxf1V+lzOZ0I6oHd/vgRK9zuxYsR
	wCaWjfsRLWT6uNMev1/jwjKl72LO5eWwnWqbrm0T6cAmCbyTxgfqyL1aHuFedESL
	uV35nnFkuJBflF8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
	by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 6E04031339;
	Thu, 19 Oct 2023 16:16:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A79161CA7DF;
	Thu, 19 Oct 2023 16:16:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Jeff Hostetler
 <jeffhostetler@github.com>,  Alexander Shopov <ash@kambanaria.org>,  Git
 List <git@vger.kernel.org>,  jmas@softcatala.org,  alexhenrie24@gmail.com,
  ralf.thielow@gmail.com,  matthias.ruester@gmail.com,
  phillip.szelat@gmail.com,  vyruss@hellug.gr,
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
  "lilydjwg@gmail.com" <lilydjwg@gmail.com>,  "pan93412@gmail.com"
 <pan93412@gmail.com>,  "franklin@goodhorse.idv.tw"
 <franklin@goodhorse.idv.tw>
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
In-Reply-To: <20231019194747.GC25301@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 19 Oct 2023 21:47:47 +0200")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	<xmqqzg0gx6k9.fsf@gitster.g>
	<CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
	<xmqqwmvkve83.fsf@gitster.g>
	<CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
	<xmqqcyxaxzxw.fsf@gitster.g> <20231019194747.GC25301@tb-raspi4>
Date: Thu, 19 Oct 2023 13:16:55 -0700
Message-ID: <xmqq8r7yweo8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 739F2B88-6EBC-11EE-BE75-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The switch case covers all 8 values of "enum crlf_action",
> and removing these 2 lines
>  -	warning("Illegal crlf_action %d\n", (int)crlf_action);
>  -	return core_eol;
> does still compile without a compiler warning.
> So yes, a BUG is more appropriate here.

Yeah, and if our expectation is whenever we add a new value to enum
convert_crlf_action, we will handle in and return from the switch
statement, so I agree with you that BUG() is more appropriate.

Thanks for a quick response.  Note that this was something we
discovered while talking about i18n and no immediate action is
required---it is not like we saw a report that tells us that end
users are actively getting confused by this message.

Thanks.
