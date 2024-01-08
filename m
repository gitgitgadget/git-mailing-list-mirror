Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC91170E
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="kpiFOpsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=AoDguTRTtx0EmnmG5xwsDO2AG08VNxVXlbpS45lttRQ=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=kpiFOpsDT6UuxmpVnkU53wWpQYQ3ZxzMYPQtV+8PTEHNKey9APxaB932PW+MBR4+J+Ja7xkA9FW3
        sJfcBsdygW1DZE3VfUPRZC8/RLnk3g7FybxgIR/0xJBeHHwNBZwJ5Y/skSZj4mnOvDE3xsB4BqFV
        hWmJB0PumoVu2oF6ug8=
Received: by smtp-relay.sendinblue.com with ESMTP id 9627364b-c0c9-4b85-a81a-ba1ef0735c9a; Mon, 08 January 2024 09:36:05 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA4MDkzNjAxLjEzNjM3MC0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  8 Jan 2024 00:36:00 -0900
Subject: [PATCH 0/1] completion: send-email: don't complete revs when --no-format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 8CFA0520263; Mon,  8 Jan 2024 00:36:03 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
Origin-messageId: <20240108093601.136370-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: RPv6MoZ8eGngaM4Q2SGm_iZq8iupvC1oxPCUD8hqqD3bX0ukSTsMN5tffJR9nTlbI1faCDJ4y4GT7DMB5TM8hU26DPIlcPpms8SlVEIkgBq_i2ikRjzqVUMcxmihMZYnO-9jrdfr9fatmUmmOqkBeIo0nziZmn8iBY3lFkhAtDz5
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Along the way I taught =5F=5Fgit=5Ffind=5Flast=5Fon=5Fcmdline to understand=
 '--', which
isn't stricly necessary but I think reads more clearly at the call sites.
=5F=5Fgit=5Ffind=5Fon=5Fcmdline could be changed to work the same, or this =
part dropped
if people don't like it.

Britton Leo Kerin (1):
  completion: don't comp revs when --no-format-patch

 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--
2.43.0


