Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0615EBB
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="BXKnJYTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=SG3s8bSgVUWOdWH5XwKQE+e3iRzwZi1Abooae9PmQzk=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=BXKnJYTg031Yg1y/PsZKnCtdg/oFM7d30EysKzDuDGaZT/U61g5JFVGgrRnI3RDdnEERBy6TpffB
        AAZNO8KssfxojH0WQ+OdefhhuU+/6Tzejl4k1YaSmzIDT69DlnC0Ln6Qhg7lMLwa47Ura68t+TCs
        To/wnDyrDxQIU9uWcHs=
Received: by smtp-relay.sendinblue.com with ESMTP id 6bcbd017-968e-4ac8-a56b-164b163c76d4; Wed, 03 January 2024 04:02:11 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAzMDQwMjA3LjY2MTQxMy0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  2 Jan 2024 19:02:05 -0900
Subject: [PATCH v2 0/2] doc: bisect: change plural paths to singular pathspec
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 824A8520261; Tue,  2 Jan 2024 19:02:09 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com>
References: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <6bcbd017-968e-4ac8-a56b-164b163c76d4@smtp-relay.sendinblue.com>
Origin-messageId: <20240103040207.661413-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: nBHSe4iEMrpiEJ3BxTEoI_lNQAK-lGTc9H_T_-wTKQsRxb4Vx-37dRm3ljd3wzKOJIInkDt0lp_4q36psBheIwkFdMAKUa2tYnu5g7WvuIWD2l9tPpje-qGeNp01SQQYiGAymH5ibUcjZrjBkwx67LktGv3jl-xslZl8-rdjYLUa
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Britton Leo Kerin (2):
  doc: use singular form of repeatable path arg
  doc: refer to pathspec instead of path

 Documentation/git-bisect.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  90c081dcab ! 1:  da40e4736b doc: use singular form of repeatable path =
arg
    @@ Commit message
         later document text mentions 'path' arguments, while it doesn't =
mention
         'paths'.

    -    Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>
    +    Signed-off-by: Britton Leo Kerin <britton.kergin@gmail.com>

      ## Documentation/git-bisect.txt ##
     @@ Documentation/git-bisect.txt: The command takes various subcommands=
, and different options depending
-:  ---------- > 2:  d932b6d501 doc: refer to pathspec instead of path
--
2.43.0


