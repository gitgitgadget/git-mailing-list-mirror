Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A060ECB
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685112; cv=none; b=RX089nEforDV9sGrTTnQEKn8wagLsepjGjAb32M06qEMTI30T5Mtk2+bXOnOypsleSeLOkIS3k9g1uW+XnrAnGhfT/lhqRnmPnIATn2F00w6zqEeqDkSCMZRMraJt3cFMXUA2swL0mhuN39uvrK0scdyxFDMw3RE3NvNfP1fC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685112; c=relaxed/simple;
	bh=6nMP5MPH4JmFjOyEu7nZMkm7WS0ERYKYm8HR4Jf0p9M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AvwGDMyODvcIXi9nx7eorPuL7vfUxBlOpAXvNI0vPDpDXgB6NFmp0ut5CNgHSG9NegNzX0Lm0OqQ+GJ/D/yFL8J6ssQpSCdDd2wNhMhBCgSufCX4WfG8680agRaRNZnLCSX2j7/ATVGEZhIyOYEWZ/C+w4JjCm99BhMpJctoPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=K0k7+vdN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="K0k7+vdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706685107; x=1707289907; i=johannes.schindelin@gmx.de;
	bh=6nMP5MPH4JmFjOyEu7nZMkm7WS0ERYKYm8HR4Jf0p9M=;
	h=X-UI-Sender-Class:Date:From:To:Subject;
	b=K0k7+vdNkmcbji4Iv3WX/hWyLjp3cNBE5Eiw7gC5WR7dxcDInoyHX5sv7PvRKSMC
	 SRlZIx9yNHBvTJW8WFAPrmKKlre4eDM2IJou4Z1lOQc+ozzYxkRoXvm/R5o0LHTsX
	 Fo7NSfrYzNGO9jCwl0A0gU5+DhkgpnPuzkflsRKq6r2zPBBmjfiPwkNwMU/ikoAgE
	 GCz95fJJVCDpPijsDsuoLIwxW6HAapde7/IRR1Ff6PtQ12VBMs/vpbNM/qpq7ESuT
	 JgkohYYDXUYJBKWd/vMhqJbpsl0YKMBwFMWgwWMNu3A4AUwQsivFbO79R/QXNolxH
	 pxbvKXBZsttFMW6aBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.23]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1rXAEN2JgG-00X5EK for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 08:11:47 +0100
Date: Wed, 31 Jan 2024 08:11:46 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
Subject: FreeBSD CI suspended on git/git and gitgitgadget/git
Message-ID: <d2d7da84-e2a3-a7b2-3f95-c8d53ad4dd5f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HB7CK5bFUjwP4dGuHt+gU+ADvmrRynWMFwWUwOEs59Bhul3M72k
 ofd6sMecj0fUGRKme2VcI5IGZp6QAuQRw4Grv9RcMlILMbAFk566uEzXjXOqR6UXeR5mWS/
 ghxbsacPL0hyfieFvSjYrgKp8qM5MjkHHWTP65hQz10ZMdPz1DHhq3L6sfDCIOkQyecvJp+
 p2I8Dy5Aipe9kqFTyy3cQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ekP5Fp8Erf0=;ydT2Qa+fFRJTLuT5ht1upEXBa60
 Rotze/kAqXRONxaJrxU8tH5xLWtGSQZ2Q/XKEN1SqLPk4vXZ9PS1IPhRvd2izOEg/il2C7Bf7
 xtvIvBZ/u9PSHWL4P9zCQx3BbrdplvMhcUiTlWdQ3O8Ug3FoQY4O9eW70AKCnqIpMko1pP5hg
 b1WEVzUhdrbVAGEnMYfHzwaSZEhF1EFRcKhKHrdfqaJr6aDIR0EV7zuQMVuc+I1KtFHZ2Rf8J
 Bv5NnMWTKNObfLugp60TBs9dqWyF0T7h/pJwwzG4LPY5fssCWWbj54rPDxnLxsZpm7PhUrOIY
 LgMmVyc4h9fcOWgL9qSpct7xEvPj73YpIF1BLS3vQq1vhJEljqsAYeEcxyzEBfrt2tl1/AbHx
 ORhp+Ak+ffsPmWJzlC1OWxMXBZ0wahX9fgedK1JvjdgvD1vMOwIM2Fl2lsk6Lg0J91H0/UzZn
 ikWPJQYOHD6f59QppTN++ORD8GAgKmjStAoJiYNxIVedonqvSRhAc/DGDh8ITut1GNzj9GHLH
 rVqcNlvR2C6OfZnyw9KC9s3M2ay5Wkn8wT15FRPsx2bMlDzbZaBZidTy9OghmuGYU7Rg1k6hm
 Odu0FOjQzGMfxBfp9YFpkN7bvDMFGAKhJqYSA9KeRCtdY9e5reJVuk61JRGWye5t3+M72RlXA
 syA6rjRLtS7TL/0cOKlWJLzlbtB00Yaf7+t4K6SJtmmodierUs/2ajtHfNoMMAislKqOylPW0
 FGEa/8/L9ckhTcC7ahA+uCh77aZMCNmqNAWdCl4NNwNx4Y020wDgNnkSlVz3kEd/RaeCcXZ4b
 bilotGht+ABQB7jmaozQd/wQmK12MUBxpT7W0Rl0Dno5MUY1qQ83Qv9tgO5FV5CZISnhMFmic
 w4G6A6XHFph4njHKuxRi86gz/6mZ9FDo9kC8qMpdwHltiGbvnkg0grqRC1B1Sy8MLmvQalvTl
 ifxX+Q==

Team,

I noticed that there is a problem with the FreeBSD runs on Cirrus CI (see
e.g. https://cirrus-ci.com/task/6611218006278144):

  Not enough compute credits to prioritize tasks!
  Failed to start an instance: INVALID_ARGUMENT: Not Found 404 Not Found
  POST https://compute.googleapis.com:443/compute/v1/projects/cirrus-ci-community/zones/us-central1-c/instances
  {
    "error":
    {
      "code": 404,
      "message": "The resource 'projects/freebsd-org-cloud-dev/global/images/family/freebsd-12-3' was not found",
      "errors": [
        {
          "message": "The resource 'projects/freebsd-org-cloud-dev/global/images/family/freebsd-12-3' was not found",
          "domain": "global",
          "reason": "notFound"
        }
      ]
    }
  }

This makes all the FreeBSD CI builds fail immediately. Sadly, I do not
have time to investigate further, so I suspended the Cirrus CI
installations on https://github.com/git/git and
https://github.com/gitgitgadget/git.

Ciao,
Johannes
