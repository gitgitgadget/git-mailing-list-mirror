Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B36BB28
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470106; cv=none; b=gIX9zE2YJxLfecIO2z4Vlqn57b8CfaINomWF7ll+C9Pm8tU+N+e0ooiY0fojXqJuplswgKO5GxB+efWa3ofGdn0wxWCXyzc7DUPQk+RNianE0qoz0NTP6wfJzZnHGTg/1hdGlvl25FlpWZ8aWe8OAgcaFjuIVkfSRUYu99zJPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470106; c=relaxed/simple;
	bh=Zq1W1BWvcONtuuxlJ5vNr0NqKNDpYX0nw1TJ1l/HUU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cl2ogzQy/tDxSFLDkbrePJX0mHHLvqrGh5gmxO8l433iMsacp7AmCQexFRq+EZatLq6L9g4PucWu4FFvUThKE2Naw5eJjnfePwvNEiHpmzqwQ6tI0jwd2wqH7m5Twko2z/d0Z+RHgOJYO4p0X2ErVycmsQ9iOpok68w0libP7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=troziScd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="troziScd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C65FC2F03C;
	Tue, 20 Feb 2024 18:01:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zq1W1BWvcONt
	uuxlJ5vNr0NqKNDpYX0nw1TJ1l/HUU8=; b=troziScdBWgRkQcofZewn0ck0+2T
	fZt3Sawx1CT/IKqg8hSw7Djg8C87bMl+W7WJUOKF7OUgy45WvGJ8HZ5dnPW9PGVC
	N+rQ34JOXqbE2ClFQwnsu2m5E6+lZpknA4q4tB5ojuiHXVCsp35dn2wVKBKmJmQh
	r39ygGErmMtFYYw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BFBA22F03B;
	Tue, 20 Feb 2024 18:01:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C7ED2F03A;
	Tue, 20 Feb 2024 18:01:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 2/3] doc: git-clone fix missing placeholder end carret
In-Reply-To: <CAPig+cSFK_sVZn5p3Bw12HOEF4Z99niPGMHp1Dp2w2EUjjZ4zw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 20 Feb 2024 17:39:48 -0500")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<7d85bfe6c5511d3918dd84365249797abe6fa04b.1708468374.git.gitgitgadget@gmail.com>
	<CAPig+cSFK_sVZn5p3Bw12HOEF4Z99niPGMHp1Dp2w2EUjjZ4zw@mail.gmail.com>
Date: Tue, 20 Feb 2024 15:01:39 -0800
Message-ID: <xmqqh6i2loz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 02890EDE-D044-11EE-8BD0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 20, 2024 at 5:33=E2=80=AFPM Jean-No=C3=ABl Avila via GitGit=
Gadget
> <gitgitgadget@gmail.com> wrote:
>> doc: git-clone fix missing placeholder end carret
>
> I believe you meant: s/carret/caret/
>
> In English, I think this symbol is typically called an "angle bracket".

Yes, caret is "^".

>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> @@ -311,7 +311,7 @@ or `--mirror` is given)
>> ---ref-format=3D<ref-format::
>> +--ref-format=3D<ref-format>::

A closing angle bracket is what is missing there.  Thanks for
reading carefully.
