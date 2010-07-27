From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 21:07:49 +0200
Message-ID: <201007272107.50204.barra_cuda@katamail.com>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:15:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odpd3-0004Xi-PM
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0G0TPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 15:15:48 -0400
Received: from smtp183-pc.aruba.it ([62.149.157.183]:54172 "HELO
	smtp2-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750858Ab0G0TPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 15:15:48 -0400
Received: (qmail 17584 invoked by uid 89); 27 Jul 2010 19:15:39 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2-pc.ad.aruba.it
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=6.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.118.169)
  by smtp2-pc.ad.aruba.it with SMTP; 27 Jul 2010 19:15:38 -0000
User-Agent: KMail/1.13.5 (Linux/2.6.34.1-mike-1mike; KDE/4.4.5; i686; ; )
In-Reply-To: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151976>

On Monday 26 July 2010, Matthieu Moy wrote:
>  Documentation/git-ls-files.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 3521637..2cc3243 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -106,6 +106,12 @@ OPTIONS
>  	with `-s` or `-u` options does not make any sense.
>  
>  -t::
> +	This feature is semi-deprecated. For scripting purpose,
> +	linkgit:git-status[1] `--porcelain` is almost always a
> +	superior alternative, and users should look at
> +	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
> +	`--name-status` for more user-friendly alternatives.
> +
>  	Identify the file status with the following tags (followed by
>  	a space) at the start of each line:
>  	H::	cached

I think this breaks formatting. Shouldn't it be more like the following?
(I.e. with a single '+' before "Identify...").

And maybe rephrase the line
"Identify the file status with the following tags (followed by
a space) at the start of each line"
into
"This option identifies..."
just to set apart "semi-deprecation" and "explanation" of the option.

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..ef84d41 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,15 +106,21 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
-	Identify the file status with the following tags (followed by
-	a space) at the start of each line:
-	H::	cached
-	S::	skip-worktree
-	M::	unmerged
-	R::	removed/deleted
-	C::	modified/changed
-	K::	to be killed
-	?::	other
+	This feature is semi-deprecated. For scripting purpose,
+	linkgit:git-status[1] `--porcelain` is almost always a
+	superior alternative, and users should look at
+	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
+	`--name-status` for more user-friendly alternatives.
++
+Identify the file status with the following tags (followed by
+a space) at the start of each line:
+H::	cached
+S::	skip-worktree
+M::	unmerged
+R::	removed/deleted
+C::	modified/changed
+K::	to be killed
+?::	other
 
 -v::
 	Similar to `-t`, but use lowercase letters for files
