Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1B11721
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="N8ULdz5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=46B5kKX7tDku3lynTr4j2gN4vG/vn+ZHk9yBMDfEjuM=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=N8ULdz5M0PpFCaolgQ3eI7lz0lURsG6D3ZTQPJmOLdDYB8lmmXV9QeZbQR2DF9EFKYYiwlGT6myX
        s0qiqUx+v/uofMLs73ymHzAogLfy9upobzZ4uaH8bZ8B69fe1VhzK2CDA5bCplpr4N1BX2FNu2J0
        DLZKxhzh1DeqqpJy2ag=
Received: by smtp-relay.sendinblue.com with ESMTP id 4714b88d-df5b-4e37-a5d7-af5033cfb861; Sun, 07 January 2024 21:42:03 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA3MjE0MjAwLjI5Njg0LTEtYnJpdHRvbi5rZXJpbkBnbWFpbC5jb20%2BfmFhLmQuc2VuZGVyLXNpYi5jb20%3D
Date: Sun,  7 Jan 2024 12:41:59 -0900
Subject: [PATCH 0/1] completion: complete dir-type option args to am, format_patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id AAB98520263; Sun,  7 Jan 2024 12:42:01 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
Origin-messageId: <20240107214200.29684-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: 4FUdWW9JWOX1H1RQkMs33Widlpj8uUxDUQlaxyY6FZZOWh7DDk7bttTmCQq1HRuu-ogOrBizo3gqGyrtkJV96MgACBlpbanyq3cX9lIUYtyKtmYl8u3abBKLn57Cde1RIr5OjTEUi6wvukMyVqrzKRpjWUJhs-c_i5Qhj-WZRh_l
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

I think are a few other places this could be done as well but I wanted to
start with just a couple to show the idea.

Britton Leo Kerin (1):
  completion: dir-type optargs for am, format-patch

 contrib/completion/git-completion.bash | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--
2.43.0


