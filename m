Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6619E7D0
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565913; cv=none; b=atQ7LOHAocfC54+GPRhnmt2YJqj2oHTKFKE6NPNEuKwWioTmvyoUAFWmO6n+k+PkIE75C+HlmIGw8fYlJiadFGdX8ocloTd+OlqvSe7SRXW6BwQf2+RuTnzxccTQka3DZLF47j7UgEUX9JqsFjXTslN1Jrw2rXbPN+QufsHTj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565913; c=relaxed/simple;
	bh=8q41b59ej8I15IEJD8vo7uTt0wL5dVqhsVmlMUI1wpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrAisYu+RGrmD8Tug4Fw8WVYrDDH55FcjmrW1ycDNsytYJ8ZB7un4oTvBaa1w7b7iMHSzFiu/SonFQYVqPMBYpaB79bHPwMJEnAZbPXVURFJtWkUWuKuKinrAu2TKcowzlZ3z9vvEQdviIwcEXfUbRrW9jIYp0pIU+wiZY39T6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=hqN5yGQq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="hqN5yGQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725565900; x=1726170700; i=tboegi@web.de;
	bh=8q41b59ej8I15IEJD8vo7uTt0wL5dVqhsVmlMUI1wpU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hqN5yGQqYpIFCKyxsn8OwTQVgj4r2ysPAmWi1dOh6c2LVKeokYUYuX4ZI9t/Erj/
	 guNUByd5hfBNIoksDLcz/i7abmUSq7AP9nax06oOyrHIwgaDN56Du7wi/RTHQBIij
	 mUMkx4lALFEmW8fXjRCTNd3wHv4VBaS7/RMaVYi8/W8dip04EaPEHRb5idk+7WlSk
	 Tlau4o/DS68jXGvreJV3fb5hrCUAt2JOKtTKFjnFjUH1i0gD9HKPV4qQU2Wt1hitm
	 k6raSLWQbQUaF7xlkj07aOYadGnPrKa+LTJDUqXDMgYDH2NubZaYtlbHbejHwg0rW
	 fQe2jSOcLnvSfSVBDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HG8-1sfhsS1ZdY-00ASTN; Thu, 05
 Sep 2024 21:51:40 +0200
Date: Thu, 5 Sep 2024 21:51:39 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Roman Sandu <r.sandu@gaijin.team>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <20240905195139.GA9644@tb-raspi4>
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
 <xmqq1q26t1pa.fsf@gitster.g>
 <20240903155818.GA9437@tb-raspi4>
 <8a8a7f75-6a2f-4fd9-b3cf-df61129a355a@gaijin.team>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8a7f75-6a2f-4fd9-b3cf-df61129a355a@gaijin.team>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:s/wK6VO6md4R1VlKj/q4Qb6PwGgSWOLTqKnUd30JcY3maBRCGAm
 pWXpbRVb9oYmSK9E4SAnaS/1RmM6eovEiE/3aFxXYiTGGdjdD8yNmZtY1deKYUdc0jtynFQ
 8diEOaou+clFyf8FjGwO9Yblbc6u1vhSiVgx6luATGkSS/1pcHt7B3eND/s6NFjFahRtHM4
 tEgGCNxOdrkejFk5bHqeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1YC4srb5rAQ=;DVq5td/cJpA7qcpwuAjhLFtUjUU
 pkSmI1lxr5xqrWdMBG0P0jkq3kotMQyIx5ua+KxHpzKEvbwIvP50VcMrlx6uAur3PWwMSWuX6
 rVPatv67DmkqlKIgwJRwI0iZdSKqCkl5nreprYGiQUzz1c/R0aopPBkBvEIul+nokaQQqMiXp
 EICBoCq/mF5l7lS+GyXSVcvPtda0Ep0mRhJkz1kxb3xffdW06luHRQlMuNSu3ps/LzZ6Rx00a
 aSU2fiNoWnADm/0jZbSU6/Blg6GQqzGGfiATnZpppceuzSSRmOeqkXrXCpU7OShoLEhG/4qAs
 WfRniCfjFFqknLghOwwr07Lb2o5wTHk+0z2s3a1vissf3fadsJYUEWNGHmsGuNj0VYYb7sfDF
 7dlxezqok17brRe6BN4mbFVaUe9gQhEz0XypoVURCQLjEpUqZ4Cyprg4127Sg+hYrdBQ3cyi3
 t9yyWeT+2xGcas6oddHVoMQ0v5v7orSAsg6jWJy+4ySOnmgwyO7OdEl4MOG65FKN0gWVc2njZ
 C+k5CobOzz8lyLBfy91mjOR94lIiaZ7oNeDpnouiKr+xzThpG+U01ZzcWCX1oY5WUuRTbSWIQ
 WABH8XmLDxBalrNdplQ/OAYeHEG/wFbVUsed4QbD0E1Q+GWtlWxgGQfi1ViPkQaJzteyUsdzP
 2L5mI4IMRCAG+p5Tuv1p+rIKOW545nDFw2oswV4bmuWQeYegQvEqXJA8HOtK/8bUnBOhk1hD6
 Ay6uTMwfDweKUQ+gPtVTxkCZhdCkpTsxMsf0MrC1feWIBfwWpeFIa87mjcvZH9ydYFS/TpUfc
 UKOv+xiZ7ni7716AAVtV//gWjKjE4CNXoxCXbu01kIRpc=
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 08:30:16PM +0300, Roman Sandu wrote:

Side note: Please avoid top-posting here in this list

> .gitattributes is this
> https://github.com/GaijinEntertainment/DagorEngine/blob/main/.gitattribu=
tes
> `core.autocrlf` is unset.

That is according to the book, good.

>
> core.filemode is false.
>
> `git ls-files --debug` is extremely useful and I am a tiny bit salty tha=
t no
> one suggested it before I spent time learning how to parse the index fil=
e in
> C =3D)

No well, I read this as "thanks for the hint"

> But alas, nothing new, see my previous messages (hopefully they are visi=
ble
> to you, I am kind of new to mailing lists).

Yes, everything is here.
>
> `git ls-files --eol` says that worktree uses crlf (which is expected, I
> checked out the repo under windows), while the index uses lf. Can that b=
e
> the reason for Linux git thinking that the index is always out of date?
> Various dev tools work perfectly fine with crlf'd files on Linux.

Yes, that is not the problem for any performance issues.


I did set up a test, kind of.
Exporting a git repo from a Linux NAS to a MacOs laptop, using Samba,
and WLAN.
A simple `git status` takes 4 seconds for 1800 files.
The thing is that Git needs to lstat() each and every file, to find
out if it has been changed.
And if that lstat() call is slow, then `git status` will be slow.

I don't know, if the fs monitor works for your setup ?

https://git-scm.com/docs/git-fsmonitor--daemon

[snip]
