Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE86430F4
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qpZab4Yg"
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0CB0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:50:07 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 91D392BF50;
	Tue, 17 Oct 2023 17:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2Lk6olHsK4nC
	nxCsYwr42xN2SZk=; b=qpZab4YgmhviRsa/ncmR0a3xeNqVG9pkCW6t43sb5/OR
	SSu1Mf9c5go/zBBpX5mPtBaGHcw/I4ewmR3u++nYZAQMHbBgLNAA1QQM400jx2it
	vtLQZE2/77EUmRduqvFLbvT2UYaHAhPTMkSajhXVZGfen/6bavhoHF9g0Rr+RFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CHgbgo
	cR3j5nGv9x+2vYzIeCFW+5O4MQufZbWKzst+VvWMuQrXZR81bCBBGjwyJVn8rZR1
	LoYbHAjxzyOI+Mg7Z9l0pUQ1Gr53pux2YUbsDo3JmN8dJDQ9lThMjXgFjtym7m2X
	xIsFPbk4sWujthqzaWo4TqVstA0sWjGiUtvwc=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 727182BF4F;
	Tue, 17 Oct 2023 17:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EAF4F18EC5;
	Tue, 17 Oct 2023 17:49:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: Git List <git@vger.kernel.org>,  jmas@softcatala.org,
  alexhenrie24@gmail.com,  ralf.thielow@gmail.com,
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
  "lilydjwg@gmail.com" <lilydjwg@gmail.com>,  me@angyi.io,  Xin Jiang
 <worldhello.net@gmail.com>,  "pan93412@gmail.com" <pan93412@gmail.com>,
  "franklin@goodhorse.idv.tw" <franklin@goodhorse.idv.tw>
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
In-Reply-To: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	(Alexander Shopov's message of "Tue, 17 Oct 2023 23:09:50 +0200")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
Date: Tue, 17 Oct 2023 14:49:58 -0700
Message-ID: <xmqqzg0gx6k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1EAAD720-6D37-11EE-B764-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexander Shopov <ash@kambanaria.org> writes:

> Typical example:
> ORIGINAL
> msgid "  (use \"git rm --cached <file>...\" to unstage)"
>
> TRANSLATION
> msgstr ""
> "  (=D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =
=E2=80=9Egit rm --cached %s =D0=A4=D0=90=D0=99=D0=9B=E2=80=A6=E2=80=9C, =D0=
=B7=D0=B0 =D0=B4=D0=B0 =D0=B8=D0=B7=D0=B2=D0=B0=D0=B4=D0=B8=D1=82=D0=B5 =D0=
=A4=D0=90=D0=99=D0=9B=D0=B0 =D0=BE=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81=D0=B0)"
>
> The important part are the `<' and `>' delimiters of the term "file"
>
> Instead of using them - I omit them and capitalize the term. As if `<'
> and `>' are declared as localizable and then I translate them as `',
> `'

Is it because it is more common in your target language to omit <>
around the placeholder word, or is it just your personal preference?

Whichever is the case, I am not sure how it affects ...

> So I am asking - is there any interest from other localizers to have
> such a feature? Would the additional maintenance be OK for the
> developers?

... the maintenance burden for developers.  Perhaps I am not getting
what you are proposing, but we are not going to change the message
in "C" locale (the original you see in msgid).  In untranslated Git,
we will keep the convention to highlight the placeholder word by
having <> around it, so the "(use \"git rm --cached <file>...\" to
unstage)" message will be spelled with "<file>".  You can translate
that to a msgstr without <> markings without asking anybody's
permission, and I do not think of a reason why it would burden
developers to do so.

As long as the target audience of your translation wants to see
<file> to be translated to =D0=A4=D0=90=D0=99=D0=9B without <> around the=
 word, I do
not think there is any problem doing so.  I of course am assuming
that using capitalized placeholder is the norm for all users who use
Bulgarian translated Git---if it is not some users want to see <>
around the placeholder word just like "C" locale, then you'd need to
answer your users wish first, or course, but that would not need to
concern the developers who write the "C" locale messages.

Thanks for helping Git easier to use for users with your language.
