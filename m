Received: from outbound.st.icloud.com (p-east2-cluster6-host4-snip4-1.eps.apple.com [57.103.76.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD0175A99
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202179; cv=none; b=A5dAA+TkMVS3WR/xNdzFZOvsSrI0whf5E1m4JjqAcz5L3dyQKw5ETLMbkJW7MvN6StHONLRXL/PyfMhK5aNVCyM9zXJedMAoGLZiRXgbQ/lDu8fjjnFKG5ITTB5qZsTgPatD5lSWGqYpnWLh6ytY2h0nemSAcHgCiJfQ2MIuPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202179; c=relaxed/simple;
	bh=GOyddEgTIkZFHHl1E7d33o2deTF8jRBSEG1vQyK7F80=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=NFNcvqyVYYWSIgUw0qQ7PeQmi+dxOacmsI+/ePsIUIQSpFhw3S+o/t8ViNNqJaTukR+RzTwnGADEgwqCYASEQC01TjLGZktzQ88LMdGKk8fyRW1YKkfdghbJc75VN3uMrAYtXjiHeg/GKxnA9CnmbOuNJPnOJ6XTpwEbbp+W1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iFI+dskO; arc=none smtp.client-ip=57.103.76.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iFI+dskO"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id CCD71180012E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:09:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1773202177; x=1775794177; bh=GOyddEgTIkZFHHl1E7d33o2deTF8jRBSEG1vQyK7F80=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=iFI+dskOyGtspQOkXpuxANwCoTizjUxI8Ln1yk96wJOma3925ZrSvKTBOzAMqYhQJuGxXZC4CWiv8g/0IwtQIkNuAJ5Lt+WXNCqhRelByPK8a2LR111VRjLQWWnmYRK4CxxVQl02jvbfACPivK/QRfa/RXJirpKzv9pIw1Yc6EyLKcjA9cJPe/l10F4d8E+pH88dddmLy+Xdol/+mtOcRgFCRBziAEVfhtNguIKUWz5yNhhAGwTBeoNJEM0MfUKL8EBUV8jCcAR0Rn2FmLKL1c51TLjs10yZ6OYmmYHnbGmK6sdgsS4X18MG6wMpZUtnjMMgic5h6urBxKhZE2+LVw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 482DD18000B3
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:09:36 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Jonny Belger <jbsticktint@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 10 Mar 2026 21:02:40 -0700
Subject: Hello 
Message-Id: <DC70F807-989A-4476-8A3F-0AF19CE1BB04@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23D127)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX6wKDGt+mkZ6q
 39h7mHZPWe98ytqJyEq7ARMcX70b8BIGj+3SLeovPARHg5FDSOie5oD9NlVU38SjMSWlmKh1aKG
 WxItcxevuwuqBaKAybIqaKi/j51E8Ci04Keg1PgOGMwRi+NX23wyegSXI01+vYQIOKkzxm8d7m/
 suWVzPuKBIR5TfrNmOWEl8Qp/LnyAfpNI12VHWYOGAiQNcfyaxMRbywHdYYzmXBLpYD5dNr7Kgg
 x0gwcregYBITmrJAUA07MiH+y5Z8/dw78YA19GrmrwjScT2ECb+Nt9DtcZFPjKODXqxWcm4Wkcl
 z49Fey5iNImjA2EUa9h/+BgtuLgPvewMfwHA31oEZk7K8BMyE0h96wxVCpzdZA=
X-Proofpoint-ORIG-GUID: 9SAcI1fAtj22ViLDglRgB9qnbqPBdOHP
X-Proofpoint-GUID: 9SAcI1fAtj22ViLDglRgB9qnbqPBdOHP
X-Authority-Info-Out: v=2.4 cv=M+lA6iws c=1 sm=1 tr=0 ts=69b0eb00
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=x7bEGLp0ZPQA:10 a=3ShiLzhxtXwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ufj2q9GEQk6cS1ZHVqkA:9 a=CjuIK1q_8ugA:10 a=xo5jKAKm-U-Zyk2_beg_:22
 a=bIkczNPxLzuTTV6gayW0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=439 clxscore=1011 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110032
X-JNJ: AAAAAAABpIZk+lAEvtlwJSYlS+JLGnvWtrAajtbAH559G2aOsQXqs+7d+/p7fELo40B9p6Z/Ovr7lxN+PtJthF1IWYN6SVNnH6bZGSAgHKKJsiQA9YWlWG0Ge85XjacC37L3IgxrBHa6X5RnrKA5+VDis3pxqIbfkJeTmNZ02OJxCZGKonkXtV8Q+4M4pRtgB6RZlCjaZhaqBDosNQlnDH/YmF4U4INtUXWpqcaH3nqHpZ9+VGXhKwfzZtZzmXa9Eq8CYIbNTxZF0r8ARlykrPB4Y8t/vgv/wFTZtaLcskDhWhKydx0AYGS1wvC6BOtYTCjUXr91nRW23RGDe1ekamLvVPfj2IM6H1ouo0tDvZ0WRRVIS46ef7tdH904ux7e3DXgWaXbBQR9EfcI4GtD3SbkODV0iRSoeL/85Hq/b4t5e4Gl9ZKLqOAGfi9zyfncmcWzFzHZXoLiSAJr5N5O7t+dsGzbGm6LJrilmBTWEj9WDmCb6d2Hm8ikVMZOGQD240SNO+YfZLZFcp0Zbl5IVq1qqMuCJ6kHED4/modB2nOsZ9ILXZ7FxIRR+NSSOFfuYl8cz7WzUxDsObdFTCrmlqJGEo7PygTHvw7Q7wmJAUZcKvOADBnnzL4FMWGCacOW0GiACZmOON2o+UIW5ne7EDNlEUvlf2YUet8d5Jc9/MVzVEalF3Wy

I have a bug / hacker involved in some serious stuff they hacked my json web=
 token and I know who it is=20
Sent from my iPhone=
