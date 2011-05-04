From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH V2 1/5] Documentation: Add --line-number to git-grep synopsis
Date: Thu,  5 May 2011 00:00:17 +0200
Message-ID: <1304546421-25439-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:01:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHk88-0002Rp-8f
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab1EDWBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:01:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33565 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1EDWBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:01:05 -0400
Received: by wwa36 with SMTP id 36so1707354wwa.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GNLTwVriVEoBfxBvekMTaj2jsarQVk4P1xoF3g2VJPA=;
        b=CpLmL/Oewn0PY0faaXQtH6/5XfvgmTA80zr0GQ6UveBUEYvxd9upiqOZTbamvT/B9V
         0toCWpDvhGq2hrHi8Q73SajAbYQIpx7f/RaRRk13HOrOHkmtwHuZkXd9wJInOatioIfX
         Wk8CHcxW9yS4C0c4O4tsGd0SdjeqW9lni3SlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jddPblNTVvNlAjTgQHqTTiQOuOOnBko3LeopM/Ks6xJUOXTV4NGYip1C+MGjvJGpfY
         ZVIIgztNmUwM8NiPXuhvrADbd9hjFRZMKdzI3mSSjU0GHtYsrWDv8AJL/Le8Gm8LnYV0
         4jRixLK9Aj7/wxNbC52O67Hw5I6EvN30XBSqs=
Received: by 10.216.237.138 with SMTP id y10mr6027343weq.30.1304546463997;
        Wed, 04 May 2011 15:01:03 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id x13sm490345wby.42.2011.05.04.15.01.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 15:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172773>

Commit 7d6cb10b ("grep: Add the option '--line-number'", 2011-03-28)
introduced the --line-number option and added its description to OPTION=
S
section, but forgot to update SYNOPSIS.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-grep.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d7523b3..4a58378 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp=
]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
-	   [-F | --fixed-strings] [-n]
+	   [-F | --fixed-strings] [-n | --line-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
--=20
1.7.3.4
