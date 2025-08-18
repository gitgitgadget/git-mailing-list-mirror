Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7E28695
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547582; cv=none; b=gaXpxhNmyXLQpXCJHl022dILnnpVnyBCAarQB92Q0bwOc/oMeX0AgMSjdYd+jvgFTSKhwXd0sXHU0snqU60EJLr57bUYTr6S9H5dOecUlhTSRxqvi8HsDR4bM0FICYir+CydcM2Y9Wc4cGCApAL8rvot0o7zQ5ilpSfDshs0iFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547582; c=relaxed/simple;
	bh=L5QSc+S3vGcKTWRd17JhqN5wifdWk4jT0hYhH1EA4mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJUHGei6soCyuk+Y+ytdvaf6V4Wz+D+remUX/RHL4zCdzE1JUedUAO7ldG1tNePuUSUP0NytaW++xIiLfms1b75s99H8Vjr97HQAxSmCjc5bab4b7VrJDJWg6+6jDIqtbcTVOgXS1Tbfo/F3/mPPlozWOgybExosFuqwGeeyfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=kUeB1OJj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="kUeB1OJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755547577; x=1756152377;
	i=oswald.buddenhagen@gmx.de;
	bh=L5QSc+S3vGcKTWRd17JhqN5wifdWk4jT0hYhH1EA4mo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kUeB1OJjh5Q/Orbc6uHMWaPIHdr2d3lt6s/7mwAdGQ1LaliOzApt4oJb5h9NWJ1K
	 JX+htTfww7GMZe8XSBWQTqQV12hnIs+CPOAhixytSe6+v1EdTjva6kO2rxYvz6/hO
	 DFMw/XPF2PXMni+0FmJbSLV/p2DaK0s+/sCI5WutY4YU5ZiGMu5uktf9c6hpjlaJe
	 X23O45HUR+0OZZQEMoZvmJj7p3ssvq1iP7MnlGsJAy0Ovr+0YD/Fo26JbthBocUog
	 K9+J0rIQTMhI7Bknp81R6M+JyRG6+IFLAeqXkTn2ztZ4AqeNLdQ25w+WIDn1OPbDC
	 zW4RlVTA56SRtnSO1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nubble.lan ([94.31.72.105]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1uqqk31Qdy-009vVh; Mon, 18
 Aug 2025 22:06:17 +0200
Received: by nubble.lan (MasqMail 1.0.0-plus, from userid 1001)
	id 1uo67U-KQw-00; Mon, 18 Aug 2025 22:06:16 +0200
Date: Mon, 18 Aug 2025 22:06:16 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] allow git rebase while already rebasing
Message-ID: <aKOHuOYFbvHpONaN@nubble.lan>
References: <SYBP282MB29631756F18E53B16F2550848C31A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SYBP282MB29631756F18E53B16F2550848C31A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
X-Provags-ID: V03:K1:tdkqvoEXaqsvycq+o6uE922SQ8ncTmAAb00onzIf0FX3LdojLdP
 yeYRBcIhbShiL6MkybmLttiSlsMuZrsflPp3URU1JrHiVXH58QMNn9WEnvWWPto2exuGx+B
 Z8xC4Sx9tKYOYJ4eu5p1q0VVYNC/Tryp+kmOENtDPpPs1bDPlW8cd23TZ4bRJp8Jm6oVmDC
 3VPHtCEo4ae5yZ/Pdk9qg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pMprRi5mQQQ=;rHeQ1WEYrUcf8BHQmQrELYtFgWK
 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
 MSIDgnVECCfTgVaQ=

On Mon, Aug 18, 2025 at 07:29:45PM +0000, Isaac Oscar Gariano wrote:
>I suggest removing this limitation, basically the idea is that if you do "git rebase" while you are already rebasing, it performs the following:
>* it computes a new todo list as normal, and then prepends it to the current todo list
>* it does a 'git reset --hard <start point>' like normal
>
>If anyone knows of any tools that let you do this, it would be great.
>
https://lore.kernel.org/git/390e6a25-72db-8a9e-97af-7b9d803cfb2d@gmail.com/T/#u
on top of
https://lore.kernel.org/git/a6e31eb9-81e7-4d7f-28cc-73b5e46525a4@gmail.com/T/#r890ce9ed689422db9fc40d2bc2cba36f7b183ec3

(i'm keeping rebasing this series, but it's still not ready. if you want
to work on it, i can post the current patches.)

