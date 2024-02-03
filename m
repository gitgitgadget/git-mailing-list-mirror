Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C25F54D
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981604; cv=none; b=lCopbk2TVzkePOBeG9jiuZjUZcVcxBHa702YxnkItoZ4NfKXRKvLTt0w71G1aBuwCsIZ2ezVRnFAc6sLt5Kx+ocqp0Y0CTa5r+GWYf9abbaVNhGmhlfIzbf6h7J5jOt7p6rKPvBBoQlHyezMti/V4mbKENPoONqUJqtQFIpkKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981604; c=relaxed/simple;
	bh=IbK3UtvSbR+9BYjPiA3GeoLvQFx9WMRq/EEE9Fh3ovU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CWKX804H8SudUmNcJ+46jlI3A2SJP2RR/99fDHEGcQwA4v9s+ghloZlIprcxtE4YdH1i4qITuWX1Kj2i7KRt+WiaC9OEVdOzo9AgKykDaO0T7faxvhgqucK0vcU80Dkzh77YkR5uvq3W0pFNf02i5WyApIzTFSqEfZfVja/AdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nQY2iekL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nQY2iekL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C77D1D122A;
	Sat,  3 Feb 2024 12:33:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IbK3UtvSbR+9
	BYjPiA3GeoLvQFx9WMRq/EEE9Fh3ovU=; b=nQY2iekLR/HBo9+uB55Qbi4ILD8F
	76NkzfoyNF1MMN5QOQhwfl07YDD8vgRL96nHtK6yxReVtMCE1Wz4SgPbWd7Jgj4t
	Cg+VeDPMceQgG0XlibA8L4mem3KO1LPpdkPxStZQL+f8DmAnhMp/U8k7W0LsEQ46
	4UKSiLs6QV7N7j8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93F541D1229;
	Sat,  3 Feb 2024 12:33:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 063631D1228;
	Sat,  3 Feb 2024 12:33:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: git-users: email list has become spam-drowned
In-Reply-To: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 03 Feb 2024 16:02:49 +0100")
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Date: Sat, 03 Feb 2024 09:33:19 -0800
Message-ID: <xmqqbk8xsba8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 53304BE6-C2BA-11EE-9058-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Hello
>
> I know that this list has got nothing to do with git-scm (per se). But =
I
> was recommended by Dscho to raise the issue here.[1]
>
> Maybe someone who happens to be affiliated with git-users happens to
> read this.
>
> =E2=80=A0 1: from https://github.com/git/git-scm.com/issues/1828
>
> =E2=80=94
>
> According to https://git-scm.com/community
>
>> There is also [Git user mailing
>> list](https://groups.google.com/forum/?fromgroups#!forum/git-users) on
>> Google Groups which is a nice place for beginners to ask about
>> anything.
>
> I am not allowed to access it. Just as well because this is apparently
> what it looks like:
> https://www.mail-archive.com/git-users@googlegroups.com/
>
> The last legitimate thread (except for an email saying =E2=80=9Cbye, th=
is list
> is too spammy=E2=80=9D) was 2023-12-29.

I am not a member of that list so I cannot do this, but somebody who
is a member should be able to visit

    https://groups.google.com/g/git-users/about

to find out who the owners are and how many members there are.  I
expect the UI redacts the e-mail addresses of them, but there should
be a "Contact owners and managers" link, from which you can contact
them, to let them know about the situation.

What they could do after getting notified is not clear to me,
though.  Volunteer themselves, or gather volunteer groups among the
members to moderate the traffic, if they want to run it in a useful
form, in ongoing basis might be too much, but at least they can flip
the "Anyone on the web can join group" bit a bit tighter, perhaps,
and then eject spammy group members as a one-time clean-up?


