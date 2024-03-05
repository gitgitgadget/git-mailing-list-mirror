Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94718639
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667895; cv=none; b=lItW/20nLPTqs6d1OjtWGQsvLkmhnVVxo5Dy24TRNGrhktFOxeSwia/hfhPwkr+hO0hTlryahrA37Rch2JZwF2AADsoDl71ajagzNY1u29XneHcf1o48vBT6B8+7dRkNlvvzsWdOQcNCOGOAil4b7WseRkCioPWTWucoXsDMF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667895; c=relaxed/simple;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=NNTTtNC0iplLmqqaRbdNQomKWrFt3fMw/eB1lgoWAVDtqfRtRDz9WU+DYOyn74SO0X2kA31wSkVY7gxINVM55YVpD8C7+peObLGzIHsdMlgPQaUXabqMbbbtX5W3ONs5Tq1bCuoIM3vyn3NNu7lWbJYahb7Ayjr48gHik9oTUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bdxb3pv1; arc=none smtp.client-ip=17.58.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bdxb3pv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1709667894;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=bdxb3pv17eCLirk/sIvyOuydQwj9Wc6bHddOLLVla2wNkNcYHp3GpUExXsWeIv6fF
	 7qrCvSwDyElqPW1UPItgJZcdnuyWptV+7zudGdMlqhUqKGW/qASsssBRGPrn8yX9Tb
	 /O+7YffJgnFR6Fsu1d6m1nbrUV8zfJTBJlDNK23nE12/CJSyw36omS4QkOvKnz8BDQ
	 SLDuYuo/bSnej92+d8JO1qARf85ClVS9fNg7B5SybvKyJiw7ZyA+mdRpqWnDXtN/9h
	 ccYv0qkWT9CUg+Nt4wBB2RBZCcVZoEUwGKknuusnf/xL9BXr0d2eMYRmFJN08rocxE
	 g9gz8Zf0A98pQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 2908381373
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 19:44:52 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Rifani mei <m4ichen@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 6 Mar 2024 02:44:39 +0700
Subject: Tc
Message-Id: <14BC30E5-DDCE-4B9D-B066-B9F7C2FB827F@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H307)
X-Proofpoint-ORIG-GUID: E2BbpxKRpwf-5CwpgZSXGC5X2jKE4TRN
X-Proofpoint-GUID: E2BbpxKRpwf-5CwpgZSXGC5X2jKE4TRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_16,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=450 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403050159



Dikirim dari iPhone saya
