From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git-blame.el: Add (require 'format-spec)
Date: Tue, 25 May 2010 15:44:15 +0200
Message-ID: <87r5l0gkpc.fsf_-_@krank.kagedal.org>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	<87einafojx.fsf@osv.gnss.ru> <87d42s3pv2.fsf@lysator.liu.se>
	<AANLkTikPArJ0s8BTN7QH3CeqU98BGHobKax3IrjMXPrh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue May 25 16:13:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGut1-00016P-7F
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 16:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578Ab0EYONc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 10:13:32 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:34365 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab0EYONb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 10:13:31 -0400
X-Greylist: delayed 1753 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2010 10:13:31 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A6AAC400A6;
	Tue, 25 May 2010 15:44:16 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 9B35640006; Tue, 25 May 2010 15:44:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 64096400B4;
	Tue, 25 May 2010 15:44:16 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 0674960741; Tue, 25 May 2010 15:44:15 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
In-Reply-To: <AANLkTikPArJ0s8BTN7QH3CeqU98BGHobKax3IrjMXPrh@mail.gmail.com>
	(Alex Unleashed's message of "Fri, 14 May 2010 15:13:35 +0200")
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147712>


---
> On Sun, Dec 6, 2009 at 8:43 PM, David K=C3=A5gedal <davidk@lysator.li=
u.se> wrote:
> > Sergei Organov <osv@javad.com> writes:
> >
> >> Then there should be (require 'format-spec) in git-blame.el, right=
? Due
> >> to:
> >
> > Of course. I must have missed that since I already had it loaded.
>=20
> Has this oneliner been submitted for inclusion in git.git yet?
> Yesterday I stumbled upon format-spec missing on a fresh install of
> Ubuntu 10.04's emacs package.. Just require'ing it fixes the problem.

Apparently not, but here is the patch.

 contrib/emacs/git-blame.el |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 7f4c792..d351cfb 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -79,6 +79,7 @@
 ;;; Code:
=20
 (eval-when-compile (require 'cl))			      ; to use `push', `pop'
+(require 'format-spec)
=20
 (defface git-blame-prefix-face
   '((((background dark)) (:foreground "gray"
--=20
1.7.0.4


--=20
David K=C3=A5gedal
