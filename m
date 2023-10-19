Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CC36B17
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXbiuRxl"
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 10:58:41 PDT
Received: from pb-sasl-trial3.pobox.com (pb-sasl-trial3.pobox.com [64.147.108.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9886E8
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:58:41 -0700 (PDT)
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id EB53F18FD9;
	Thu, 19 Oct 2023 13:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0hdjmYMQwjyiUDbycEWXrU03NSo=; b=YXbiuR
	xl70FqvhXp/qYQLniXYVvs3o9JXMIem3WL5sTyn+PcvOwDO68JqEwnSW6uPKJCve
	uOQ7wG2Cy+a+DzzQbeRQcfN2j9BL3uyDgFZqyX4KkdjHRfUU8Yxb2vY8kvIDLMjf
	mNB3nM+WHbrOGM6yBZcnVgYEdGp/+2O9/LwzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D08bVFLjelAYdzZv4wmiaJJZi7jPFnje
	Kun5nVjgQSU0mMwFHWLJFfRoATiw4Fszhb9ppr18GEYGdKlifXJMnv/57rMnfRcu
	5vscbut50vxCVxTVNHH/ZHGz2Kq7GExegwlvd6pl8xxEXgxD8UEWoDvmnc2HzIxn
	2VNrvdLFiz8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
	by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id C946B18FD6;
	Thu, 19 Oct 2023 13:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 093441C9801;
	Thu, 19 Oct 2023 13:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>,
    Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>
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
In-Reply-To: <CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
	(Jiang Xin's message of "Thu, 19 Oct 2023 13:08:10 +0800")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	<xmqqzg0gx6k9.fsf@gitster.g>
	<CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
	<xmqqwmvkve83.fsf@gitster.g>
	<CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
Date: Thu, 19 Oct 2023 10:52:11 -0700
Message-ID: <xmqqcyxaxzxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BC39410-6EA8-11EE-B825-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> I tried to find similar patterns in `po/bg.po` using:
>
>     $ git  grep -h -B5 '([a-zA-Z_\.]*_[a-zA-Z_\.]\+)' po/bg.po
>
> And find other translated variable names in Bulgarian as follows:
> ...
> I suppose it would be better to keep those variable names
> unchanged.

To me, all of them refer to names given to variables, functions, and
mechanisms used internally as implementation details, and they are
meant to help developers diagnose when end-users hit these errors.

I agree with you that translating these would be counter-productive
for that purpose.

Having said that, I have to wonder if in an ideal world these should
be written in terms that are more end-user facing.

>  * cookie_result in builtin/fsmonitor--daemon.c:
>
>    error(_("fsmonitor: cookie_result '%d' != SEEN"),

[jch: cc'ed JeffH for area expertise]

For example, what does it mean to the end user when the
cookie->result we retrieve is different from FCIR_SEEN?  We lost
sync with the fsmonitor daemon backend and to avoid yielding
incorrect data we will be giving the "trivial" response only?  It is
not obvious from the code and b05880d3 (fsmonitor--daemon: use a
cookie file to sync with file system, 2022-03-25) that added it why
the end-user might even want to be shown this message [*].  I wonder
if this should be an untranslated trace2_* message that are meant
for debugging.

	Side note: and isn't the significance of the event
	    "warning", not "error"?  As far as the end-user is
	    concerned, after emitting this message

Also some of them might better be a BUG(), instead of die(_()).

>  * crlf_action in convert.c:
>
>     warning(_("illegal crlf_action %d"), (int)crlf_action);

[jch: cc'ed Torsten for area expertise].

For example, can convert.c::output_eol() be called with an illegal
crlf_action that is not covered by the switch() statement due to
data error, not a programming error?  From my quick scan, it looks
like that the error should never happen no matter what end-user
mistakes (e.g., misspelt attribute and configuration variable names
in their files) are fed to convert_attrs(), and can come only from a
bug in that function (e.g., long and convoluted if/else cascade fails
to assign any value to ca->crlf_action and leaves an undefined and
"illegal" value there).

Thanks.
