From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/11] completion: bash: remove zsh wrapper
Date: Thu, 19 May 2016 23:58:37 -0500
Message-ID: <1463720325-8853-4-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWU-0001VM-7c
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbcETE6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36009 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbcETE6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id g16so7294510oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8r06kjR0m6TsvMLtJJ3kaZIZkbAC74g2BbHF4LBqtM=;
        b=GoktOgy3ihbjHx9YiH4wmEP6Ftx55bUWn4UXyn49d+HKC3rhAUK0UCBRrjnIhDOuRC
         Sn/zCGlXMc1+u/rBGjyXzFgnqmp2Xa8NZqPzMbpuilotJkIRy7yhsFIH3I/rG9/oI60L
         tr4Mo7EtN02z2kjkjdaL/Ge5v5/OHHNOn1wXZlL0vO2l+2VQ1G9bKreVu9/tpkU5Qo1G
         q/q7gp4FzLXBMqGfCCQRMl/sPPLr7JCt/3PJKVg9nLWgfC42WYtvqjXPeovMJjF+xrlF
         2CtDGmdKBBbzHX1Jyqmv59bhwCic4NNhS3c+K8B4queQqQAp9zcYzR4nkwGtoy0XzZQz
         alig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8r06kjR0m6TsvMLtJJ3kaZIZkbAC74g2BbHF4LBqtM=;
        b=GyhmORisXiMdG1k9UHQpCLlu0wZoyZGcFWD4fTfiIT+aU071E5erxbkyArWHC7Ly3W
         sPJa3KMgf5LSlTGHEwsfjZuufx2OeJHQ32ulwov3ob22BBS93Hdbk5J4IR5SXfS9owzs
         L3u13hAigCBOPYb3g0RXjVjfjsNqyvx/ikYjEcJ+cmcSKlTqsDTWzQzeLU+NwR4cX6Ov
         3fB/+jv82tf8K3HlOXuM4uWVOXF0MDKxhn8Otp+VzO+Y6imYAwBDsu/tXLitZYopDKC7
         +SUmfZJg21ZvkoLHPBLnPCt6Fs0M4f2Bl/Mjmpx+e7WAWUc79K1aC9yzFn+AGQ6Xhszj
         CB2g==
X-Gm-Message-State: AOPr4FUY4DsB2JsCnHc5ALoSsXGloLa0dczDt/TE7otH+oOstKmyjJ+8ikndg9bWNWWj5g==
X-Received: by 10.157.17.27 with SMTP id g27mr629333ote.40.1463720329180;
        Thu, 19 May 2016 21:58:49 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id dl17sm5007047obc.9.2016.05.19.21.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295138>

It has been deprecated for more than three years. It's time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 64 ----------------------------------
 1 file changed, 64 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5e2e590..9cbae6f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2672,70 +2672,6 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]]; then
-	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
-
-	autoload -U +X compinit && compinit
-
-	__gitcomp ()
-	{
-		emulate -L zsh
-
-		local cur_="${3-$cur}"
-
-		case "$cur_" in
-		--*=)
-			;;
-		*)
-			local c IFS=$' \t\n'
-			local -a array
-			for c in ${=1}; do
-				c="$c${4-}"
-				case $c in
-				--*=*|*.) ;;
-				*) c="$c " ;;
-				esac
-				array[${#array[@]}+1]="$c"
-			done
-			compset -P '*[=:]'
-			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-			;;
-		esac
-	}
-
-	__gitcomp_nl ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
-	}
-
-	_git ()
-	{
-		local _ret=1 cur cword prev
-		cur=${words[CURRENT]}
-		prev=${words[CURRENT-1]}
-		let cword=CURRENT-1
-		emulate ksh -c __${service}_main
-		let _ret && _default && _ret=0
-		return _ret
-	}
-
-	compdef _git git gitk
-	return
-fi
-
 __git_func_wrap ()
 {
 	local cur words cword prev
-- 
2.8.0+fc1
