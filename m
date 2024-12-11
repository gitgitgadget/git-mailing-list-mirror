Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAB1EC4C4
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954279; cv=none; b=BVGWyXF8+mbFrocwfmxz06p2GO5UWfyJMTInJBoRQGxIONrwjtvadhNjYcsu9dTlnnzaiFjR0xh1S9U+O5qf9BUtclEUAoY3LzQ6ii2XBUsS/G/D292o6bdFpExrONgs+vcxM56gRS02mnm3wz2PP6m3q+X9qPeiakQ5vyAP678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954279; c=relaxed/simple;
	bh=c+OlkPFTv6WNmKf0sVMVdm+o269w6JsVqmH+xgF84oI=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=LrOqRiycM3N1YL2gE6IjnzD8qPMT0j7bkcTtfpBxqtg8pjKkrKpBRTKhjhMBG81vZUZbMlPtDFyTmlt3g76nFtSHBvDyIqvVahlOTR+3Rt7GI0rchLimjCAWp6IkQTIpel+EmVyLg+LJ0neB35iuAUeIORYX/y5dNHixPif5/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=p7Zzq7aj; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="p7Zzq7aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=clo44DDggZLhRnGC/Qqpy8iiAylLabTqcDtfa+dINNA=;
 b=p7Zzq7aj5+UNOWobCXCiVtIA9IqkI/BU6IGUdGj4Qt71e50/nJ4bzHefAJZ+bWviape7fYWdKHRA
   LkBc/gKJkYavu0JPfyU5O3mZ1Rgptzwc90Llj8T1n5ij9m981TFW0TlklIcQpNCM9SQma0zofwGF
   BDZvBCd4GahJzV3ddbQik7q3AVz+AkO21jnSa/rvXIUnzPRWKucmSG04KRFQmDe3K+OFxYMc/L1N
   58GBQvlb/+VZn2jMXNtIghYBi34/FsITn/7/iqL/KGq8aC+ycz9C7PnOhKdivMx3p6vmSU5EFHrB
   3ASCimsqLDQl81f83hR1DvXnho2g6w1SIxc2JA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOC00E4WNOB4290@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Dec 2024 21:57:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 22:57:22 +0100
Message-id: <D697HA5ZDN2K.1I643FREX8WKC@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: branch description as a note?
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <xmqq4j3ai4it.fsf@gitster.g>
In-reply-to: <xmqq4j3ai4it.fsf@gitster.g>
Reporting-Meta:
 AAHTorN5Q9PFyqj6wSgN3tdighfE6wLCguebq3ii8+rHHRPON74VFWP/5OpLLJa7
 neVM6jQwhMaRxn0itax+3kKRVCRzN9mfpqA/lgGqh0AmctK79djeyHFkcjpp0E+p
 NjAjE5ItbNOncGK5lbOluLTCKtQqTJ3kh5giyAmTtMMhXSUbVXqxipAwEDSlSXBx
 bJoTB1pkwYy1wBDQzLX9rExJph17GmfulwcSVJhyS6Z1Rfg3q0dYKvR++mI+pfPA
 VCDbF+Gx5LFt3uXiBGix8eCGEM6sxQp/z6sTbfshMf0E4nF4b1QbPYcvEGjfpmhe
 FncZwtTyQV3L8l5M3Qb+Aor0odm4GQO6Y5TsmxpWBP13ffuodMmH9QHrlOUtGVbQ
 OI6cmOD3JC9+gGCvZfwdVkaXWOacIdmjPQx99KEYP6ZHjkhkxG2LcddSzVmW18Mt
 20YXqsd7ASrZxfBPLuCy74LAljklB8FQmuFmI2Y8LmHg1tby7Mf0oVM=


On Wed Dec 11, 2024 at 17:11, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> so I've been wondering about branch descriptions being just a local
>> configuration. The only use-case I know for them is generating cover let=
ters
>> and request-pull, although I could imagine maybe the maintainer uses bra=
nch
>> descriptions for storing the - well - branch descriptions for the "What'=
s
>> cooking" emails and the merge commit messages.=20
>
> FWIW, that is not how I maintain "What's cooking".  Rather, the next
> issue os "What's cooking" is pretty much edited manually, plus a
> tool that notices when an existing topic advances in order to insert
> these "(merged to 'next' on such and such day)" lines and turn '-'
> bullets into '+', and move topics from other sections to 'graduated'
> section.  Especially when writing comments on a topic, being able to
> read about other topics (which may be related) and the list of titles
> helps a lot.
>
> There may be folks who find branch descriptions a useful way to keep
> a quick reminder about the branch.  I was also hoping it may be like
> so, but I seem to have failed to exploit it as a useful component in
> my workflow.
>
>> Now my problem with the description being a local configuration, is that
>> I often work on patches on two different computers. I can easily share m=
y patch
>> notes with myself, but not the branch description. If these could be pus=
hed and
>> fetched like a note, I think that would open up some other nice possibil=
ities
>> as well, like having a standard place for MR/PR messages for forges, sha=
ring
>> proposed merge commit messages, maybe other things.
>
> If this is about draft work, I would use an empty commit at the tip
> of the branch.

No, this is about storing some meta-info about a branch, somewhat similarly=
 how
you can store meta-info about a commit in a note.

>
>> For my personal issue of sharing branch descriptions with myself, I coul=
d
>> probably just make up a convention for myself, say using refs/notes/bran=
ches,
>> but it would be nice to have this built in, instead of the local config =
branch
>> description.
>>
>> From usage perspective I could imagine a new `--branch` flag for notes, =
which
>> would tell `git notes` to operate on notes attached to branches instead =
of
>> specific commits, probably stored under refs/notes/branches by default. =
Maybe
>> add an `--edit-branch-note` to `git branch`. And of course have the opti=
on to
>> use this note instead of the description configuration wherever it makes=
 sense.
>>
>> What do you think?
>
> The notes tree is a hashmap that uses object names as the key.  The
> point of a branch is that it can grow by accumulating new commits on
> it, or its commits rewritten with "rebase -i", and there are branches
> with more than one commit.  So to what commit on the branch would you
> hang such a note on?

Not to a commit, but to a branch. I mean I know a branch is just a referenc=
e to
a specific commit, but in this case the mapping would be from the branch's
_name_ to the note object.


--=20
bence.ferdinandy.com

