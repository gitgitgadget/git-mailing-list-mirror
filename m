Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05783430E2
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvMO2VQ6"
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CB1AB
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:47:31 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id BC2242CD9D;
	Tue, 17 Oct 2023 22:47:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S0mOiYlh0cOH
	fma/pvr23ftpn+M=; b=pvMO2VQ6KfwNc3MJxfsOOJIIQIQJcnWuC3utgBxGV82D
	+ezFlUUeglSOC2S6Ljbb6rLPt7gmsYeVy+gneGnrU7doNbxZYkXO5Dxxf3ZsI4Wr
	R61X5pnEOy3EiNobf1+ipKW6tSwJD8NElk0ZrcnCVZb8c+XMAZxnmvrYOXoFa+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HAtujD
	cN+SW8HtN7EhicHRLYlYzuxClmx+PMW0OBMBB6dwpV2qri+dyFExqy3AoAqMP+QW
	2S/McwcxNCkz3uWe5sw9TxhqKZ3hTzMnH2eeKXH4lWP9ESI4qF4HSnA+RHOQbNFh
	R8WxH3RgwgEej42dF8PdvQ+hN7rv5w7FHRqIk=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 9DA702CD9C;
	Tue, 17 Oct 2023 22:47:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02AB33070D;
	Tue, 17 Oct 2023 22:47:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Alexander Shopov <ash@kambanaria.org>,  Git List <git@vger.kernel.org>,
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
In-Reply-To: <CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
	(Jiang Xin's message of "Wed, 18 Oct 2023 10:01:52 +0800")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	<xmqqzg0gx6k9.fsf@gitster.g>
	<CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
Date: Tue, 17 Oct 2023 19:47:24 -0700
Message-ID: <xmqqwmvkve83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AC56AE68-6D60-11EE-AF30-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jiang Xin <worldhello.net@gmail.com> writes:

> Starting with the release of git 2.34.0 two years ago, we had a new
> l10n pipeline and the git-po-helper tool as part of our l10n workflow.
> The first version of git-po-helper introduced a validator to protect
> git command parameters and variable names in megid.

Ahh, that is the piece I was missing.  I didn't know you guys are
doing extra checks that could trigger false positives.

> E.g. In pull
> request 541 (https://github.com/git-l10n/git-po/pull/541), a
> mismatched variable name "new_index" was reported in bg.po as below:
>
>     level=3Dwarning msg=3D"mismatch variable names in msgstr: new_index=
"
>     level=3Dwarning msg=3D">> msgid: unable to write new_index file"
>     level=3Dwarning msg=3D">> msgstr: =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=
=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=
=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BD"
>
> And po/bg.po changed as below:
>
>     msgid "unable to write new_index file"
>     msgstr "=D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=
=D0=BA=D1=81 (new_index) =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD"

Wait.  Is this supposed to be a good example of validator working
well?  We use this exact message three times in builtin/commit.c; is
the validator insisting on the translated message to have verbatim
string "new_index" in it so that the end-users will see it?

I may still be confused, but if that is what is going on, I think it
is a wrong validation in this particular case.  I can understand if
we were creating say .git/new_index file and it helps the end users
to diagnose a troubled repository by running "ls .git" to see if a
file called "new_index" exists and getting in the way, but I do not
think it is the case.  A new file ".git/index.lock" is created via
repo_hold_locked_index() and I do not think it helps the end-user to
know that we may be calling it "new_index" internally among the
developers' circle.  If the message were about "index.lock", it
might be a different story, but such an error would probably have
been issued long before write_locked_index() gets called.

I'd suggest doing s/new_index/new index/ to msgid string for these
anyway.

> Later, more validators were introduced into git-po-helper for checking
> git config name, place holders, etc. "git-po-helper" used a list of
> regular expressions to find git config names, placeholders, and there
> are some false positive cases need to be ignored.

OK, and "<file>" in msgid string, for example, will automatically
insist on the translated msgstr string to have a string that is
enclosed by a pair of such angle brackets, regardless of the target
language convention?  If so, I can now understand where Alexander
comes from (assuming that the common convention in Bulgarian language
is not to use a pair of angle brackets to highlight such a placeholder
word).

I can see that you have a lot better handle on the matter than I do,
so I trust you and Alexander can resolve what the best "validation"
(and possibly override per language) should be in the git-po-helper
tool.

Thanks for explaining.
