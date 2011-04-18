From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 6/5 v2] Documentation/format-patch: suggest Toggle Word Wrap
 add-on for Thunderbird
Date: Mon, 18 Apr 2011 08:31:16 +0200
Message-ID: <4DABDAB4.3000607@viscovery.net>
References: <87d3kq6tz7.fsf@rho.meyering.net> <1302719749.21047.6.camel@drew-northup.unet.maine.edu> <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie> <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie> <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie> <4DA7F6C0.4050707@viscovery.net> <7vtydzcse4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 08:32:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBi0T-0001ch-GI
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 08:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab1DRGcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 02:32:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20608 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1DRGcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 02:32:16 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QBi0C-0002VI-GL; Mon, 18 Apr 2011 08:32:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 250591660F;
	Mon, 18 Apr 2011 08:32:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vtydzcse4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171738>

From: Johannes Sixt <j6t@kdbg.org>

Of the (now) three methods to send unmangled patches using Thunderbird,
this method is listed first because it provides a single-click on-demand
option rather than a permanent change of configuration like the other
two methods.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 4/15/2011 19:54, schrieb Junio C Hamano:
> Care to reword "superior" in a less subjective way

Sure.

Differences to v1: More precise description where the new Option is found.

-- Hannes

 Documentation/git-format-patch.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8887375..a979b2a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -343,11 +343,21 @@ By default, Thunderbird will both wrap emails as well as flag
 them as being 'format=flowed', both of which will make the
 resulting email unusable by git.
 
-There are two different approaches.  One approach is to configure
-Thunderbird to not mangle patches.  The second approach is to use
+There are three different approaches: use an add-on to turn off line wraps,
+configure Thunderbird to not mangle patches, or use
 an external editor to keep Thunderbird from mangling the patches.
 
-Approach #1 (configuration)
+Approach #1 (add-on)
+^^^^^^^^^^^^^^^^^^^^
+
+Install the Toggle Word Wrap add-on that is available from
+https://addons.mozilla.org/thunderbird/addon/toggle-word-wrap/
+It adds a menu entry "Enable Word Wrap" in the composer's "Options" menu
+that you can tick off. Now you can compose the message as you otherwise do
+(cut + paste, 'git format-patch' | 'git imap-send', etc), but you have to
+insert line breaks manually in any text that you type.
+
+Approach #2 (configuration)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Three steps:
 
@@ -374,7 +384,7 @@ After that is done, you should be able to compose email as you
 otherwise would (cut + paste, 'git format-patch' | 'git imap-send', etc),
 and the patches will not be mangled.
 
-Approach #2 (external editor)
+Approach #3 (external editor)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The following Thunderbird extensions are needed:
-- 
1.7.5.rc1.1127.g94456
