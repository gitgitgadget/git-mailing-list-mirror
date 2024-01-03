Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3816406
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="W136c9BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=c15RccYh81ZRQXfyCIGTCJ0GYZB+4qqVBVXEZmXhLHQ=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=W136c9BC+sP/J7IMcqwCS1Li2qfMEdwEnm1qNKMydiLdklQ7elpK0y9QRVcM6jadsayU+PyaMh5N
        xyn9rAXev51KT53twKOBMK+wpRtV3DpXhSQN+i7SJhbOF3QH2pcexUFQ1A3i+FeHK63/+tXImbXZ
        bm53qgRksKz9tnlEEQ0=
Received: by smtp-relay.sendinblue.com with ESMTP id ff15fe5d-9877-46c4-bb09-33267bdc64e2; Wed, 03 January 2024 04:02:11 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAzMDQwMjA3LjY2MTQxMy0zLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  2 Jan 2024 19:02:07 -0900
Subject: [PATCH v2 2/2] doc: refer to pathspec instead of path
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 8958A520264; Tue,  2 Jan 2024 19:02:09 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
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
Message-Id: <ff15fe5d-9877-46c4-bb09-33267bdc64e2@smtp-relay.sendinblue.com>
Origin-messageId: <20240103040207.661413-3-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: M6uRgFS9c1GkG4b0v2Xxv25aPNhRvkC4ZEQnsK2BPlTxX29CME5Ne3XjrqxZKHeQFEUBOZnEpPWOnptzBqKGVcCfmy1XwdE__l0SKTTCLmov3FXEKu5ICYaMUjxnKlZ45WAE2zqt_yOVqhDrZAhHE2ijLTMvHstsYNRU_BUeOtml
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 Documentation/git-bisect.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index b798282788..8e01f1d618 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different =
options depending
 on the subcommand:
=20
  git bisect start [--term-(new|bad)=3D<term-new> --term-(old|good)=3D<term=
-old>]
-		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<path>...]
+		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>.=
..]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
  git bisect terms [--term-good | --term-bad]
@@ -299,7 +299,7 @@ Cutting down bisection by giving more parameters to =
bisect start
=20
 You can further cut down the number of trials, if you know what part of
 the tree is involved in the problem you are tracking down, by specifying
-path parameters when issuing the `bisect start` command:
+pathspec parameters when issuing the `bisect start` command:
=20
 ------------
 $ git bisect start -- arch/i386 include/asm-i386
--=20
2.43.0


