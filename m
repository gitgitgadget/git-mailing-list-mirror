Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4591DF970
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826771; cv=none; b=ZC1CZrlhefOWx8UPsH+CmweA+U2T8DBB/QczjmkPqVRvEHq7sLCfyhVl89dvSIlOU9f1GRirmnIT3Kb+JsZelsnaRdWCJJV7G+PMxNeunjy5uW95kxCqMvq2530hgmE3a5YF9vt0xFBujzLlIEzt+Smd44wNELq2n4/qYBgDJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826771; c=relaxed/simple;
	bh=LMgmOH81XeEbwarFgE+VQHvyLyS42kYSZhTng6/Mehs=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=cABYF5XbCcNnYQtBRnnOvTVGfVMnwu7Wm+uPgUG1GJynWZy6Z7wZc4Ioyjf1WYrhx0HI/ML75gcQlYuLILNEMKjkOLvipJUke5ehLOpZotJnfDR5R0qpKuHufSaxROIAm4LtbDYVtm1Cs8lJ/uPMYHJO5N6+FR0xS5S/WIlX6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=Yx+2aJuc; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="Yx+2aJuc"
Received: from opme11oxa18nd1.op.nd1.pom.fr.intraorange ([10.110.57.109])
	by smtp.orange.fr with ESMTP
	id 8N6ftgWm81uJp8N6ft3E5D; Tue, 05 Nov 2024 18:12:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1730826761;
	bh=LMgmOH81XeEbwarFgE+VQHvyLyS42kYSZhTng6/Mehs=;
	h=Date:From:To:Message-ID:Subject:MIME-Version;
	b=Yx+2aJucakj2XVQBo9rlvnXV0/SUFUw+nc3FfogI8f9VidR3HjQxqHh3w4mrnUG9G
	 zqNmO1IslrO//IWdug/eBsSTnw+TRpxQAzZyivjsB1dKTpssivQppNE7CBxJE2FGnp
	 A0Ar16ZevIpbYq1SX/VpAu1gzNdH65pVUUk8CCSabFc5yQQ1xNE8G9Q0LiRi1egC4s
	 SYCZyN3PW5zMLePKvga2yl0WRobyuHAhdGgaxmKtQsKBlDOXHasimEJf2BbzYhujoo
	 2cSLZPzzxoXfLxYKxO8fX50xJDls7e2ae3GGp4HdIZWg+ZelbnzjyiEB87ekujSSzV
	 0v9YZe4NVu8lQ==
X-ME-Helo: opme11oxa18nd1.op.nd1.pom.fr.intraorange
X-ME-Auth: bW9uaXF1ZS5yb3NzaTBAb3JhbmdlLmZy
X-ME-Date: Tue, 05 Nov 2024 18:12:41 +0100
X-ME-IP: 79.95.87.189
Date: Tue, 5 Nov 2024 18:12:41 +0100 (CET)
From: monique rossi <monique.rossi0@orange.fr>
Reply-To: monique rossi <monique.rossi0@orange.fr>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Message-ID: <502293601.31760355.1730826761066.JavaMail.open-xchange@opme11oxa18nd1.rouen.francetelecom.fr>
Subject: Re: What's cooking in git.git (May 2024, #07; Fri, 17)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium

Bien.recu.et.autoriser
=20
Envoy=C3=A9 depuis l'application Mail Orange
