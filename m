Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6AA41
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="zrRSQoYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=gv5viUOKWipufk/uhbCfmwZemyZ1iro8EzRL6ClZFP0=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=zrRSQoYxNc9MimLqFyITR772VVlp9JdLDy8w79h8U+XK/ATRZm7kG9Qe95r4w1DCUKS4/xS4rs8w
        P7MQUw5D51jypLgGlhI7TRS7GWCO4r/LYsj2IZMjgBoIQ+z52oSTwE3vhPoMJNn/EYvFUyulkC9D
        8C7Mb6KpogTNcWibP0g=
Received: by smtp-relay.sendinblue.com with ESMTP id c9656f53-daa1-4e4e-852c-31997cef6ba5; Tue, 09 January 2024 01:08:34 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA5MDEwODMwLjQ1ODc3NS0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  8 Jan 2024 16:08:29 -0900
Subject: [PATCH v2 0/1] completion: don't complete revs when --no-format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id C412D520263; Mon,  8 Jan 2024 16:08:31 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <c9656f53-daa1-4e4e-852c-31997cef6ba5@smtp-relay.sendinblue.com>
Origin-messageId: <20240109010830.458775-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: CCMSmIR3QDC7lVUfZrzgyguf1_Bbzqbx85uP_HJOtJbrMTa0K6pcNUiY5M6BUu0_Zkitk22EBIK0W87rRFIw8igUUXPpTZQvJ7NmyIPeiGwXsnf0GJJCshctlRMcIowwPWD8hpUvDoB_Na0W1b9AOXgYo1lP-rWMPhmIa--J2IjS
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Improve commit message

Britton Leo Kerin (1):
  completion: don't complete revs when --no-format-patch

 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  ff4d2e55e3 ! 1:  e56dbbacd9 completion: don't comp revs when =
--no-format-patch
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: don't comp revs when --no-format-patch
    +    completion: don't complete revs when --no-format-patch

         In this case the user has specifically said they don't want =
send-email
         to run format-patch so revs aren't valid argument completions (and=
 it's
--
2.43.0


