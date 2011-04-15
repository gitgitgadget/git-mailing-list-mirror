From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH/RFC 6/5] Documentation/format-patch: suggest Toggle Word Wrap
 add-on for Thunderbird
Date: Fri, 15 Apr 2011 09:41:52 +0200
Message-ID: <4DA7F6C0.4050707@viscovery.net>
References: <87d3kq6tz7.fsf@rho.meyering.net> <1302719749.21047.6.camel@drew-northup.unet.maine.edu> <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie> <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie> <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 09:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAdfK-0000Pp-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 09:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab1DOHl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 03:41:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11598 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab1DOHl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 03:41:59 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QAdf7-0007pv-4e; Fri, 15 Apr 2011 09:41:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A4EA41660F;
	Fri, 15 Apr 2011 09:41:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110415021100.GA19829@elie>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171591>

From: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 How about this as 6/5? I used the method described for this submission, so if
 what you got is unusable, you know what to think of the suggestion ;)

 I put this suggestion as approach #1 because I think it is superior to the
 other two (iff it worked).

 -- Hannes

 Documentation/git-format-patch.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
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
+It adds a menu entry "Enable Word Wrap" that you can tick off. Now you
+can compose the message as you otherwise do (cut + paste,
+'git format-patch' | 'git imap-send', etc), but you have to insert
+line breaks manually in any additional text that you type.
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
