Received: from outbound.pv.icloud.com (pv-2004j-snip4-4.eps.apple.com [57.103.65.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C603BFE41
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078811; cv=none; b=o3f+RDQI9VSn8K2+2ggNUYSt8ybFnmk6c05zFKDsvKJTSP/nWrY7qhWcNUqPTp5WZzMnHBdnPxcmYKnkFW4IdvkkS8pX+8ZDTjoEJ8vLIiEGcZHL9aNTK4MbWTsYi/6WsChw2+9ZHEtL2wzNOZoB6orSduVcxvceTXCtji7/rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078811; c=relaxed/simple;
	bh=BxHwjCABiI3nlcGkkw8QZso2Q1DLLzU+Fh8dCZaZLPU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=kiFouDypE9JLQ/zFHheaxJZy2g8VfklLniBs2X5ZaxO876+b6z/RmbiiSoXPzlFwmE8aRLzyvwh44IWhVz48MF8KFSCNinEAcC/pFgdz129EeedNnHEeVS0/ilMtzjatkmK1jYf0ytC2cUEg1S5Sqte05tnO2W+FXRakPw8vfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jQIBhaUG; arc=none smtp.client-ip=57.103.65.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jQIBhaUG"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPS id 1CDA218001A4
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 11:13:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776078810; x=1778670810; bh=BxHwjCABiI3nlcGkkw8QZso2Q1DLLzU+Fh8dCZaZLPU=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=jQIBhaUGwkd44kdiaIf0bzVAtLFH9BbOGkdhhMzbSSBuGgZ/nEPCl+hjapj5dI4ZNm/lp3AvIotbDVDLrorSolOzwNwzBVlf374SJW0z10UhiuNI5LPPQyGC+wi2sy/46ulKxrBmMiO/yi3LGoDUbk9pN7Vih5MJyRwy5DlsEyOqawiq5Y1y2uUopPfqwlwdQZyUTPjsxGwS5rtNVYEKIwNwNbUaz1MRNDa4qRyZOsOT6QoqpxZ5uFJHiGZfd+UHQf2w6ff+FtzRa8QdbKA116h9PL7j++Lxfe35iAznF0NUfq2SETSSA79TtpQN/pkoFEi9gqeyubEMdEVWMjMvJQ==
Received: from smtpclient.apple (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPSA id 1E28E1801AA9
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 11:13:28 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?=C4=90=C3=A0o_Th=E1=BB=8B_Y=E1=BA=BFn_Hoa?= <daothiyenhoa1988@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 13 Apr 2026 18:13:13 +0700
Subject: ji
Message-Id: <44A59B29-D5E6-480C-8C01-6342544F1A3F@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23C71)
X-Proofpoint-ORIG-GUID: L5Fl6Aok7wBjU7Vw16kpnZ0q7iyqmLYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDExMSBTYWx0ZWRfX5ihoYRNrylnh
 pjdQUPhH3haFV9t+bn/nkrwpMKuteUQqSfJ4Dl/kWjQfOWqTsDzwd5wRGBiNxvQxUeCxcX3go/1
 96lCMR8mE+HnAeU0g07/9XbgsHdaemynXdjACzv45Nmz6PqjKsXEHY+giNLfU5ElvD57EP0lPc9
 VjETOq+xv2msByrlISo4KwPBLUJiMfUr0DtOVR3tgW/Q/fp5b/n/itAAb7tYFbU1vuJTc0PQehw
 ic7yU/yPLOJerC7zIbatxhHhaiBiheDlmOhlbqvkCUy2a4dFKI/WbVC6F4eWlxj3vzG9O7KA5HL
 XbnP7jpj4mC3nHqHMOcCpbb/qhBaAmUqnoj0OB4wZnSXODDgWtRyvFwOPSKICg=
X-Proofpoint-GUID: L5Fl6Aok7wBjU7Vw16kpnZ0q7iyqmLYo
X-Authority-Info-Out: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69dccfd9
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=gzsT_StbWjkA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=R3LUhDQCI47KWELQOWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxlogscore=476 bulkscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130111


=C4=90=C6=B0=E1=BB=A3c g=E1=BB=ADi t=E1=BB=AB iPhone c=E1=BB=A7a t=C3=B4i=
