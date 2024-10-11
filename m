Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D16199231
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679913; cv=none; b=nVblARQv8Wz78Z2MCGQBHXxh1L3jbAnWZ/24Pai+73IKt3YE3oyWofU2yjUNoqhYgiFu7/40vGDeipco7HnH4WYGc5Jo0i1DWoxzMlprgtjk3dtBu3nMcBjcsZamrNMrbVmT7DN5clhd4OFqNhV+6a1HBJHIw8jIahLXbrbWFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679913; c=relaxed/simple;
	bh=YZmEmrdtAHreP8oQJLn7m2yiX5aPYhLCN25A47u86SE=;
	h=MIME-version:Content-type:Date:Message-id:Subject:To:From; b=FWWpNNdcsSUlKPnJpsK9Ejy0uMRPqmJWfiFGVQrKEsKNPtg5eFc788405VEEODLYyToTyzWa7QykD8WmjVbGOnnpjsMzY9P1mwh7GnVldRCYmP2hkb1yZVo9Cq7KWCxKbudnSKi5cj9QfIapyxQJ3PLc99vohjwSXQyO9UK2L4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=hBSM6u+k; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="hBSM6u+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=YZmEmrdtAHreP8oQJLn7m2yiX5aPYhLCN25A47u86SE=;
 b=hBSM6u+kh2fYjLggo2V2mqJ72SWlE4iePDVs0E/Szs6/VET00sV22CKSwbHpUqj+G6+KmphLjLQE
   cmT+TtWpILd/w7p+1VAogdPoyPHWQMjEHTo8+xyU3o87B/gk5CalU5WS0E2qoFPVLAJ85tqliB2J
   X7OVfpzrsbY8XX7kRr+L3sJPjhJUiXF9CrSzG3QZv61EeVtaHqwV2RqsNIA/M+mGdURhkcZNztSp
   l31PCKHOEhPoSprBiYa8mpDeM+ZSYbg8u4OywQajkTASZ6hSYzaOCH6Ugfq5XigLKS9DYNDg5EUy
   qFEWIpoOlutvtelQ37fSV3Ptlt7GVQaUWZav4A==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL7001JALYBLLD0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 11 Oct 2024 20:51:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 11 Oct 2024 22:51:08 +0200
Message-id: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
Subject: ref: with git update-ref?
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Reporting-Meta:
 AAE9JU+4RyCOgAzz8MaVIdK7uXQOW52i3u0fqX3+ncX6a2+WNYHatMOff650UT5i
 rzrEo9oC5EmHS4ueFoRSTrWPnI7+yC43jvYVu/9wcl+eE1fb2ALbRI5fmwKDSGD3
 pKSzcd8U7MESlRLZPWsLiHOifVzS0UE7DQZjCBvUriL1DhkFtfh1dEii9zFiFA8D
 isMfu705U5yytQnxkoq6HSohUY+MfywgM9sn/FCdoVYuRLs+7IHnPjJZU+O2lRLh
 GlyH6mCU2dfZGYZo8/Y637F5bOgpE53z5aAUDCDJGutvcfP06v//mPaxEBWNZ5Jj
 Af6B/rgXhZ1VYMRgJP0vXitdaSz8Oyk1U97zZBoQSh4Db/F/qCguLbfxPZmxaeUl
 bPikO9Tpd8tpN3fge75GNbEikGaXI/tjvvFRW8C0+tRD4UFiUI6mS2d1a24NySXb
 vsyhBNJxegA45vROJwM3pvsfoLOZStHSEWXFZF8aLpMOgJz4I9WY6aaB

Hi,

the documentation for `git update-ref` has this sentence:

> It also allows a "ref" file to be a symbolic pointer to another
> ref file by starting with the four-byte header sequence of
> "ref:".

After fumbling around a bit and getting errors like=20

fatal: ref:refs/remotes/origin/test: not a valid SHA1

I looked in builtin/update-ref.c and I do not see a call to refs_update_sym=
ref
nor any checks for "ref:". Am I missing something here?

Thanks,
Bence

--=20
bence.ferdinandy.com

