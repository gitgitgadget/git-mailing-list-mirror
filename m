From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Document git push -q
Date: Mon, 19 Oct 2009 01:52:40 +0200
Message-ID: <20091018235240.GU6115@genesis.frugalware.org>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfYO-0002xq-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbZJRXwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbZJRXwi
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:52:38 -0400
Received: from virgo.iok.hu ([212.40.97.103]:40010 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781AbZJRXwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:52:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B76445808B;
	Mon, 19 Oct 2009 01:52:40 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4DCB344906;
	Mon, 19 Oct 2009 01:52:40 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 326EA11F002B; Mon, 19 Oct 2009 01:52:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ADB4AE8.5070007@hartwork.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130629>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Oct 18, 2009 at 07:05:44PM +0200, Sebastian Pipping <webmaster@hartwork.org> wrote:
> If I'm not mistaken --quiet is not documented in the git-push man page.
> This includes release 1.6.5.1.

Here is a patch to document it.

 Documentation/git-push.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ba6a8a2..beb3422 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -138,6 +138,12 @@ useful if you write an alias or script around 'git-push'.
 --verbose::
 	Run verbosely.
 
+-q::
+--quiet::
+	Some transports produce output even without `--verbose` turned
+	on. This provides a way to tell them to be more quiet (whereas
+	simply redirecting might lose error messages).
+
 include::urls-remotes.txt[]
 
 OUTPUT
-- 
1.6.5
