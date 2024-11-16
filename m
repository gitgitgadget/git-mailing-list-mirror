Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B747F
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769904; cv=none; b=ZjBcPE5IANxGjjRV2zLSelOK4ysrgmgSkAFWqV0PXwYLIinPMv3HJZzjKnWXjryInZjzQE7NqA6NdtRaZ91srfQPNC0TuBpu/H0O9Bbyw+4HZLt6W8L4pj97l0aVoc/JMcrbHNUY3uwYx259ScMylad7n5/VPoY49PYKunwfpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769904; c=relaxed/simple;
	bh=d7YGoKB5yBVjJw7sYXoRGbQDDrhzk6ElcYcP1bktE8w=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=IW9RFAVuHMjTd3J3pAuwtNrzhMdFRTksDabgpp5xL/4CFFjdsKJC4jRR8pbBssCalNOfWsPzCWmpw0eHRfTCVo5UZCP3BqbG8QtMy4KEtCnNA2UaBYvLbLkVr2l0j/ABsrQm3uUutViP+LXA8993LnsofoJeJ/oLNgwfCbjBlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Zdi0YYHB; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Zdi0YYHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=86V3lIlcftMfh+kfZfm4Kw98RTfrLEAkIAh+WafTHOQ=;
 b=Zdi0YYHBHRWrUsbjAOi1V+T8vgc45sY8fqBzWFaxM9eLkJc/4h7ZqOMpH3O1uGBFaRHElmRVmAMp
   Tyb0pXM+sqYMWjPPHM0IMMC4V2l3zRO9PQblbLS4SPH44ydxH8ESjQu8D+oNBdr/oQJYbV4Q8hdM
   Hsi+5bOGBLj3VnbuRsitngTZkaZ/1qsi12IDGpgtyfqYJdBrgYt/S0hOEdyJk9KnRIfpUSFp4vo9
   eDSPQPS6cTpZX1n//8Ez2X+weZoHS8nB0cnLXUp1+ABbcpwCuDMRp122Cc9bRGvvgAtiVBdFmvFS
   5c2PQxT86jqvR8OEzvFFGVl9eWt/91Dkuj2Qaw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN1005K6U7H1YB0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 16 Nov 2024 15:11:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 16 Nov 2024 16:11:17 +0100
Message-id: <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
Subject: Re: log --format existence of notes?
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
 <xmqqsersyrch.fsf@gitster.g>
In-reply-to: <xmqqsersyrch.fsf@gitster.g>
Reporting-Meta:
 AAEP0L6eSrCUZujIdQ6t16L/Lmy0N5F7kfdEbP+uhvgeeXJc0kCjB85khkGFQ7em
 OWaBXsuasz3MI7EZY4xkbMKi/0Yrkl11HLitZnd3CpqWvlx0pfiKcy7Rz1dCLWry
 McAuW0b58tccQ0bPE2+m/ETFwDWHUDx0HqSr7IiMyPcUHNONAWhd7UwFfddDuV1R
 0CAf4hgcdth2Epka19BBt7TVq6cUUri+YlQl1vH8DgILDGGrv5uGrWF1dFrwWYWq
 zVdQN45HYIzNmXp3V/HwQEeYAOf597MPW/5BvZDmEKElY09N6+YNnevl5ECP1ICR
 6/EYZs3/h6iCbLHpyf0qVHjsJFPGFaXEmg8KI5SDp8PBxMjCcdj10Ul5abpeVx8L
 q02JD+O1+OUNDj4ABtv259NePru7ereRKJAdu0OgA326hunzSw3rwwrZibjoGVln
 gd/NWVDwa2CnduSurr8miKbXbCo7PF5sjALOyU5ZS27Czk6NRPbldYNi


On Sat Nov 16, 2024 at 01:06, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> based on the man pages it doesn't seem possible, but maybe I'm missing s=
omething.
>>
>> I would like to put together a "log --format=3D" which is similar to --o=
neline,
>> but where if there's a note for the commit it's marked with e.g. a noteb=
ook
>> symbol. There's %N, but that prints the entire note, so it doesn't work =
well
>> with one commit per line.
>
> I do not think it is doable.  Unlike the format language in the
> for-each-ref/branch --list family of commands, the pretty-format
> language in the log family of commands lack more involved
> conditional formatting features.
>
> Unifying these two formatting languages to port features from one to
> the other would be needed, I guess. =20

Is this already on the roadmap with a plan on how to do it? It sounds like
switching log format to the same formatting as the other commands would mak=
e
life easier in the long run.

> If we had a note support in the
> latter,  something like
>
> $ git branch -l --format=3D'%(subject)%(if)%(note:amlog)%(then)=F0=9F=93=
=93%(end)'
>
> may have worked.

Conditional formatting definitely would sound useful for logs as well :)

On the other hand: would a quick win in analogy to "%G?" be considered? A "=
%N?"
that either outputs a "N" for note and a "-" for no note? Or something like
that. A bit ugly, but gets the job done.

Thanks,
Bence
