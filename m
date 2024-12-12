Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C4211470
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001068; cv=none; b=H7Cl0Ya0owSSmf2aND4xGYy/2ejlh43Z82v1FMRfcECC5Hl7ewMB5DLOCnOkN0GSKwnuYU7RZ2UHWpsIyOTm90iejj73F45ACn0oK+xGkaF+jvz/oG2zZn2VG9KxK8pux5fdQLD+L/4a70F4Vx4fcRIoZtJFoLoBUexcCcUNZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001068; c=relaxed/simple;
	bh=5ApfcxBDS5XgRhCRNJsZqB5lojZMVTTXqUlAKf+pMyw=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=MXax9dJ7laxO7Me9lIQall4XsSDTFp9SQFtOc/S4ekyrrUs+G06mnWvQ1YbF8B4CHYg2/VifMqt3J+OC9AZbSZWJQAqUOEq1dweKa4sYZKzKwGqG2xONcsF2oijTH4wFq5TpGu7xMHL5brnuudkHy6sjhaz3W0EKzdUSbiBRTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Xfi4SR7s; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Xfi4SR7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Vw1HRqo6YHxLxseEV5r/FlASAyMW/PV8LyxTB7VQ3Fo=;
 b=Xfi4SR7s1flsXGs51iX5X2VylG1EEgLSTVCDni+e1TloGwxr+UeHobLTWh/jXKIq3c5WA+ST0bvl
   Q1x2byw5BZpVFnwt+oL3v3VEXU9DxmMKgGRv9//YTPPAk4vgd1EgXnpKVsH8mOL30EIi7a8f66DH
   mJVrJA5XC6bl46UCsIU54ajJ+1ufcbRm6MTYdBhsNDVGT9Jr6Vb+f30XHYjcfW2eBefhA3Z6/r0Q
   UPlAtGfeIBIpKy50mUIOj48AI2XK7ummAlrD1a8BSJCcrReJn1bbHKTfPqsZ4Tva2ICxg4/yv7t9
   pmCf5Zr0nWT8H+8fkDrzL5WwxnGelNgvJuJzHw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOD004L2NS4MO80@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 12 Dec 2024 10:57:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 12 Dec 2024 11:57:20 +0100
Message-id: <D69O2H3DJIH9.3L52AI25I3U3R@ferdinandy.com>
Subject: Re: branch description as a note?
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Justin Tobler" <jltobler@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
 <xmqqzfl1fz17.fsf@gitster.g>
In-reply-to: <xmqqzfl1fz17.fsf@gitster.g>
Reporting-Meta:
 AAGBH7D3OKrOUety+WpWJDbxNWIXPsDOrNBBEip9Q5wvbsCmBBTdhEHgJ01XxX+O
 6Ze1WOq67TDso7zZ05RkqnTFyqmI8A0jawMOD+nLt66B7V8c74zP5NVW2M1duEWi
 e0SjnLIl5toZjQCup/9DNJht0di3G0p/FRkxJF8bgWbR/sQ5Ec6zmZAgkMfLCYtG
 h02clzTytMvfXo8p/EWh02IaWdYz0U7Nwz9vBxuFAx5OtJ1zwvib9pCX7pqA0lCy
 zJgKec0xmD2uB0h86bD3LCBva0OF4diP+ffCdp28b5wZa6ah/0xPU6BHYyhF8ga0
 rFLr7l5y3Ln99hd0/NpFCg82kiy9XfxcYdcUQhwryXxOF8BQkmcwurqpP5X7Ubbw
 kP29NysXGNWKfGN2NKmzssv4TZoBo3PCXx+shfggqwviPIJyC5bewJ9587uI2rjD
 8SYnuQ/VzG/B4OCBOZdIiKJKXqHHUsrD2wewb+gr1EhPtUOS6+yRM2w=


On Thu Dec 12, 2024 at 02:52, Junio C Hamano <gitster@pobox.com> wrote:
> Justin Tobler <jltobler@gmail.com> writes:
>
>> One problem I see with notes is they all live in a single notes tree and
>> are associated with individual commits. Therefore, I'm not quite sure
>> how a specific note could be correlated with a branch without having a
>> separate notes tree for each branch. Maybe the notes mechanism could be
>> extended to also support storing notes associated directly with a
>> reference in its tree? That might allow for notes to follow a reference
>> as it gets updated.
>
> The "in a single notes tree" part is easily surmountable by having
> more than one (see "git notes --ref=3D..." option) and that indeed is
> how I maintain the mapping from each commit to the message-ID the
> commit comes from.
>
> But you are absolutely correct to point out that notes are attached
> to individual commits, and it becomes unwieldy once you start to
> have more than one commit on the branch.  You can attempt to work it
> around by enforcing a convention, like "the commit at the tip of the
> branch has its descriptions", but then "git commit" that advances
> the branch by one commit needs to move the notes, "git reset" to
> rewind and "git branch" to repoint would need to transplant, but
> then there needs ways to differenciate a forking (you are creating a
> new branch from the tip of an existing branch, you do not want to
> copy the old branch's description) and repointing.  It easily lead
> to UI nightmare.
>
> Abusing notes tree by storing branch name in a blob and taking the
> blob object name as the key in a notes tree will absolutely not
> work.  The names of branches are ephemeral and local (what I call
> the ps/build branch may be called junio/ps/build by Patrick, and
> both names are valid in the scope around these names), so using such
> a local name as a key would make it even harder to share such notes
> tree (not that "git notes merge" is a great end user experience to
> begin with).

That's a fair point, that branch names are local. But if the information is
being sent over email (in a coverletter), that doesn't matter too much
(although should somebody attempt to "apply a cover letter" to a local bran=
ch
that already has completely different description applied that might cause
issues, i.e. I send the email from local development branch, but the receiv=
ing
end applies it directly on master which had a description already). During
push/pull though, the user already has a mapping between local and remote
branches, so that could be used to overcome the difference between local an=
d
remote branch names. Though I'm probably glossing over other complications.

