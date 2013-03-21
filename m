From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 22:47:48 +0100
Message-ID: <1363902468-14764-1-git-send-email-ydroneaud@opteya.com>
References: <1363704914.6289.39.camel@test.quest-ce.net> <7vfvzrjrad.fsf@alter.siamese.dyndns.org> <1363802033-26868-1-git-send-email-ydroneaud@opteya.com> <7vboadevpk.fsf@alter.siamese.dyndns.org> <7vmwtwa5xa.fsf@alter.siamese.dyndns.org> <20130321195624.GH29311@google.com> <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:48:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UInLz-00024p-7x
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3CUVs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 17:48:27 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58088 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab3CUVs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 17:48:27 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7FF289401CA;
	Thu, 21 Mar 2013 22:48:15 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2LLmCNj014801;
	Thu, 21 Mar 2013 22:48:14 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2LLmANt014800;
	Thu, 21 Mar 2013 22:48:10 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218764>

Hi,

Just a little change I made on my own.
The other part are definitely better than my version, so I propose
to merge all the patches in the thread with you as author,
putting Jonathan Nieder and myself as reviewers.

Regards

 Documentation/git-merge.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index dd90feb..42391f2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -176,8 +176,8 @@ MERGING TAG
 When merging an annotated (and possibly signed) tag, Git always
 creates a merge commit even if a fast-forward merge is possible, and
 the commit message template is prepared with the tag message.
-Additionally, the signature check is reported as a comment
-if the tag is signed.  See also linkgit:git-tag[1].
+Additionally, if the tag is signed, the signature check is reported
+as a comment in the message template. See also linkgit:git-tag[1].
 
 When you want to just integrate with the work leading to the commit
 that happens to be tagged, e.g. synchronizing with an upstream
-- 
1.7.11.7
