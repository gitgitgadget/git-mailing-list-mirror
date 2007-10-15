From: "Michael W. Olson" <mwolson@gnu.org>
Subject: [PATCH] git-rebase--interactive.sh: Quote arguments to test
Date: Mon, 15 Oct 2007 13:48:27 -0400
Message-ID: <87odf0clqs.fsf@hariken.mwolson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 21:06:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhUFP-0000MR-Vr
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 20:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbXJOSAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbXJOSAv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 14:00:51 -0400
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:32981 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759195AbXJOSAr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 14:00:47 -0400
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2007 14:00:46 EDT
Received: from ip6-localhost (host-212-116.inlacol.clients.pavlovmedia.com [66.253.212.116])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.13.7/8.13.7/auth-smtp.purdue.edu) with ESMTP id l9FHmR8k026447
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 15 Oct 2007 13:48:44 -0400
Received: from mwolson by ip6-localhost with local (Exim 4.67)
	(envelope-from <mwolson@hariken.mwolson.org>)
	id 1IhU3H-0003xX-Q1
	for git@vger.kernel.org; Mon, 15 Oct 2007 13:48:27 -0400
X-Hashcash: 1:20:071015:git@vger.kernel.org::tXNmiwUnU1hVd+kZ:0000000000000000000000000000000000000000001Srd
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU1QytIVTlZY0dqc1N6
 hGGJl3qZpZCtuKXsjxzFAAACW0lEQVR42l2UXXrqIBCGk67Aoe29Ac4CTPDcGwZ73wLdQDOuQLP9
 8wHG9hT1Mc6bb/5jp7Xed92TVrqeCYfKRVc+XdfDbqbJ8TixG1UDu2a3xkf2H+z+A6Qn7Xk71AA8
 kdJmZg4xpcTshgr2JQSurAswhwDFYQN9r4yxx1BIQqBTBbvqahw9hxRSLOBdFVA89TTOvgSoMaLf
 ABTWOg5Z8lLRNyD7x4WSVHU1DZurThn2HI9Oa561JhTSDUWxq64YqRlmrcdhA73y3rmJY1okotDT
 NzDO2XNGZPnS7A4b6NQ8foQFN2eJmEBR7Du1Q/DRh7R4O50BrGmu0F8i49Iya+ScvtDNqkADB8zD
 pwU9wTu9c8msdNYOO0JvYYyREd9xBOh7zSNc2WMZUYzIDHOpU0Kxe5o9o0eccsr5mNLcwHhC8DoM
 SQkJ5wbUxAdlbDELEpDbclc8sT2gV2HJIrj/si7hDgzPpY4sqxTV+pWkgt7EGesDIFWUnGuK7pkn
 erZoieCVZPGcG3jCJimLwS7IVZY4R3mvoNfzoCfOF0mIG1nna+TadAxzgF5u0b3JTaxcmZtCF1dn
 WSOv63oNl4U3BQCLXOQKWZIHUBWcUci6iuTL7eMOelVAKfp+NkA0kOElN3BbV26AiGZsXEqfa0EQ
 NtATvTAKCeHh7AEEi4knM6S3HwB2eo1zeZQ5fDbgNkCpbEwh8HUTqYDqwUhIG2NQ/k2WH+CVB9LK
 aINy0EeAvgF6KRK0wIaPiX8CioRNpQF7X/8EOnoAPpUvrX8DED7t8B/Bv8ErfnpSfxv4B9rx7BDd
 lxXRAAAAAElFTkSuQmCC
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEWTYFCdbl2ne2y2joG9
 nJDIpprOtKvdyMLp2tX28O+yYiAYAAACbklEQVQ4y3WTzXLaMBDH18k0vVrmBbDc5FyQ6b1Ypud2
 LJNrx9Yq9wYv9zRYeYEW3jYrm0AOYWfwsPvzf78sAcCV38GHFr1cBM8XgH+KLij+XgB+9/NDcO3p
 98eg38Qn50pK8eZd2+YcV4VS8g20X09gUpZrrKaj82k5PYG8QtqiGp2bx7NC18731Ixvfu5O4Hrl
 tt77PwLCZDebU6qs3jLonyKZBGBP3WYYBLSR81Dmzk7fg36DrlE5N+VaMa5GJJnryTX6/rHIgf/z
 fCKOEqVUUu+qVbWgXaUhqalKZcZRnRfpop1/64g7ZoCIlVJFrtlmd0qte+p3vYFb77tWH21+V62p
 eyDaGviBZN/ienlL2412HZEBXsEZFLmjLu+osxq2hKjPVmNXEnVaA5Gz70BeO6QeyxLQrdtzfKVW
 XJmssVDNk2zMr9ecI1s4fhYrB9VMTlqN1jh/OBz6ZcjVZmsCO1dfHnry+0Ow/VKqvFCZIwjT3fuX
 wxhvslTKTGY1gX82xh1G4DfTSRoljGoH/p/R9RDf9yYVYi5lInWJ4HdmYbb7vadunggRSyWl0isC
 Hn9hHKJVaRIJISKZFbwAArNihcEmjcVowIhFYBBLU2MRR9ERDCYBsQ6KdhYHScLlhzOTMOAaZv2/
 iQeF5B+LowDaXPM+utkA0tAZhIwWW1bUhL8g+DzEsRSnz01lOgbRQKRMB4CbJi8t97UECOW5Vwap
 BEKjS22M+c5nkQ9jKnmNnBGQY/yZquEaDR0LmTIDa9DwaStUaH8cMhG8YMDa6tlEqXScWIwkKEqr
 +EYdN3EEaSKhKm1xumo8czwS+QobFeSnpZon5AAAAABJRU5ErkJggg==
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
X-PMX-Version: 5.2.1.279297
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61024>

If /bin/sh is /bin/dash, then the script will display an error if
$parent_sha1 is undefined.  This patch works fixes the issue by
quoting both arguments to `test'.  Arguments composed solely of
variable expansions should always be quoted, unless we know for
certain that the contents are defined.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---

Resending, this time directly to the mailing list instead of via Gmane.

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 050140d..8a03062 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -110,7 +110,7 @@ pick_one () {
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
-	if test $no_ff$current_sha1 = $parent_sha1; then
+	if test "$no_ff$current_sha1" = "$parent_sha1"; then
 		output git reset --hard $sha1
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
-- 
1.5.3.4
