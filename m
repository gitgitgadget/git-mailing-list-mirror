Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73143AA3
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="zT8Gsm5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=NuQrWIoZfucj3PyOtJtfk31D3QO/UctI9q7m/CXA5Bk=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=zT8Gsm5J/eBXjsX+5QqKJ6cpN5AUNBqaPm4UOCTg6pFCDQvIFRBCy0txSF+SBoh1bDZuXg+v1tZa
        ta+K0GQGuneJlQ67gaEE2xIdMQiX56X1iGxd8vk+PqlLcGeR9f/PtBFdO3ba4lV1OcRY/EFBVbqp
        rpkZPiRwsiRNeDDt5i0=
Received: by smtp-relay.sendinblue.com with ESMTP id a5a8c257-8550-492e-a6fa-e88ee59d4d66; Wed, 27 December 2023 20:53:50 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjMxMjI3MjA1MzQwLjk4ODYtMS1icml0dG9uLmtlcmluQGdtYWlsLmNvbT5%2BYmkuZC5tYWlsaW4uZnI%3D
Date: Wed, 27 Dec 2023 11:53:39 -0900
Subject: [PATCH 0/1] doc: git-bisect: change plural form to singular
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 6B72252025D; Wed, 27 Dec 2023 11:53:48 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com>
Origin-messageId: <20231227205340.9886-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: k8XeFLaFVOVhfjh1t-ltUTBTK_YDRanh6zGOBigDKUW-M65XEvju2mHWHZFENnUXrU1efRZeOoIvqijig-TBHGnbEIgyKPS2LsVnSvHo057Hrs_2KSeoJF7YHqXjKoojTbHSZt2kcsaa0S7L_3v693u6FMpbSXA47UhSL_2u5cq0
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Correct the usage in git-bisect documentation to use singular form for a
repeatable argument as other commands do.

I reported this tiny issue previously but didn't see a response so I
thought I'd use it as a chance to get up to speed on the patch
submission process.  Sorry if no response meant no interest on this
issue.

Britton Leo Kerin (1):
  doc: use singular form of repeatable path arg

 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
--
2.43.0


