Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D543AA3
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="RbXvTwct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=pe6qb0ymNUWBZZTVAy2VRQJ05hNY8zW8Tw9Ddlam0NQ=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=RbXvTwctKidLoLmPHyNLdsh86KYRlDNUDMlYgOANy7UxKdmT20GpbIlS27znaa6ryxICM2M1IS8V
        Eh7DxmOJPSJqWxRwlE7vQXxIXoWVSXA1pipYSS+qXw+8D33oV7l0Y2CzcOHZXVelxYLoHG6svqsQ
        GRGTsjJGJ+1zC4o2mxY=
Received: by smtp-relay.sendinblue.com with ESMTP id 3d46bca1-96d4-43ba-a912-1f7c76942287; Wed, 27 December 2023 20:53:59 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjMxMjI3MjA1MzQwLjk4ODYtMi1icml0dG9uLmtlcmluQGdtYWlsLmNvbT5%2BYWEuZC5zZW5kZXItc2liLmNvbQ%3D%3D
Date: Wed, 27 Dec 2023 11:53:40 -0900
Subject: [PATCH 1/1] doc: use singular form of repeatable path arg
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id ECCF952025D; Wed, 27 Dec 2023 11:53:57 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>, Britton L Kerin <britton.kergin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227205340.9886-1-britton.kerin@gmail.com>
References: <20231227205340.9886-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <3d46bca1-96d4-43ba-a912-1f7c76942287@smtp-relay.sendinblue.com>
Origin-messageId: <20231227205340.9886-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: o3RpLhf61emQtBJt183eX-22IAWemXd-OrSvYK1LBe6rz9-rTzhTbkIeIxSLKqUTQ_CmKzN5FUi1zVkzInoOqbctJT1WTnQsQDVjS-aflL_OPdk51PY-POhI2okRyumAGerDC14wpNWiKxfbNXwCGpE0MUFTZgVKvKkjE4oEt0kM
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

This is more correct because the <path>... doc syntax already indicates
that the arg is =22array-type=22.  It's how other tools do it.  Finally, =
the
later document text mentions 'path' arguments, while it doesn't mention
'paths'.

Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 191b4a42b6..58821f7e11 100644
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


