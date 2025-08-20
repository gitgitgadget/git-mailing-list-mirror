Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3921CA0C
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669006; cv=none; b=HNZCqBx6ihv5u+jTxRP6UkAhC0vh8PueXc5+ohFv7uyoJQH3P01XveA4VOqHqd89/YvgSTrEvJakuuqANU67JrVPawW3M8iNthe6rqMi/BD8VgIeJkcXUubp4f7XAfDxlE9JmI1GlKBUfyljwcSC106Fa+GBRWB/hiRbswXwYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669006; c=relaxed/simple;
	bh=m8REl53eZv/CF3RV5vIubqSoJab8MHO8+zQsQBuZDxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fnK6gq3coy2RYBzr9iirjIrBZx26CvI5vkT/SK4AM3HK/Dq0e/5QxDw1rTve/j7rpzvQ+3zl2AlsIeiB3JJ0c0PIDXP2uWn57gd3GTOVirOkwK4Y0W3w+nMUgpl5MeHWAD8miDUeKEIb9p3dEuAajif9YDxTPfKMNfaABxBrN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4c6FsQ4scLz7Qq9F
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:50:02 +0200 (CEST)
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4c6FsG1B6JzRmx2;
	Wed, 20 Aug 2025 07:49:53 +0200 (CEST)
Message-ID: <77fd0332-cc46-44b5-bbf2-94f326d5d754@kdbg.org>
Date: Wed, 20 Aug 2025 07:49:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] doc/gitk: update reference to the external project
To: git@vger.kernel.org
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20250819-b4-pks-meson-tcl-tk-v1-2-6bcaff0bc0a0@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-2-6bcaff0bc0a0@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gitk is now maintained by Johannes Sixt and the repository can be
cloned from a new URL. b59358100c20 (Update the official repo of
gitk, 2024-12-24) could have updated this instance in the manual,
too, but the opportunity was missed. Update it now.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---

Am 19.08.25 um 10:18 schrieb Patrick Steinhardt:
> +++ b/Documentation/SubmittingPatches

> -- `gitk-git/` comes from the gitk project, maintained by Johannes Sixt:
> +- `subprojects/gitk/` comes from the gitk project, maintained by Johannes Sixt:
>  
>  	https://github.com/j6t/gitk

> +++ b/Documentation/gitk.adoc

> -gitk-git/ comes from Paul Mackerras's gitk project:
> +subprojects/gitk/ comes from Paul Mackerras's gitk project:
>  
>  	git://ozlabs.org/~paulus/gitk
Let's fix this outdated reference!

 Documentation/gitk.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitk.adoc b/Documentation/gitk.adoc
index 58ce40ddb1..33a5648ab8 100644
--- a/Documentation/gitk.adoc
+++ b/Documentation/gitk.adoc
@@ -170,9 +170,9 @@ tcl/tk.
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

