From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: better language for 2 strings
Date: Fri, 18 Sep 2015 10:48:08 +0200
Message-ID: <20150918084808.GA10616@ralf-ubuntu>
References: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 10:48:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcrLB-00032l-P4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbIRIsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 04:48:14 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37661 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbbIRIsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 04:48:11 -0400
Received: by wicfx3 with SMTP id fx3so21738217wic.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=P8wT30T0U82QVvVKtxhVShGQGUnQmO0Eq6QzM7oD1iI=;
        b=HH55pumjMarztA3q4+O1DKY2Fvtu4VZp17mhrGGI9YMQjZFLI/l/TgI9+FXI7qoDpF
         olPygzYs9bUctnrdOtii3i0FAq8sFPkX7yQsV7Toj6rnr3X8L+LWULoqDhYFlZkXLZhx
         r8yeCIVGIAXvv5j5cuKyDFOZva8vLYxJUqgMRheK2wScq7zwugmTUuHIWkVLFDT2J3yC
         vaxhTKxwsWl865kphBvmbvvX0zPYcO9BN973r0VOEyLIyQz0Cv98XVNAc4ajbO4t15c3
         fpNQTX93GnlZ9JFdjmYFnbXexCdauPd2O5o9KclQJ/fuA+pVd4zDUrJ2RJCpxXjPhYeU
         Ppxg==
X-Received: by 10.194.86.161 with SMTP id q1mr6084091wjz.18.1442566090251;
        Fri, 18 Sep 2015 01:48:10 -0700 (PDT)
Received: from localhost (cable-94-139-2-197.cust.telecolumbus.net. [94.139.2.197])
        by smtp.gmail.com with ESMTPSA id z2sm14363997wij.1.2015.09.18.01.48.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 18 Sep 2015 01:48:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278185>

Phillip Sz <phillip.szelat@gmail.com> wrote:
> just 2 strings I think we could translate better.

Thanks!

> 
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
>  #: git-am.sh:512
>  msgid "Please make up your mind. --skip or --abort?"
> -msgstr "Bitte werden Sie sich klar. --skip oder --abort?"
> +msgstr "Bitte entscheiden Sie sich. --skip oder --abort?"
>  

This string has been removed in 40147ec (l10n: de.po: translate 123
new messages), so I've updated the commit accordingly.

-- >% --
From: Phillip Sz <phillip.szelat@gmail.com>
Date: Thu, 17 Sep 2015 17:50:32 +0200
Subject: [PATCH] l10n: de.po: better language for one string

Just one string I think we could translate better.

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index c9b4d16..c682aaf 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2733,7 +2733,7 @@ msgid ""
 "it will be removed. Please do not use it anymore."
 msgstr ""
 "Die -b/--binary Option hat seit Langem keinen Effekt und wird\n"
-"entfernt. Bitte nicht mehr verwenden."
+"entfernt. Bitte verwenden Sie diese nicht mehr."
 
 #: builtin/am.c:2329
 msgid "failed to read the index"
