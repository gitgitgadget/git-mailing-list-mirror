From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: rename the signed tag mode 'ignore' to
 'verbatim'
Date: Mon, 3 Dec 2007 22:56:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712032254150.27959@racer.site>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
 <7vabosse23.fsf@gitster.siamese.dyndns.org> <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712031109380.27959@racer.site> <7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712031838450.27959@racer.site> <7vwsrvh4vx.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712032243450.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKDc-0003Wg-Mn
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXLCW4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXLCW4a
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:56:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:35826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbXLCW43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:56:29 -0500
Received: (qmail invoked by alias); 03 Dec 2007 22:56:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp006) with SMTP; 03 Dec 2007 23:56:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Gl+kcdkaG2w5Dv7uLLNet3CzHSwOsFrGfRJ4U+n
	ltG0KTKEDggEFR
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712032243450.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66972>

Hi,

On Mon, 3 Dec 2007, Johannes Schindelin wrote:

> The name 'verbatim' describes much better what this mode does with
> signed tags.  While at it, fix the documentation what it actually
> does.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Maybe you want to squash this, too (sorry, I sent the patch too soon, 
although the mode "ignore" is still accepted, and thus, the test 
succeeded):

-- snipsnap --
[PATCH] fast-export: test "verbatim", not "ignore"

The signed-tag-mode "ignore" was renamed to "verbatim", and although we 
still accept "ignore" as a synonym, it is better to test "verbatim".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t9301-fast-export.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index e9c9fe6..f09bfb1 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -106,9 +106,9 @@ test_expect_success 'signed-tags=abort' '
 
 '
 
-test_expect_success 'signed-tags=ignore' '
+test_expect_success 'signed-tags=verbatim' '
 
-	git fast-export --signed-tags=ignore sign-your-name > output &&
+	git fast-export --signed-tags=verbatim sign-your-name > output &&
 	grep PGP output
 
 '
