Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BB2698AE
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882267; cv=none; b=GfBCrxZU2RgAzmELlfk0D2xnDJVXwFVi5tCll/JkRinjxyKxascFwB7NdjZrK9FJUXNQUBX+LjAm89k+6ojdF9xT5tcBIkLcRdwnHbYfhTPQfPrScB7L+JsQRN7TBmNLfuvRxWjGQp3beufQBkOh3Oc0676M34DxZTYE9kanunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882267; c=relaxed/simple;
	bh=NC2pn0l9RB7WOMtmh4tt3OapAQJOxzZX81rIrbLaRU4=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=G4CK1rzF1+NZvAQmswAtIOMeVKh5WAqiiHUjSI489PNK5Jw+cWyd6ugGF1hqp9OgDUBxI+Wtz0rdgZcdkQdlieNCtvvlRCxi+zLPX9trUWMTvmFRxR1nOKEgNxZHE8MMGPO5yIOvwdeixU93pj/Ri8KsTAiM38dQH7u3/xs1mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sNrz6VgF; arc=none smtp.client-ip=17.57.155.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sNrz6VgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=NC2pn0l9RB7WOMtmh4tt3OapAQJOxzZX81rIrbLaRU4=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=sNrz6VgFwD2715Wt8HskD6/IIh7IjCWXP915W7i0V0DWGVeYGRyUbHso/udVznMjR
	 0cOYge2jXCbHlW64xbPyC+GD8hp35ApYsgRyqXPT0DlTIcQoA53iU4AnGF5w879cpo
	 Tat23kn6GWgR6lQqt/yloyw3bf4Wytvq4M/jPZxAUomrYMxGV23jl40KKkLuCSk8CE
	 vfTmA+PpLwIQVBQz6I4mqY2jiqsCeLkIElFBie3HQGFqQMj8gQ9tXuu26iK50xpvmw
	 sQUGiZ2QTj5BxUW1BmBM3kyD6uhoFRo4067DWYX8+zdnfp2BgJi6pxa4F0UpaUarXA
	 g9pUZb4Hj8W0g==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id 4B1AA198046E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:11:03 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Marko Djordjevic <marko.djor26@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 13 Mar 2025 17:10:50 +0100
Subject: marko.djor26@icloud.com
Message-Id: <3EC28E68-4E56-4BF4-88D7-1A90AA916A3C@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22D72)
X-Proofpoint-GUID: zVEtAN2dg_78_lKdXANg9yTIqbePB1jQ
X-Proofpoint-ORIG-GUID: zVEtAN2dg_78_lKdXANg9yTIqbePB1jQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=379 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1011 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503130126


Envoy=C3=A9 de mon iPhone=
