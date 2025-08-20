Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FD1494A8
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670578; cv=none; b=QaNGyP0UGuQ2RVwLEmJC6Udr6S5NqXXxdLZIzgJTsP+TbLx0qU5Rp4recmF1SlyDLAD+MY1hibx9y/ANZQeiV2qYTzqFJI+8p9bq32hNwh6uM2EbKEDnZ0SqfYkbnt1PJREyXstvdIpfsoe2HzhGI3eqwo1SgFyghltP6L1Vsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670578; c=relaxed/simple;
	bh=20EsLThFLmOzqA6jPQsF+b+5hoYVv63kgyNTMhAE4F4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a9MdMjL43rj77w/r6OafRmmioa3tETOFJH9xFltgdJuY7AI7taeMEcc8V+Abb/HRFypz63uXkZ3dA3IdBu0dFGdMquAh+EhazlhY8RJpy8u6QL7fifA4fy2dxXoEGgc12vQHZr6rlrGAhw755fMwztkjBjqjZT7xGKUItMErb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4c6GRf62sYz7QhcX
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 08:16:14 +0200 (CEST)
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4c6GRT5YZ2zRnmF;
	Wed, 20 Aug 2025 08:16:05 +0200 (CEST)
Message-ID: <249056e7-1332-4e6f-8d07-16c80fd4913e@kdbg.org>
Date: Wed, 20 Aug 2025 08:16:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] doc/gitk: update reference to the external project
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20250819-b4-pks-meson-tcl-tk-v1-2-6bcaff0bc0a0@pks.im>
 <77fd0332-cc46-44b5-bbf2-94f326d5d754@kdbg.org>
In-Reply-To: <77fd0332-cc46-44b5-bbf2-94f326d5d754@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gitk is now maintained by Johannes Sixt and the repository can be
cloned from a new URL. b59358100c20 (Update the official repo of
gitk, 2024-12-24) could have updated this instance in the manual,
too, but the opportunity was missed. Update it now. Do give credit
to Paul Mackerras as the inventor of the program.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I just noticed that I would have removed the last user-visible
 mention of Paul. Don't do that.

 Documentation/gitk.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitk.adoc b/Documentation/gitk.adoc
index 58ce40ddb1..5b34dcd077 100644
--- a/Documentation/gitk.adoc
+++ b/Documentation/gitk.adoc
@@ -163,16 +163,16 @@ used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
 
 History
 -------
-Gitk was the first graphical repository browser. It's written in
-tcl/tk.
+Gitk was the first graphical repository browser, written by
+Paul Mackerras in Tcl/Tk.
 
 'gitk' is actually maintained as an independent project, but stable
 versions are distributed as part of the Git suite for the convenience
 of end users.
 
-gitk-git/ comes from Paul Mackerras's gitk project:
+`gitk-git/` comes from Johannes Sixt's gitk project:
 
-	git://ozlabs.org/~paulus/gitk
+	https://github.com/j6t/gitk
 
 SEE ALSO
 --------
-- 
2.51.0.205.g9a02ae2892

1:  5a2ed392c1 ! 1:  48668308f7 doc/gitk: update reference to the external project
    @@ Commit message
         Gitk is now maintained by Johannes Sixt and the repository can be
         cloned from a new URL. b59358100c20 (Update the official repo of
         gitk, 2024-12-24) could have updated this instance in the manual,
    -    too, but the opportunity was missed. Update it now.
    +    too, but the opportunity was missed. Update it now. Do give credit
    +    to Paul Mackerras as the inventor of the program.
     
         Signed-off-by: Johannes Sixt <j6t@kdbg.org>
     
      ## Documentation/gitk.adoc ##
    -@@ Documentation/gitk.adoc: tcl/tk.
    +@@ Documentation/gitk.adoc: used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
    + 
    + History
    + -------
    +-Gitk was the first graphical repository browser. It's written in
    +-tcl/tk.
    ++Gitk was the first graphical repository browser, written by
    ++Paul Mackerras in Tcl/Tk.
    + 
    + 'gitk' is actually maintained as an independent project, but stable
      versions are distributed as part of the Git suite for the convenience
      of end users.
      
