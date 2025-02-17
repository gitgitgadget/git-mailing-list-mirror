Received: from qs51p00im-qukt01071901.me.com (qs51p00im-qukt01071901.me.com [17.57.155.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF347DA8C
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761690; cv=none; b=CNXUizAqocj7PVI/9osVVglJU8XoOGoN2pWHY081O85Vkz2DQz2Q6vQiseL+Y8iWUMf0jxBQIc06g6TXIvunkrOXusgWY30yIrtsW3dXypRQVi9LsgSeZgt5iir42m1KE6lwmrEkEHG/LJhr8PzOpmsP0JKrCyZk8DQGqARJs8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761690; c=relaxed/simple;
	bh=tugR7AzslemjUoJR5r+YWRBsM/g4HGeElzRrLw0Gawg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=cIkNiYI3+m529zirDNAOplsoPbNH7CzZEuXHqTdrLtWWHb4nj9rEiHYxYoFAY5gauShHlcOG3BhkcTltl3XABMi95jUHtZxsFMDPMZa5316D2aPhRJjGb2NaVHBFCIhymcwq3wYhIaJH6udVhjhW/vACPxit6CJaOYe0j3gaRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LP0ekR3F; arc=none smtp.client-ip=17.57.155.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LP0ekR3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=tugR7AzslemjUoJR5r+YWRBsM/g4HGeElzRrLw0Gawg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
	b=LP0ekR3FYuHDVm47EnYnqAi8PciUn5pYR7zyU9MntIjXwP99fF3QPvxLdzap0KYXb
	 ck2qK8fYEWnO3iwhHDh28jK1RSTuCI/g40mkZgHqhq7O8wNL+7bcLMUaBhVITR627z
	 hYShRUKpbzflTvBHd7QUIBCB8axk1isnuBJXPjd4P6jWfs9cs+RgUh95qbN4C9BmA2
	 JFMWtiNYv9kXw1aPHfgqWJ1ZU8QWh8+oMEu8rEAzu/dHaL4wp2z2QTGKHsxOL4OIwJ
	 bsP68Xq+N7VVxUQIXTVH4M8DLbiJpRrGVePIsL3w/317fO5mpnAwpHvduAXaF4m8ej
	 2eVBsF3lw4aYw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071901.me.com (Postfix) with ESMTPSA id 6186262801EE;
	Mon, 17 Feb 2025 03:08:05 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: deeina1208@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Crash on empty pickaxe argument
Date: Mon, 17 Feb 2025 04:08:03 +0100
Message-Id: <CE2E1447-D0A0-4AF7-A35C-E30D7B347265@icloud.com>
Cc: cebtenzzre@gmail.com, git@vger.kernel.org
To: sandals@crustytoothpaste.net
X-Mailer: iPhone Mail (22D72)
X-Proofpoint-ORIG-GUID: Bxbo8X-0bYMShPRiMoCp-m9iI1wIQmEC
X-Proofpoint-GUID: Bxbo8X-0bYMShPRiMoCp-m9iI1wIQmEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 suspectscore=0 adultscore=0 mlxlogscore=543 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502170024
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8


Rosario =C3=A9=20

Uma=20

