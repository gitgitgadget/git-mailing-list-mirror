Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2F14A81
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=talbot.audio header.i=@talbot.audio header.b="uo8vzjoC"
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 03:43:16 PDT
Received: from mx.tedomum.net (mx.tedomum.net [51.255.128.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3875D78
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 03:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=talbot.audio;
	s=dkim; t=1698057417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hKEq0gaNMki5GBHUDL+yI+QiTnqZrbl9FyDJSKQphlc=;
	b=uo8vzjoCh4AC+xozMyIc6pMftzuyHXGzt8MBgTJbY0cl2RUWkRiJueifgwOiDeOPBHvZzv
	n3aj909q7VR92KzVTsi2/XAE1Nl811kZx9SxicKUttHFeOQBv4tq+ksn78N7WKDRuCVsOY
	lwnSGleRG8pIiKJMG+m93irO24lGQlU=
Authentication-Results: mx.tedomum.net;
	auth=pass smtp.mailfrom=matthieu@talbot.audio
Date: Mon, 23 Oct 2023 10:36:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: matthieu@talbot.audio
Message-ID: <9a72287d979a0bd9dce390478d8522139646fb4e@talbot.audio>
TLS-Required: No
Subject: malformed commit messages for git version 2.42.0 when "commit.verbose
 true"
To: git@vger.kernel.org
X-Spamd-Bar: /

Hello,

I recently set the option `commit.verbose` to `true` for git version 2.42=
.0, and I really like it.

However, most of the time, commits are malformed if I don=E2=80=99t remov=
e the diff after the marker=20
`#=20------------------------ >8 ------------------------`

I would expect that anything after the marker is automatically removed by=
 git, or could it be that some pre-commit script see the raw commit messa=
ge before it is cleaned-up by git itself?

Best,
Matthieu
