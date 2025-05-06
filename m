Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC627F4D4
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533526; cv=none; b=SFbMlnd3e74UnHN2iM57eoL5IogLghqXMQ80VrJprMiVhbo9zWzPUjzLqnZHNBH8uJiOh2ZmkQgZQZSW61CpRe2vOFp9bUC8LkcSSnSl8Yd3q6W7NnqYt+KbYvowwOmC3GPiQpR/ykSdgnDVOCCgipiK9IJLOSPO2ZAsOTj4bxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533526; c=relaxed/simple;
	bh=ghfFE3DQYjFRPCXgcGtkNq6QFd4O24F/H8hvdzYo2H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqW2iiWqDiBlGdLIEMfgeoY2LDCKFloujmdmujTDVGUJHr/gkm189h+gsIKtALk/HMR0PTHyTxHP12+0ATKKL+CWVEh87cI8iMWYAUxWzy6dc34sMOk5iCsizcNPyhGlpH2P72APs8QDwKYBX4augw2ZF3kzqvp7lEzHImdnIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=Yr/7kkdw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="Yr/7kkdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746533521; x=1747138321; i=tboegi@web.de;
	bh=xSdv6YkzZ/fGcQYfuOt6GoxFG2No7zv3MCGH90P2JxM=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Yr/7kkdw8lID/LxZuCHVQA3WYH4fT19rNmP1JhHPrulcMdP/Tv9vViDzk6ivczUR
	 DfQgRa2zbt/Pxw34J4OP1ri7q5A79Hn5Rmh1jZSEExFvpWyH4XpnrbjdMQMVbkCT4
	 p6zAHu6oVjcxoIGsbLIX69tPvdaDCBDAAG3lcvebphlqbYbqLQ+XMjZJKcDKHXaza
	 baqBYDBqYbA41kY9SEcSEbQWWq3j9FIWJnezOP64mR1rA4MlgoF6cq1EQPeXmFGMu
	 tWHrD+aqI6Aga7UPXrIu89bwrDZTwPH8B0a2wecyY9ORzBC+L3cHQhL6XNJX+byF2
	 llLeVFAdyr2IkIVKVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([81.231.143.213]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mt8gF-1v0NeL0pOj-00wNQS; Tue, 06 May 2025 14:06:48 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	koji.nakamaru@gree.net
Subject: [PATCH/RFC v1 1/1] intialize false_but_the_compiler_does_not_know_it_
Date: Tue,  6 May 2025 14:06:44 +0200
Message-ID: <20250506120644.186968-1-tboegi@web.de>
X-Mailer: git-send-email 2.49.0.532.g6f84262c44
In-Reply-To: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:65KqnrjU+IpumOUFd2qUu8GVWH9w6ykNZ0089245G7NacrUurRf
 InyiUzqX57pUH5FZliz+KMiyDnNSNbNW5zH8iRONc7QW8UnuKWOoo/Io793lu92ClOVVOUY
 Dcpie9G7J2jfYRrJDG5a1d71JNWWQfIl92UE9ZYGS/XxyfVdA90EpFeyd3PhECrbBnTngTd
 fel3da5XPtzIFktfJ1+8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/tvsWZYWq+I=;yObEUDZ1zMMVVnwQjiFDG300+Lo
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Compiling/linking 82e79c63642c on an older MacOs machine leads to this:
Undefined symbols for architecture x86_64:
  "_false_but_the_compiler_does_not_know_it_", referenced from:
      _start_command in libgit.a(run-command.o)

The linker doesn't seem to pick up the symbol:
"false_but_the_compiler_does_not_know_it_"

Initializing the variable to 0 fixes the problem:
The symbol type changes from 'C' to 'S' and is picked up by the linker.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 compiler-tricks/not-constant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Koji Nakamaru: Thanks for the digging.
This patch fixes the problem here -  as a side note,
the change in Makefile alone doesn't help.


diff --git a/compiler-tricks/not-constant.c b/compiler-tricks/not-constant=
.c
index 1da3ffc2f5..9fb4f275b1 100644
=2D-- a/compiler-tricks/not-constant.c
+++ b/compiler-tricks/not-constant.c
@@ -1,2 +1,2 @@
 #include <git-compat-util.h>
-int false_but_the_compiler_does_not_know_it_;
+int false_but_the_compiler_does_not_know_it_ =3D 0;
=2D-=20
2.39.5

