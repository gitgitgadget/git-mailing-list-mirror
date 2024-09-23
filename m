Received: from ci74p00im-qukt09090302.me.com (ci74p00im-qukt09090302.me.com [17.57.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A101714DF
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094793; cv=none; b=loh2A3VcPWV/Srmbxz3vaYKaRJjj9oewOeUhfOJSfCiIjrGnB5rUiwyfeHAeJE83LAIpYDvB12xcA3N68ZYWse3G36q5OyUouOvL+SrDscMJWi7lg59CfN9Q93oDu9W8sAURvL4g+/Yt4A4DpzP7VPm/5JPJmAIiFyZbe/exod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094793; c=relaxed/simple;
	bh=eTyaXrSSq2ecvE5mxDWulYgv0PNaNinMSo/F6/PEWA4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i5oWL8HZqOx1wPFy5g7xl22AcNMIF4KIgKLvl2KY2FtqmBVNsl3/VN9ONVhQAh9O1RpBAQQcoN+R2MS4OCWHX/vEZst7VdVlyxq4tmw1d/VhbFl8szX0FjlYMQLsWUvu5NiwUFV6TWszd9gU8Y7w4G8Tx2Tw7wudIG7FAZhQJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mateuszwielgos.com; spf=pass smtp.mailfrom=mateuszwielgos.com; dkim=pass (2048-bit key) header.d=mateuszwielgos.com header.i=@mateuszwielgos.com header.b=Q+NeeomX; arc=none smtp.client-ip=17.57.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mateuszwielgos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mateuszwielgos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mateuszwielgos.com header.i=@mateuszwielgos.com header.b="Q+NeeomX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mateuszwielgos.com;
	s=sig1; t=1727094790;
	bh=eTyaXrSSq2ecvE5mxDWulYgv0PNaNinMSo/F6/PEWA4=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=Q+NeeomXO6LHRJBBDinTRj2JSER15iufty0/LlbObKNGIGoP4HKK1BhwISYTthxNB
	 5zvUNX8hkTgCd5yKtnpYaJ+xrnkrd9RdyChvllimUoqWMsv/jaMZVBLkxMl4bzmdYw
	 F2gnf7jY4x0V6uzHpR4jtFBvWLGnsZmLiZ3vtJNAxbfHfQeQ2zqW5NNlowZWG3hVv9
	 qzpZ3yyKuBQmCMLyhJnnyGm+gw0w5pr7nTZ6mJz/e02zlL33/2VWOvXM8i4UwLlBrn
	 EbtjWJYce8clq0izzpULx0GotW3VpQyrl/GFi7eui3hmu/UTPW7vK1nZffFF93vSHU
	 oB6hqLNKG/C1Q==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090302.me.com (Postfix) with ESMTPSA id 4F4765BC03A6;
	Mon, 23 Sep 2024 12:33:08 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [External] Using Git as a Database
From: email@mateuszwielgos.com
In-Reply-To: <CAG1j3zEg47RLYrVfJQi7WubgcdtbK2RWFBtj5rd8NtkPyXU5Rg@mail.gmail.com>
Date: Mon, 23 Sep 2024 07:32:53 -0500
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D0BB87D-9BF0-48BA-8F2D-83F8D326ECEC@mateuszwielgos.com>
References: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
 <CAG1j3zEg47RLYrVfJQi7WubgcdtbK2RWFBtj5rd8NtkPyXU5Rg@mail.gmail.com>
To: =?utf-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-GUID: wGM1gBhoBhdqyowx5ozaJMiOExjPaBpJ
X-Proofpoint-ORIG-GUID: wGM1gBhoBhdqyowx5ozaJMiOExjPaBpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409230092

Thank you for your reply, Han. The problem that I have with =
=E2=80=98=E2=80=94allow-empty=E2=80=99 is that the resulting commit is =
not associated with any particular file. I tried =E2=80=98git commit =
=E2=80=94allow-empty myfile.txt=E2=80=99 but the file argument is =
effectively ignored. =E2=80=98git log myfile.txt=E2=80=99 does not show =
the empty commit.

> On Sep 22, 2024, at 10:48=E2=80=AFPM, =E9=9F=A9=E4=BB=B0 =
<hanyang.tony@bytedance.com> wrote:
>=20
> You can use the --allow-empty option in git-commit to allow
> such commits.
>=20
> Thanks,
> Han

