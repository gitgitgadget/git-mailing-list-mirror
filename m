Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51B34389F
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591366; cv=none; b=Y6PqwE6sIz/Maur240rQ7B8vefHv4oLHi186d/96akxwOgDdd/RvhBAgl6A45vlnc7jwjr93EqezJhhOZ8WqFMc2UbfhIaSu/Zo+lnP/Hgudvlk5kO+pLyO6W3gcqmRcClc7NGsp0ObnhKryPML2Tm4+vZgUGujPV18tYqeFFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591366; c=relaxed/simple;
	bh=YuG12wF1wE4qPKLoj5BZqpIBPx0SIIWbJ/UlNZcgV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=YgM+hzhtPaGuMo7lJ8y8Cxn+pOPZ/3YZtpUDwhjaQUgpA9d+1UFCuIFAgR3Xj6vkb9a6IWs5w4UTMJ2lcLs0i4a58V+rWJJSr/fria+PeKSzUQFqkjCl1RBsqIUVesyzkRnvT6ljSqW7JmXVU3BmPztYtch5ZVSo5LjFpgVayw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=FmCkno2O; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="FmCkno2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1782591362; x=1783258028; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=Y7+lTT+fBCWFndkeO/DXTJwmBJ0vR6VHc9kU+vM+/fY=;
 b=FmCkno2OwfGrH56/ZTElQWb+eaXoCpOj181uAL5+eDCcpVRF1eHDjs3AbqGUchZ//nRRZYN1
  rsiHd++NR4Du4g0/B3XVGPSN8QSaxT4unaix6RKptH8FXizEQ2/ZR1tImUL4RWiYU/WtVvd+ze
  E5VCNTEO01e+nuKCVgaZUUHM7jnxXFxWascbXADOLGdfj6n0I2KYHdw+evArjx7yyjgrrSDF8a
  2HXsMuP+3rfbYHnsm9EKcQgrqqvMmSb+XTAJjE/cZOLGuOJlF04vjgSp3+O7IhuPuGJXvwPflW
  0x9KuGXvqYp+KHG11B64IWOmB2juy+KNnjpFzg6sV3VxWmpQ==
Date: Sat, 27 Jun 2026 22:15:58 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: 2.54.0: fyi: endless loop at 100% CPU
Message-ID: <20260627201558.Bw6A-jbx@steffen%sdaoden.eu>
In-Reply-To: <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>
References: <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>
Mail-Followup-To: Michael Montalbo <mmontalbo@gmail.com>,
 git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.10.0-alpha-44-g9d85ccf596
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Michael Montalbo wrote in
 <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>:
 |Steffen Nurpmeso <steffen@sdaoden.eu> writes:
 |> I have no idea and i am not looking either, but my scripted update
 |> of tracked repos stuck, and i can a hundred percent reproduce an
 |> endless loop that consumes hundred percent CPU by doing
 |>
 |>  git ls-remote https://gitlab.xiph.org/xiph/opus.git
 |
 |Hello, thank you for the report.
 |
 |When I tried reproducing this locally I was able to get a response
 |eventually, though there was what seemed to be a stall mid-way
 |through the response from the server. After looking closer, the linked
 |repo appears to be behind Anubis[1] which may be rate-limiting
 |and/or blocking the requests from your script. FWIW, running:
 |
 |GIT_TRACE_CURL=1 git ls-remote https://gitlab.xiph.org/xiph/opus.git 2>&1

It now works for me.  I cannot reproduce it no more.
(Fwiw i got the same behavior for all repositories there, i track
more from there.)
(And no "network hang", that is, whatever, but it really busy
looped!)

 |locally showed the TLS handshake starting then pausing for a significant
 |period of time before eventually completing the request successfully.
 |Maybe running the command with the trace will show something on your
 |end?
 |
 |Also, here are some other potentially relevant configuration options \
 |[2][3]:
 |  git -c http.version=HTTP/1.1 \
 |  -c http.lowSpeedLimit=1000 \
 |  -c http.lowSpeedTime=10
 |
 |[1] https://anubis.techaro.lol/
 |[2] https://git-scm.com/docs/git-config#Documentation/git-config.txt-htt\
 |pversion
 |[3] https://git-scm.com/docs/git-config#Documentation/git-config.txt-htt\
 |plowSpeedLimit

Thanks for these pointers, i did not know about such configuration
variables.  I will set them like you show.  Before i only had

  [http]
  sslVerify = true
  #sslCAInfo = /home/steffen/sec.arena/tls.git/cacert.pem
  sslTry = true

 --End of <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail\
 .com>

Thank you.  Ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
