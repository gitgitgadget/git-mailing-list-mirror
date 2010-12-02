From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH v2] git-cherry.txt: Change symbol marks in graph.
Date: Thu, 02 Dec 2010 14:28:48 +0200
Organization: Private
Message-ID: <8762vcs6in.fsf_-_@picasso.cante.net>
References: <4CF7543B.6060900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 13:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8IF-0003hJ-4m
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab0LBM3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:29:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:55552 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757538Ab0LBM3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:29:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PO8HU-0003Ns-JF
	for git@vger.kernel.org; Thu, 02 Dec 2010 13:29:00 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:29:00 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:29:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
In-Reply-to: <4CF7543B.6060900@drmicha.warpmail.net>
Cancel-Lock: sha1:eXufZh1SsTeeoIONeb4VpvpFHRA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162696>

The common commit were marked with a minus sign (-), but that is
usually interpreted as something less or substracted. Use natural
equal sign (=). Commits that are not in upstream were marked with plus
sign (+) but a question mark (?) is visually a litle more striking
(erect) in context where all other signs are "flat". It also helps
visually impared to see difference between (= ... ?).

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-cherry.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

    Revised:

    >> +in the <upstream> branch are prefixed with a equal (=) sign, and those
    >
    > "an equal"


diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index fed115a..f49eded 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -19,13 +19,13 @@ the 'git patch-id' program.
 Every commit that doesn't exist in the <upstream> branch
 has its id (sha1) reported, prefixed by a symbol.  The ones that have
 equivalent change already
-in the <upstream> branch are prefixed with a minus (-) sign, and those
-that only exist in the <head> branch are prefixed with a plus (+) symbol:
+in the <upstream> branch are prefixed with an equal sign (=), and those
+that only exist in the <head> branch are prefixed with a question mark (?) symbol:
 
-               __*__*__*__*__> <upstream>
+               _*__*__*__*__> <upstream>
               /
     fork-point
-              \__+__+__-__+__+__-__+__> <head>
+              \__?__?__=__?__?__=__?__> <head>
 
 
 If a <limit> has been given then the commits along the <head> branch up
@@ -34,7 +34,7 @@ to and including <limit> are not reported:
                __*__*__*__*__> <upstream>
               /
     fork-point
-              \__*__*__<limit>__-__+__> <head>
+              \__*__*__<limit>__=__?__> <head>
 
 
 Because 'git cherry' compares the changeset rather than the commit id
-- 
1.7.2.3
