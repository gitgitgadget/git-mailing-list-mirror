Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJT4k+Ni"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BAD5
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:05:24 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D7F9F21424;
	Mon, 11 Dec 2023 10:05:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OGq/334bZq4MNnrytBHMjTDs682bmqToZEdXS7
	CHpbA=; b=FJT4k+NiKYC0EZh0hDJIaGpP04g25ofxsvmYtlUsDyfHfs699hin/6
	5BMUB9YJO6ohHkkDWz1MLwfkDmu0DUEdrQWL0aUjhUJuVSHuO14Wvmx5oByAJRSB
	yANyCOEu23341+se2lv5v7Du8dAOyRjSoeu8FsvGpM2FO4VR/OH+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D004421423;
	Mon, 11 Dec 2023 10:05:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F72521422;
	Mon, 11 Dec 2023 10:05:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <git@matthieu-moy.fr>
Cc: Britton Kerin <britton.kerin@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Re* [BUG] git-bisect man page description of terms command
 doesn't mention old/new support
In-Reply-To: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr> (Matthieu
	Moy's message of "Mon, 11 Dec 2023 13:34:05 +0100")
References: <CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5VhUFPag@mail.gmail.com>
	<xmqqzfyjmk02.fsf@gitster.g>
	<24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
Date: Mon, 11 Dec 2023 07:05:17 -0800
Message-ID: <xmqqil54vkya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3034F18-9836-11EE-A527-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Matthieu Moy <git@matthieu-moy.fr> writes:

> Nit: just above we have the description for `bisect start` saying:
>
> --term-{new,bad}=<term> --term-{old,good}=<term>
>
> it probably makes sense to make both homogeneous (start with the same
> alternative, and make the {...,...} vs (...|...) notations
> consistent. The (...|...) notation seems the most common).

Thanks for noticing; I think it has already been fixed a few months
ago, but apparently what I sent predates 3f02785d (doc/git-bisect:
clarify `git bisect run` syntax, 2023-10-23).  So when the patch
gets merged, it will fix itself ;-)

> In any case, the patch looks good to me, thanks.

Thanks.
