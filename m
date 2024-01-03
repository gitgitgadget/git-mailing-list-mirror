Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064016411
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="uukUjv/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=m/xJD2SIWV8ySnclO+fozbEXC5SOCelzImJ0OsOH1jc=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=uukUjv/JnWr8t4zfoYuvPY0bCQbDnxKMr7Q62RNIPLtQFXR0QwJiqYuCsdKrsJGLHl1KrxTknIiF
        4gD5nBBQAQYMoTaBhCimDml0pHsuuxnAyN//3e0F6H8PfIEOIkcau9h0Xrn2EUH83j/wdj3Wq2CL
        t/nyo5Y2C/X7xt4ZD6s=
Received: by smtp-relay.sendinblue.com with ESMTP id 95ced208-fa2d-4e0f-9887-7c861db598b3; Wed, 03 January 2024 04:02:11 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAzMDQwMjA3LjY2MTQxMy0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  2 Jan 2024 19:02:06 -0900
Subject: [PATCH v2 1/2] doc: use singular form of repeatable path arg
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 85EF1520263; Tue,  2 Jan 2024 19:02:09 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>, Britton Leo Kerin <britton.kergin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103040207.661413-1-britton.kerin@gmail.com>
References: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com> <20240103040207.661413-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <95ced208-fa2d-4e0f-9887-7c861db598b3@smtp-relay.sendinblue.com>
Origin-messageId: <20240103040207.661413-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: bCK_sTG09krmI5MJuZPut5_b9cdhwVNzMFxHPo-5vEsKTXmzNlh_cCQf75st8cyRc8JWmvHZNannoA8eD9Ii7uTB05YokR3CsKBkKgUT_UkhrYezTic9kJTBvAlUeru4jKOKcXrCLS9cnCJ1J_jFO6e_xIxeYNJw7XoGIKZt694-
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

This is more correct because the <path>... doc syntax already indicates
that the arg is =22array-type=22.  It's how other tools do it.  Finally, =
the
later document text mentions 'path' arguments, while it doesn't mention
'paths'.

Signed-off-by: Britton Leo Kerin <britton.kergin@gmail.com>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index aa02e46224..b798282788 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different =
options depending
 on the subcommand:
=20
  git bisect start [--term-(new|bad)=3D<term-new> --term-(old|good)=3D<term=
-old>]
-		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...=
]
+		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<path>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
  git bisect terms [--term-good | --term-bad]
--=20
2.43.0


