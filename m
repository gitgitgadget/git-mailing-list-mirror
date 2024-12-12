Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C0210F6A
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000520; cv=none; b=NWVTXr8pjUBplaUxaeLB5N2SYaTx+/xVdjqtddZU+xnTocDu6wZYsqg9nUg54BTq7GYUa/vEd8xPupCX8xxR4+f4R608nF+3z4vCfKNaMQdcwr/dvDECQSfQTxLTSrrRCrclEkqYtchtdqXcryNqqcTRO41PQgITrz3OVoOQHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000520; c=relaxed/simple;
	bh=c2FgWDZPuBBzrAOnhZWenWfhh/Yvc2PDKuGHGXXJIV0=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=ICBYdyVj29EzZxHhUvMz+vSbBGAgviDcbepUHSOB9Xm1yN4IAr58Xds0JVnOJLnYOiB0gIbSWKGLQpCeMrH+OI1CVHtFb09KLy/SsBn6Qr0CjRcfQCuCCoVN8rz+2Vdoh/T26ax4zl0sBtg0MbUq2eT5+5EkYbByNiJy2EiBZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=AhDObUjf; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="AhDObUjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=71+D2VTenz2R0ohdTrViAZVvD9x05riB7vutCC9sbCo=;
 b=AhDObUjfB1LweT0TkT/kBLkO6ME/klP19G33YWr2UHaB4UNyFREb5yRVPp7vOl00QVmgq0QF43I5
   NExvBPZaUCUr6le2grxHqO804rUeZC99ugCo7TAKkFqm39jkpBS9APtUI4fcUZds0GLhEZr3SsGR
   DONC2ubPi1otBsrJv0jvbd4ZaACtSDVyD2tHxzv1+bw4c7EzhY25EsrFtVIvQ+Khw/RYJHu56HSs
   9dNCYaHf1IqrzLDytp/uAFPhhS5tZJcqffEQxzQkDfkDPW1j1qdadlWEW2g7WFQxS23RNjRU2kQ1
   A37VgTuJqylWOoPhg+MTBRLPT9CL+pU7ogLw/g==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOD000PDNCUI680@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 12 Dec 2024 10:48:30 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 12 Dec 2024 11:48:10 +0100
Message-id: <D69NVGIBKYO2.R5Q7TP69X6C8@ferdinandy.com>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: branch description as a note?
Cc: <git@vger.kernel.org>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <xmqq4j3ai4it.fsf@gitster.g> <D697HA5ZDN2K.1I643FREX8WKC@ferdinandy.com>
 <xmqqseqthg0h.fsf@gitster.g>
In-reply-to: <xmqqseqthg0h.fsf@gitster.g>
Reporting-Meta:
 AAFP/5NSfvM/5Iugmi4KXUkIm5c+tCrgFGuOU+LApG6e2taZ0bNwTBlGjV4Z4BV8
 PjpANaU2Dwf7PBZaQjc5FBacAmK7+wtq4sXWdPx6o2oQmoYYPz74YfoD5WVee1G+
 83DLWF02L1uq7YbwAgv3AFLFZhSN/B7y/3cyBKWGYl+wP61OqOQtboHYnGtfmHg9
 ntBGf8OoDaRtFnrzvACYGAuyI3X/ASZQp5bvpBNU6Ik6OfUT7Io2L24J8uKjDqyS
 cRPp0j767ce9MbfCL2RWZeFf9aTcFD9Gbt/3f5ePvL8tfGUp2qC5kPhY9lQOSufC
 GE8qWzEcMxiDCQIxjU7KSuR85pBXz29aOkmwBaIjiajnkR6wn4uiH29IY6RetMLg
 B7Arvg464OeJJ8y2+1gdm/V1fpPFoUezHg+dsXNTaJ6n/EipkAEPs9oynMwAprBD
 J4kJur482h4WRuUhGvKPxotPyHbctvc9DvfSCukJwipIxO1aKneV/8Q=


On Thu Dec 12, 2024 at 02:00, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> Not to a commit, but to a branch. I mean I know a branch is just a refer=
ence to
>> a specific commit, but in this case the mapping would be from the branch=
's
>> _name_ to the note object.
>
> I am not really sure if you know what you said you know above.
>
> Notes are designed to map object names to blobs (technically you can
> point at a random other objects but "notes edit" and other UI would
> only work with blobs).  A branch does not have its "object name",
> because it is *not* an object.
>
> What you are saying sounds like "I know a screwdriver is not a
> chisel, but a screwdriver has a flat blade-like head, so I want to
> use it as a chisel".

Well, what I meant is that at this point, it doesn't matter to me if it
requires building a new type of nuclear powered chisel, but it would be nic=
e if
the handle were similar to that of the screwdriver :) I.e. a user probably
doesn't care how exactly the effect is achieved, they would just want to ed=
it
some text that is tied to the branch, not commits.


