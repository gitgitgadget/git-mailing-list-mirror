Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AD156665
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068730; cv=none; b=S2b3aXbKcNcKze76gEcZQxd02v64w1fsMXkFLdkTQBcSJW1IcwBao5QLBbhbbOk/fGyXKVlRaqQHvQU4c0Ti/DyWlMGL/nSIk7axIbAoXc1u+oYbppGku+3gFEJnwL7ZCOHz2UEOgHyCK83qKvoq7azELpAciFibkoRF9W239+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068730; c=relaxed/simple;
	bh=MkUGHeo1wwU6MW29LfsE5T4Xd7FrPtyl+w/fKi17ao4=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=XI24WVmidypfoZuKMi8OjVaugnMnbHRU0CrYq1LHMzzRK5dbu4qY/MsHWJXxQgyOOCiJFQVxvMc+R9eI+d3Gvm0z7yb+Xip+s7rFPrSZKJvS0P4Yq2JKLVEBB0h3O2M+Y8k7zANQo+TCwaZmNL+DbXuwrdnvNs1w93IYx1dMNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=iuGn91Nb; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="iuGn91Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=BRyH7AiTr/lvkPeRUS6iERbFajtHX4lMDpcPTPUBD50=;
 b=iuGn91NbRxQjo58O9fT0caON/v0lTWmRLlTm0nnews579OERl1yabsD6YL1yp2TLolkF7qoJnzqQ
   tu5zhj7/PZ1VtA039cJQ+W4rN9gpLI+LdT/kYAx43YL5La0iXpTbC01uU0s2uVoNg2SVP8NAPQBm
   ZPgXvWjn+Iobxo3UlmUdyQ42qlJTOK8KprN0zM3n/6N49GRw8YaAR0cnrp/qw9Qv+UyLe3CuwfED
   Ikp/QFzazl2zBt0QaprE1D2OXWR0mAKjW3O9PAvG4KJRnpfMMRUYEQMuDZgHmuCx6NJb0mtF0BBB
   aQbw2H0JjGmMgp8ZufjC+yQF+lOzU5cOra2EXg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLF00C3ZXYTFA00@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 16 Oct 2024 08:52:05 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 10:51:45 +0200
Message-id: <D4X3P9IU599M.1ENMB903CT197@ferdinandy.com>
To: <kristofferhaugsbakk@fastmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH 0/6] doc: update-ref: amend old material and discuss symrefs
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 <phillip.wood@dunelm.org.uk>, <gitster@pobox.com>, <karthik.188@gmail.com>
References:
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
In-reply-to: <cover.1729017728.git.code@khaugsbakk.name>
Reporting-Meta:
 AAFgNrGQOcophDT9Kxs9Wg2VDXRq/wEUtD/lXQjqxP2G82fz/QdU8yq5wI4VW3lA
 V+lUCTrj6a8OwnSFw1qv7KWuGg+9aEeoKz4r0HkEq4ulBFZ8V+Y06gJUaonzRtF7
 bkLl9CF2jt+z0gnhnyA+QY6jJTf6MEQ9Sv0ku3QRlpabS2FE8Ip7SBkwWhU3oYFy
 dekhLh4INMzQEKJWAErZ60Z0tHXIHgBiHUGfZhR3dDiZNE2pS9O04yj/BrSS5KO9
 7xkOx02OWdErgcuQ0/W+bZCyReBRsbYm+nkEkOUtJBsPJNeaLOYaGs0vPqxuY6fG
 82qdudWpOKrOxSGxzwKvrz47oZYneKfZZ4EqWGlSl20P4v4NO5dRfgJJ08Y49Koo
 pLmbh5npaDcYxYajv8zfwVVoEqmG36uVwCeG/W6wU3+2umc4EeVaGuI8TfRfkY7Y
 H2lQfE7t4YzmOs3/LU4xFG/SPtIfSm3a4mT5dbQ2pOHHVPG4V/92l/jh


On Tue Oct 15, 2024 at 21:03,  <kristofferhaugsbakk@fastmail.com> wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> (See the previous email for the context)
>
> This series removes or moves some old material in the update-ref doc and
> improves the discussion of symrefs, opting for a high-level description
> with some redundancy (see patch 5/6) in order to avoid a reported
> mistake/confusion.
>
> The end goal (after all patches are applied):
>
> =E2=80=A2 First paragraph (in Description) describes the first form
> =E2=80=A2 Second paragraph the second form
> =E2=80=A2 Third paragraph mentions symrefs and explains why `--stdin` sup=
ports
>   them
> =E2=80=A2 A new section whither the symlink (FS) vs. symrefs (`ref: ` fil=
es=E2=80=A6 or
>   strings nowadays with the different formats that refs can have?)
>   discussion is moved
> =E2=80=A2 Link update-ref to symbolic-ref and vice versa

Thanks, it seems much more clear to me this way!

Reviewed-by: Bence Ferdinandy <bence@ferdinandy.com>

