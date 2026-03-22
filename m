Received: from outbound.st.icloud.com (p-east2-cluster1-host2-snip4-3.eps.apple.com [57.103.76.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571F2C2374
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774170471; cv=none; b=shewXvFgUhJhxrrG6KV+D8hv3da8HiSpnXgH404ZXYMxkMUDslTl/tLVhbmKHXGDI8NIbUIjY3f4lGTnSGIQdDH4USJr3hfiutB3YwyDcltdcnmhx2RJ1xkp5owDZuT61Gsd3n7zblUcIbv2h8Qn9Uxf/e8w6zZzy/qLlkDf7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774170471; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=I+JdQCRfaoQhO6eHPNGAY7XmnVyvv0eHSQul9vXiyhvNMr4qI/J6w/+1zHP045uV8c3eTKpWdsXIyLkxSdiIZuiBmYvJO1Nv2kh4rY1U3dWKoz3nTgYGVphgA3PMqpF66fQvwscWm3tWhI9yEeDf06lLsuACY10F1/vktsNfzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dQPF2qIV; arc=none smtp.client-ip=57.103.76.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dQPF2qIV"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 6F88B180033D
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:07:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1774170470; x=1776762470; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=dQPF2qIVbIorG4tbn67zdUDF5qkGq8KYYWjHDds+JMwIKs+WCtp1KRk+3+CNKrm2MfZhqOc0ViUfJOe4SC0PmTNgYWpHqndiFz8ujGs4GaugC6QQixF4L1CwpXgTfP1w5iN5ufWPhaTZ82p1hbXpmsq25o4Y2jXvz7HP4+hwW9oopLh6BByMSjEOfDZnrqPUPTeZL/Y3tTc/xm19pxBQXL1dpZl92/nvLPhWutumY6PBzVzQuVO64C85G3RU0bgLKmeSGwWPX2H8Mp+Q1qJSgCwCbBLB0JV4RjwXtSdOFHrdaJJKANsWt/usMSdlviahQg6WrnZblsgCQUFfkfED9g==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id A91711800322
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:07:48 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: D <robinsonderrick.1@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 22 Mar 2026 04:07:50 -0500
Subject: Help
Message-Id: <DE97396C-5F25-4601-BB3F-642E7C4CA9C7@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23D127)
X-Proofpoint-GUID: mbI79SofcI7BSVaMQr5oEpHxmR8RxXc8
X-Proofpoint-ORIG-GUID: mbI79SofcI7BSVaMQr5oEpHxmR8RxXc8
X-Authority-Info-Out: v=2.4 cv=U8yfzOru c=1 sm=1 tr=0 ts=69bfb165
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=x7bEGLp0ZPQA:10 a=SZ6xuNvJUSUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tclcd6dtLQvEqt9_mmAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDA3OCBTYWx0ZWRfX4D2/cNP71HZc
 FOXi7dNgaPQvq/mntUyT6HXXMxrqjG0rqtyqaQ/rgFdr4or7NNfSTAURyBLTRqFFSkoLuUmOnFC
 Ezdu9k+SHUyZY5YOMh4g2UW+bujaS1bq/VkYgYXUj+cSNhV0lZEd7mv1Ab5gAYm/GkhXHDfPuDf
 xuEeyLYriJ1DmySC9V3H4HC2K3LW6jlzu+dbQJr8HhFuHGex9svIix5R4Pi4Ydajpi64ztFk15Y
 pUzA24twge9TJudhOLZWo5HJkF4dRAcI6jlLZI68Dt28E9gIyx+lx/9SHKMc8Hf63BvnbbDrZDG
 S/NAxwFgFeqBOcvOHK37mo9YQyu30zUrUZ8yUBWFpRz++Gop4WXcw3dnJtZeY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=384 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603220078


