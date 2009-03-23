From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] completion: add --annotate option to send-email
Date: Mon, 23 Mar 2009 03:26:49 -0700
Message-ID: <1237804011-15419-2-git-send-email-bebarino@gmail.com>
References: <1237804011-15419-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:28:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhOT-0003Bn-F0
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbZCWK1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZCWK1A
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:27:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:24659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbZCWK07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:26:59 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1443082wah.21
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ja5fXufQB+Udl/SKtMNaJ2TOkboTvU376KeciVANBuI=;
        b=Tx8ZjPFE56q9WTXXX4dhBUnHEBGCaxUk7DC48fS8A1TLHg+A5G6YjavCD6zw4/8+WF
         4AqnFo811qdIX00dErkhjKeQEQjzXKBn3XyXYP6l/VYtHQ7oCm/V6QwodZJshZTDQQvw
         UBKDCThWr6NVZeqFWmbuvZ82QtjMsgQAcNn7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xLNSEkO5GB594dkmqJUy3AFbqZn++ULREyG3CcyVz3ROmbMerzb0pfBS9awDgpX/Dj
         UkV86CdRhREqOq2UOwqjvPwBxp9tUWeloVJ+VKNH4VdnuwBjDritu+/RNi2a17o4yJpm
         QLDNGKPwDHlLt3CikbloF2i2rNSSZrcZm+KWg=
Received: by 10.114.159.5 with SMTP id h5mr4698970wae.36.1237804017115;
        Mon, 23 Mar 2009 03:26:57 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id t1sm21155072poh.21.2009.03.23.03.26.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:26:56 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 23 Mar 2009 03:26:54 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237804011-15419-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114272>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 10e36a7..8719242 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1264,8 +1264,8 @@ _git_send_email ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--bcc --cc --cc-cmd --chain-reply-to --compose
-			--dry-run --envelope-sender --from --identity
+		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
+			--compose --dry-run --envelope-sender --from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
 			--no-suppress-from --no-thread --quiet
 			--signed-off-by-cc --smtp-pass --smtp-server
-- 
1.6.2
