From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Improve --patch option documentation in git-add (updated patch)
Date: Tue, 15 Sep 2009 08:35:42 +0300
Organization: Private
Message-ID: <87fxaolqhd.fsf_-_@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	<87ab0zny27.fsf_-_@jondo.cante.net>
	<237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
	<87vdjnlywo.fsf@jondo.cante.net>
	<BLU0-SMTP18292B09CCFD873F4A6DF6AEE40@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Sep 15 07:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnQho-0004gq-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 07:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZIOFfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZIOFfr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 01:35:47 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45013 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZIOFfq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 01:35:46 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 81C8C18CF41;
	Tue, 15 Sep 2009 08:35:48 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A003D97DF8A; Tue, 15 Sep 2009 08:35:48 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 7372F4030;
	Tue, 15 Sep 2009 08:35:43 +0300 (EEST)
In-Reply-To: <BLU0-SMTP18292B09CCFD873F4A6DF6AEE40@phx.gbl> (Sean Estabrooks's
	message of "Mon, 14 Sep 2009 06:13:16 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128510>

--=-=-=

Sean Estabrooks <seanlkml@sympatico.ca> writes:
> ... To me though, it seems more difficult to parse this description
> than the one offered by Junio in an earlier thread ...perhaps you'd
> consider something closer to yours, such as:
>
> 	Interactively review the differences between the index and the
> 	work tree and choose which hunks to add into the index.
>
> 	This effectively runs ``add --interactive``, but bypasses the
> 	initial command menu and jumps directly to the `patch` subcommand.
> 	See ``Interactive mode'' for details.


Updated, thanks,
Jari


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Improve-patch-option-documentation-in-git-add.patch

>From be5eebc53c2e3dcf67edfb371d8aa8263e1a8d69 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Tue, 15 Sep 2009 08:33:51 +0300
Subject: [PATCH] Improve --patch option documentation in git-add

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-add.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e67b7e8..c57895a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -72,9 +72,12 @@ OPTIONS
 
 -p::
 --patch::
-	Similar to Interactive mode but the initial command loop is
-	bypassed and the 'patch' subcommand is invoked using each of
-	the specified filepatterns before exiting.
+	Interactively review the differences between the index and the
+	work tree and choose which hunks to add into the index.
+
+	This effectively runs ``add --interactive``, but bypasses the
+	initial command menu and jumps directly to the `patch` subcommand.
+	See ``Interactive mode'' for details.
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.6.3.3


--=-=-=--
