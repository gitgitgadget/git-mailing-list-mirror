Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193C63AD
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=circuite-imprimate.ro header.i=@circuite-imprimate.ro header.b="MX3UUwQ8"
X-Greylist: delayed 2539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 06:05:47 PDT
Received: from clean105.mxserver.ro (clean105.mxserver.ro [92.114.95.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDEBD
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:05:47 -0700 (PDT)
Received: from sha34.c-f.ro ([185.171.185.104])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <cristi@circuite-imprimate.ro>)
	id 1qyWjK-00Cixk-9O
	for git@vger.kernel.org; Thu, 02 Nov 2023 08:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=circuite-imprimate.ro; s=default; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2jKj4KQdLNNNg1HLe2IhWcpHqq05EEOto3IgMTtD1Zs=; b=MX3UUwQ8VKEpKnJBTqHAockWFm
	dq+zTOJzcyDaY0mdTObqCt8SpObr8c+BQJpW/yn1eMq0gPshmXRa3jmsVOVLNnctDV1zB4dEim05I
	dG0Dj2iIO+H3D/sxtlFYtscYgBpTyGld0Z0xClbrtTu5bi6mHQbfVuoPXDCpXWSLhnCiHyT/KVSR8
	OokgITlE6bP/MdHRI7YC0CSnMOisjWBOgI+nhecpSzUkLGmFdwUfNo6zxnNB9DcIFzfI1CJX3kGxD
	iNIA7IBk1lKi4Enbjp8j2frKMyqnLsyeBEpINoF5MGjvjxZhfcyzeEP7CKGWvOAqGuB6TFx9gfGOb
	CkdeDcRQ==;
Received: from [79.119.138.138] (port=63097 helo=[10.10.10.75])
	by sha34.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <cristi@circuite-imprimate.ro>)
	id 1qyWj9-008eq8-27
	for git@vger.kernel.org;
	Thu, 02 Nov 2023 14:23:20 +0200
Message-ID: <163d2956-84ff-4261-b945-ccdb0a082778@circuite-imprimate.ro>
Date: Thu, 2 Nov 2023 14:23:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ro
To: git@vger.kernel.org
From: Rus Cristian <cristi@circuite-imprimate.ro>
Subject: mailing list question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: 185.171.185.104
X-SpamExperts-Domain: sha34.c-f.ro
X-SpamExperts-Username: 185.171.185.104
Authentication-Results: mxserver.ro; auth=pass smtp.auth=185.171.185.104@sha34.c-f.ro
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.15)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9WLQux0N3HQm8ltz8rnu+BPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xKs2hwWO1Fm7wz48pUGkvLadmdMHfcHfu3U2C33bOHxzfX
 vAz4IqGiDvvd0ijwP7Faa40DxZPJuLUk3zkVKd8pdqDuc9lS3Nx+9iKFZ9qooOwn5GvWx/ahHs3P
 xluFeYir5r53oquAGxGXLzue8XpFpuGXed8VjoeeEKguXydrkab5JioerEeW5bnPKxmtxd4CWPnn
 lpStxYLUJ/v4XmGGlUPd3WAEGI/y1kO7/zzfbnr6x203oVjzvgx51+KYuc8AKQlQdTfwbSciar+2
 JCMst0dEunmtVTQWqR0MJGYnYGBIZS4rRgm1GD0QN7Psq7kMoOLjGsRz/MUE6aIZoCcUNXR4aVG4
 tVHU1Zldyy+zfUSFrVoAioE8QlyK89VlixPLF9mvp6T/ocoh8oK3JvsMrqq9GopDryQPg7s3heG/
 sptwIRuNuppYmJAhwWaToKKnOLgkNYSIm5/jKyA2MtlgdQdVd9YOTNwpMBmKomfUUcMOFnTMvMql
 KobfKHSWH76L4UiXG51/x0Ki/1/azQiQnOohEibyptTVfIJK/lrvEnFQ14pzlcriKSE0Pc9zNwyN
 6kovTTSAzqeV0x76gkjncfFnVfZQBCp8PxSxsRZWe7gA3RYn8boOMlSMNkEUTLCT7UVZD68nyrOg
 wO0GKtxtKpJUDsUvFy4QGPSpJJ4E219L2zldRguLVknTBH19KmZPvhkSot3yX0Uz6/z7iRxN/ONF
 X+7659ttsxNx6fq+5+yIO0aXvuBg3fzijmZEQyhHLoL8gkU4MGIktB73uorI/mQvYwCJ1LHRxAWq
 OTm+okYf8zM3+PM/7hVljakdTT7xKsrWKN2zZlAAFlpnMVvE647lNwN4qOsSZg+fYhVZG5zCFBxi
 RPE+UeIQvgOHcqKVextl35yRx5PuDiYyxK/RLCfaSnQ+Wx8M8UKlmOiq1zuY7RBaKYFrVcA+NT5C
 ZRF49DjiWowOnKvI8aF4jzAu2ObH9RO8PhO7HxEFsTFs0jEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro

Hello,

I have never used a mailing list before.
I have a question (a feature) for git scm for windows.
I'm using git scm for a few years. I have updated it whenever there was 
an update.
But the git command line command does not recognize the key loaded in 
pagent and I have to enter the key password every time.
Is there a special setup for this or the git scm does not support pagent 
yet?

Thanks!

