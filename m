From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH V2 2/5] contrib/completion: --line-number to git grep
Date: Thu,  5 May 2011 00:00:18 +0200
Message-ID: <1304546421-25439-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHk8F-0002W3-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab1EDWBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:01:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53302 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1EDWBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:01:11 -0400
Received: by wya21 with SMTP id 21so1189562wya.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4qsleFTerXlQLvvPQpvBE7BgCgBoz+dqhnfReSRcFzM=;
        b=w9FYlbShyWR+3x52YeOqOoxVAk8+ifRFGiSaslXt3j9Jg6a0PT9+Ad7lGoN1ohXAbZ
         uroeeZPYpHv2PZVE/EnTPsqgj19gyLvvb5B4E5RsfgHHDI+yv0/QSDlh27idt1mNiuMe
         ftww4pIkKw/Ls1zd7yJIqr5t3BopPRwWiUMnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=isD9j4Nr91G9Rx8WWbx4yI/Cv2pFBuzl50nb0hE4/ot/igVbaXFg7MduALXLSxe0Rs
         d51JaEH5yYSEiTe4zxYPCYq9ZlC0UsRkgAUBueRAFZ3NMNbrfxtUfJB28t378jmOG7nt
         PBYtobrd5h5RHd0/NrTDvRD5xonUFmWGe685Q=
Received: by 10.217.7.70 with SMTP id z48mr5517601wes.57.1304546470645;
        Wed, 04 May 2011 15:01:10 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id f30sm802068wef.7.2011.05.04.15.01.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 15:01:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172774>

Commit 7d6cb10b ("grep: Add the option '--line-number'", 2011-03-28)
introduced the --line-number option, but did not add it to
bash-completion.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0df356d..4b2654d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1485,7 +1485,7 @@ _git_grep ()
 		__gitcomp "
 			--cached
 			--text --ignore-case --word-regexp --invert-match
-			--full-name
+			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
 			--files-with-matches --name-only
 			--files-without-match
--=20
1.7.3.4
