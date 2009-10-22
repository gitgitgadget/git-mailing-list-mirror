From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/git-pull.txt: Add subtitles above included option files
Date: Thu, 22 Oct 2009 17:14:57 +0300
Message-ID: <87y6n3y0pq.fsf_-_@jondo.cante.net>
References: <87eiow1pey.fsf@jondo.cante.net>
	<7vpr8g32ht.fsf@alter.siamese.dyndns.org>
	<7vhbts3285.fsf@alter.siamese.dyndns.org>
	<20091022192152.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 16:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0yn8-0001B7-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 16:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbZJVOhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 10:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbZJVOhN
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 10:37:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:54846 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258AbZJVOhM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 10:37:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0yf7-0003m8-Eu
	for git@vger.kernel.org; Thu, 22 Oct 2009 16:29:09 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 16:29:09 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 16:29:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:LvXmVJXVjvG9Lr7JpmWwt+/ipEU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131020>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-pull.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

 Nanako Shiraishi <nanako3@lavabit.com> writes:

 > Quoting Junio C Hamano <gitster@pobox.com>
 >
 >> Ah, in your defense ;-) I think you looked only at git-fetch.txt without
 >> checking where else this file is included.  Then the patch certainly is
 >> understandable.  It would probably make git-fetch.{1,html} easier to scan,
 >> while making things not worse for git-pull.{1,html}
 >
 > Can't we introduce subsections in the OPTIONS section to 
 > group them together, like this (sorry, not a patch)?
 >
 > OPTIONS
 > -------
 >
 > Options related to merging  <---- added
 > ~~~~~~~~~~~~~~~~~~~~~~~~~~  <---- added
 > include::merge-options.txt[]


diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7578623..51534dd 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -26,6 +26,10 @@ Also note that options meant for 'git-pull' itself and underlying
 
 OPTIONS
 -------
+
+Options related to merging
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 include::merge-options.txt[]
 
 :git-pull: 1
@@ -47,6 +51,9 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+Options related to fetching
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
-- 
1.6.4.3
