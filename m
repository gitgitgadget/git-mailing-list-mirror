From: Jeff King <peff@peff.net>
Subject: Re: "git help stage" doesn't display git-stage man page
Date: Wed, 3 Dec 2008 22:42:03 -0500
Message-ID: <20081204034203.GA12835@coredump.intra.peff.net>
References: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org> <87myfdn2ga.fsf@iki.fi> <7vwsehfzf7.fsf@gitster.siamese.dyndns.org> <7vmyfdfyi9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L857p-0007ZX-AY
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 04:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYLDDmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 22:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYLDDmI
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 22:42:08 -0500
Received: from peff.net ([208.65.91.99]:1494 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbYLDDmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 22:42:07 -0500
Received: (qmail 27414 invoked by uid 111); 4 Dec 2008 03:42:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Dec 2008 22:42:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2008 22:42:03 -0500
Content-Disposition: inline
In-Reply-To: <7vmyfdfyi9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102325>

On Wed, Dec 03, 2008 at 12:34:22AM -0800, Junio C Hamano wrote:

> diff --git a/Makefile b/Makefile
> index 9577d6f..5158197 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -320,6 +320,7 @@ BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-peek-remote$X
>  BUILT_INS += git-repo-config$X
>  BUILT_INS += git-show$X
> +BUILT_INS += git-stage$X
>  BUILT_INS += git-status$X
>  BUILT_INS += git-whatchanged$X

We need this, too, then.

-- >8 --
add stage to gitignore

This is a generated builtin since 24b1f65f (Install git-stage in
exec-path).

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0c35577..327e660 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-stage
 git-stash
 git-status
 git-stripspace
-- 
1.6.1.rc1.309.g51074
