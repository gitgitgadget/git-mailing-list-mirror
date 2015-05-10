From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: change error message from "sagen" to
 "Meinten Sie"
Date: Sun, 10 May 2015 10:02:38 +0200
Message-ID: <20150510080238.GA4955@ralf-ubuntu>
References: <1431170935-6027-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 10:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrMCU-0003X9-G8
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 10:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbEJICs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 04:02:48 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36142 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbEJICq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 04:02:46 -0400
Received: by wizk4 with SMTP id k4so72468707wiz.1
        for <git@vger.kernel.org>; Sun, 10 May 2015 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kSsabpLCzt9wmgDkCqxID+3Jc0acfoJWTzjdW/zmYpg=;
        b=Cj9T+o8f1/wQ7MC6q6IZRM5K7VVwjOlHcg2C2rx3bskDG/Vd/Znx93N+y7BElfipU5
         WnBs5LXEvWweTiEJC7TAZTxoISB+2zqMp7Y+XTL0KKUU7wlOdIj20BAf6eBYxxaCd4xM
         krq3uqTAQ3qe/29DRr4YhPzliCq+rotGNh0JJI88x5YEWf7N2VOgq6fiPNaTICoFCLZC
         K1fWDE4hdX88laE9CTy7assW5cLiF5Mcda4/sLAF0AOT9/HAkulfS6FbYmQhjvB6UUj6
         8vGRGyETmAKs732/RNUYhwENTE3OVbL5+826dwG0w74oN6aCaq/0TCsqilu+ofoMlavK
         A1Dg==
X-Received: by 10.194.22.40 with SMTP id a8mr10542660wjf.134.1431244959791;
        Sun, 10 May 2015 01:02:39 -0700 (PDT)
Received: from localhost (dslb-092-078-236-214.092.078.pools.vodafone-ip.de. [92.78.236.214])
        by mx.google.com with ESMTPSA id df1sm7368327wib.12.2015.05.10.01.02.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 May 2015 01:02:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431170935-6027-1-git-send-email-phillip.szelat@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268726>

Phillip Sz <phillip.szelat@gmail.com> wrote:
> Hi,
>=20
> I think we should not use "sagen" if someone has written something wr=
ong.
> Although it's "say" in English I think we should not use it in German=
 and instead use our normal error message.
>=20
> Phillip
>=20
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>

Thanks. I've changed the commit message a bit.

-- >8 --

=46rom: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n: de.po: change error message from "sagen" to "Mei=
nten
 Sie"

We should not use "sagen" if someone has written something wrong.
Although it's "say" in English, we should not use it in German
and instead use our normal error message.

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 2feaec1..a435da0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2183,7 +2183,7 @@ msgstr "Nichts spezifiziert, nichts hinzugef=FCgt=
=2E\n"
 #: builtin/add.c:358
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
-msgstr "Wollten Sie vielleicht 'git add .' sagen?\n"
+msgstr "Meinten Sie vielleicht 'git add .'?\n"
=20
 #: builtin/add.c:363 builtin/check-ignore.c:172 builtin/clean.c:920
 #: builtin/commit.c:335 builtin/mv.c:130 builtin/reset.c:235 builtin/r=
m.c:299
--=20
2.4.0.228.gc627b12
