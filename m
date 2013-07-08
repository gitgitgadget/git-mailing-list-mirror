From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] fixup! git-remote-mediawiki: New git bin-wrapper for developement
Date: Mon,  8 Jul 2013 15:30:41 +0200
Message-ID: <1373290241-10517-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAETqRCh0_gc_MqN5eXLn_guCELYKgfHdN3986d9WPubxUFeLqQ@mail.gmail.com>
Cc: benoit.person@ensimag.fr, celestin.matte@ensimag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 08 15:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBWw-0001Wj-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab3GHNa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:30:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57662 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab3GHNa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:30:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r68DUjs7020846
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Jul 2013 15:30:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UwBWh-0006NI-8O; Mon, 08 Jul 2013 15:30:47 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UwBWg-0002m3-Tc; Mon, 08 Jul 2013 15:30:46 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <CAETqRCh0_gc_MqN5eXLn_guCELYKgfHdN3986d9WPubxUFeLqQ@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jul 2013 15:30:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r68DUjs7020846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1373895047.57104@mIMi8ZPzfx8gtI5az1uXFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229851>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> > The colon after "make" and the indentation look weird. Shouldn't this be
> >
> > +# To build and test:
> > +#
> > +#   make
> > +#   bin-wrapper/git mw preview Some_page.mw
> > +#   bin-wrapper/git clone mediawiki::http://example.com/wiki/
> > +#
> >
> > ?
> 
> oops, yes definitely.

Junio, can you apply this fixup to bp/mediawiki-preview?

Thanks,

 contrib/mw-to-git/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 775cb07..76fcd4d 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -4,9 +4,9 @@
 #
 # To build and test:
 #
-#   make:
-#     bin-wrapper/git mw preview Some_page.mw
-#     bin-wrapper/git clone mediawiki::http://example.com/wiki/
+#   make
+#   bin-wrapper/git mw preview Some_page.mw
+#   bin-wrapper/git clone mediawiki::http://example.com/wiki/
 #
 # To install, run Git's toplevel 'make install' then run:
 #
-- 
1.8.3.1.495.g13f33cf.dirty
