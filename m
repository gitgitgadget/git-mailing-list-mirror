Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B31A0726
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955448; cv=none; b=A4cpa2BRbusptWTMnY06+ZLqxAApr7ORVZ6/N8PMg5VtwM8N290HsejqHUZ5ewzRgptab2CY+dZUGO15YvHgoHPSqvfhdteCXY1ldiNMM4MwvR0oeh9hDHZa2UfgWhBdw10jiXgz+Orn7NZ9TKBkVFZcpMoWbStkfPsv2fDwcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955448; c=relaxed/simple;
	bh=M4mOXquHCwT8IvdgGBw7YIUf6WqgRVJ/7D/P+TgLk34=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=t3njAqaHL1Qm3K96Ov0vWQay6xqu0tsomgU1ATApKPXx8CDY0JSIfHx5NSAFpkYQW/J4h1MFIIX1boo1oDlnfHSXqMLBTMB49inydYlJBxhVcKoOrIrP6cqk5fNZqmaD5ZEW/9D/QWy11Fdy9uqR5b83Q8Mvi0moSy3d8gaAZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=FCOvBMD6; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="FCOvBMD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=M4mOXquHCwT8IvdgGBw7YIUf6WqgRVJ/7D/P+TgLk34=;
 b=FCOvBMD6R5GoJ6XkJW+ivE5aoNOFQJj1Xsc8YyZLbufa7S65I5NV4/HgzUS7Z8r4imIaIH7QC/XU
   7GuZaTWtVmMdjLW/Wo+Qvr4XPixmpm3tYkBaE5cN7baoqow0zYXB3F5GuuGn51Eow7m/34hz+20d
   2QJ7b3vWDd+TrviQ5fMT1PctNG2R6G+Osw95w3UJ/KvnzRjtMIBk/R2JVjnB0JDZgQ1hagyUNJ3x
   aoIVVUhzfE1fVZmB7tUfxDJ1/jqK9rCJqUdHeCuy/4Fko5E+3iuoYcT68mobcqGsVPHWNaASCwdI
   dUbkfsCpiYjlojRm0c2bU9nYhCzRfhc+OfD9sA==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOC0041QOCI9X40@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Dec 2024 22:12:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 23:11:30 +0100
Message-id: <D697S3ZY8LBW.32P9EXVR76WBQ@ferdinandy.com>
Subject: Re: branch description as a note?
Cc: <git@vger.kernel.org>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
 "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <xmqq4j3ai4it.fsf@gitster.g>
 <sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
In-reply-to: <sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
Reporting-Meta:
 AAHTorN5Q9PFyqj6wSgN3tdighfE6wLCguebq3ii8+rHHRPON74VFWP/5OpLLJa7
 neVM6jQwhMaRxn0itayX4UKRVCRzN9mfpqAZ4I6KqUFBhYLqj3+miQzgfirutzuq
 l/SX/DkXnuzhlqrGS0KuFZLLutt619PLVLNfwdV8WS66YhMaLsSfoY54LtMcPANA
 3Qjgro6q/M0+t07BNk5DCHctcjvg+XefvAfflAW3rFPLpymuyt7Pp14kQO30qavE
 e53WSCmy0/JeeVThAL8zF36TK5PAH6Z1d7nYLuW158eKtlb4X52pHaQBP+VCPgSs
 JRMuNgQ7SgCWvnQaocX9yI1brY4ywt5q0bffD5UdBDFYxhREfNOVwst6ppY+A9fx
 +Sl4Fp+Q23H8sKCXCiP5xIT5uZEbe5G4dmAIZHdcqmtMygblVujDiNKg+GVMOiZy
 bl+GVA+GOW6xGcIO1QafI4eRA/GiYj81ORcQ4aPMNgGF2SDa0PyPoZU=


On Wed Dec 11, 2024 at 18:37, Konstantin Ryabitsev <konstantin@linuxfoundat=
ion.org> wrote:
> On Thu, Dec 12, 2024 at 01:11:06AM +0900, Junio C Hamano wrote:
>> > Now my problem with the description being a local configuration, is th=
at
>> > I often work on patches on two different computers. I can easily share=
 my patch
>> > notes with myself, but not the branch description. If these could be p=
ushed and
>> > fetched like a note, I think that would open up some other nice possib=
ilities
>> > as well, like having a standard place for MR/PR messages for forges, s=
haring
>> > proposed merge commit messages, maybe other things.
>>=20
>> If this is about draft work, I would use an empty commit at the tip
>> of the branch.
>
> I think this was discussed a while back:
> https://lore.kernel.org/git/xmqqilnr1hff.fsf@gitster.g/
>
> I think it boiled down to having a merge commit at the tip that would ind=
icate
> the base-commit of the WIP range. I still think it's an awesome idea if
> something like this was natively supported by git tools.
>
> -K

I read through the thread and it seems to me that in essence a special empt=
y
commit was suggested to be used to a similar effect. I think instead of usi=
ng
a "magic" commit directly in the DAG, it would be much cleaner to store thi=
s
separately in a special "branch note". "format-patch" and "am" could be tau=
ght
to handle it automatically. I do really like the idea of having a special
syntax in the note to that would delineate the branch description proper (w=
hich
could go into a merge commit) from respin versioning of a series.

It could also serve as a nice and built-in way of sharing information about
more permanent branches, e.g. the git project could publish via this specia=
l
branch note some of the info about next and seen, that is now somewhere in =
the
documentation. Forges could easily display it and it might also make it eas=
ier
to discover how a repository is structured after cloning.
