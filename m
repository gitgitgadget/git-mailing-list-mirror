Received: from outbound.ms.icloud.com (ms-2002c-snip4-1.eps.apple.com [57.103.74.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74063AA195
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120986; cv=none; b=WVb4qJadTCU6HOmbwOIOdL29ZOgi/Hc3IOZK7788oSJWbbU50jmcJF2X6csFA8TPVfic4InAvoZhlnl499gqx6Pqfr/q8kwMSgD9T+9X/AajmgzdJ32eJD/HlL9h87YluCj7SoEDyQtcSE46LMuG7N79FQOx7cW7GjQ1QALnSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120986; c=relaxed/simple;
	bh=mAQYMIPTwqLgc6lySfV8LTnRfShCYK1uKVl7JrF2fto=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=puVhqOm/SiP4NyiY5cD9DOad5qteNm41A4G7hCCwDnAh6sebXBT226K+Yx7LdgTdhlFkWoJxFUC+0TkJDWIHsiGM5XaDIzxu6CINx+AhQycsTEWimPDyuWszA+Sx85bsELm5Bz38LhHXFFFPnIyazImZEC5eNZObPALOAGufOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WlbqYxIZ; arc=none smtp.client-ip=57.103.74.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WlbqYxIZ"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPS id EC15B1800596
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:16:15 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQxWAVkGRQNDDlYLWxcOVk1YFFYGRAJBAlYLVi1eCF4fTBwdDlgGEhZdRVIBUgBBGUoKXB5SK1sTVRdGCRkIXR0ZClBQBktaFVUXDgJCH1AfTBZXQ1oYHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgJRHFYNV0NUBF9QVBFXUAtccUh7SQcrAEYENgFMHlkDKXBdAD0LVRpZczQMOQQodVwEMw84Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1779120977; x=1781712977; bh=mAQYMIPTwqLgc6lySfV8LTnRfShCYK1uKVl7JrF2fto=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=WlbqYxIZ2WuvV4SE6WGfpmRcNpCOZAdzjP7p9HZerNQ4591g0i2WT7mGXZVFvAf8jdJ+gCjiPkVHPCz9Ntd8il3BolgOZ2+bRETekuz7CB+XVpeIE58k8A6IkVwhwS78rUipfJTe6ZIuf69VT0e5AIs8h3jYhhfeKN/sf/8hxA90wzCO22t3Lh+nIqBYAoUzFUn/XFHav6/EIoeTes/EMVcWpmjWdQuvjRNN8SSTFrPa6ixJsWJVAk5TObPoIgBlxvBuQ5x+yD+RYxhrMOmpHxe3NKSIQAZGDO2dF6t+HZ1D18JIbED20OCVnqzuXHrpcTB9ZEEZqn2dSRC0sPgBOw==
Received: from smtpclient.apple (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPSA id E20B0180012A
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:16:14 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: aleksisrose@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 18 May 2026 19:15:41 +0300
Subject: Git
Message-Id: <7C8B14F7-6F84-44BB-9E88-2AD5A7EB76C6@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22H340)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2MCBTYWx0ZWRfX5YtWOnEk5R7Y
 9BmmIuNEMKF7ue1sZ1Pb4nVKuhnOBJ8StIvv0MPQhcvSfr8Uf3EdS5SZE0l9GHqfHduPDN1xnJV
 y/xO2kJOlmbjz6Qk28InJe+hUIJqIyjEZPPTLhMQRGxJpU1Ld6OLjrA9FVzcEnjVnYaLtiQdYaL
 tuRNnLTkh6Ywyh1WnVu15zUQnYHTnfQb46vx03/3HxDBFbyLRRtFY2dLo1PzHxS1ifPbheiMmvc
 oqo1lua3PtUnfm2FNjY59H0z8/BA4KlUHh7pq5jFK5swZZP3QQAEKnko0BfxekmsikfEHYg6AHw
 4ztfY2s0wgTVBFaNEV4e0U1O6Ra2x6dtTHBmu2NEnaRrRV0E5k4x3Xf9wI+/KM=
X-Proofpoint-ORIG-GUID: WyH_sT4-BWtBonHZKlF6sl3SJs-5P4LZ
X-Authority-Info-Out: v=2.4 cv=f7hFxeyM c=1 sm=1 tr=0 ts=6a0b3b50
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=WwDDXL0I6WsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Rg_n17r4ioxAXGdEO_QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WyH_sT4-BWtBonHZKlF6sl3SJs-5P4LZ

0JnQvtGDLCDQutCw0Log0L3QsNGB0YLRgNC+0LXQvdC40LU/DQo=
