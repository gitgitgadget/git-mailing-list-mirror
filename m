From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] i18n: remote: add comment for translators
Date: Sun,  8 May 2016 20:00:18 +0000
Message-ID: <1462737618-32228-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Ray Chen <oldsharp@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Changwoo Ryu <cwryu@debian.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
	<vnwildman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 22:00:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azUsl-0007AT-7X
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 22:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbcEHUAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 16:00:33 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:52567 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750999AbcEHUAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 16:00:31 -0400
Received: (qmail 3082 invoked from network); 8 May 2016 20:00:29 -0000
Received: (qmail 28031 invoked from network); 8 May 2016 20:00:29 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 20:00:28 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293977>

Add comment drawing translator attention in order to align "Push
URL:" and "Fetch URL:" fields translation of git remote show output.

Aligning both fields makes the output more appealing and easier to
grasp.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---

Translators, you can check if your translation does align these
fields by issuing, for instance

$ git remote show -n origin
* remote origin
  Fetch URL: https://github.com/git/git.git
  Push  URL: https://github.com/git/git.git
<snip>

I know Portuguese translation align these fields. I know that French
and Deutsch translations don't, but don't know about others.

Obviously, this detail is not important, but now you know about it.

 builtin/remote.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index fda5c2e..d33766b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1154,6 +1154,8 @@ static int show(int argc, const char **argv)
 			url_nr = states.remote->url_nr;
 		}
 		for (i = 0; i < url_nr; i++)
+			/* TRANSLATORS: the colon ':' should align with
+			   the one in "  Fetch URL: %s" translation */
 			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
 			printf_ln(_("  Push  URL: %s"), "(no URL)");
-- 
2.7.3
