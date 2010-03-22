From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: explain the meaning of "-g" in git-describe output
Date: Mon, 22 Mar 2010 21:45:33 +0100
Message-ID: <201003222145.33383.markus.heidelberg@web.de>
References: <201003172320.45058.markus.heidelberg@web.de> <76718491003171614r2e8ce0e5r3e4799503194831c@mail.gmail.com> <alpine.LFD.2.00.1003171811420.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtoTs-0000Km-CC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0CVUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 16:44:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55649 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab0CVUoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 16:44:03 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 81CB315736D76;
	Mon, 22 Mar 2010 21:44:00 +0100 (CET)
Received: from [91.19.13.183] (helo=pluto.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NtoTg-00050U-00; Mon, 22 Mar 2010 21:44:00 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <alpine.LFD.2.00.1003171811420.18017@i5.linux-foundation.org>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX181OCqADG89etcfiYtU9AFq8C7qHpl+prEPedKy
	d4UZS0AAOhyQ6ch5sfxJBXB/k1mPvYvDC2XYJiuHYS0tmunZvj
	aABQpjZjlTMx8YweV1AQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142967>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Linus Torvalds, 2010-03-18 02:19:
> 
> On Wed, 17 Mar 2010, Jay Soffian wrote:
> > 
> > My guess, from 908e531 (Add a "git-describe" command, 2005-12-24), is
> > that it's short for "git":
> 
> Indeed. I actually wanted to make it possible to use other SCM's, even if 
> it's stupid. And git is not the only one that uses hashes for versioning, 
> so the "g" prefix is there to allow others that use -hg or monotone or 
> similar to work

I really hadn't thought of this obvious explanation.

 Documentation/git-describe.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 6fc5323..d9311dd 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -105,6 +105,9 @@ The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
 The hash suffix is "-g" + 7-char abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
+The "g" prefix stands for "git" and is used to allow describing the version of
+a software depending on the SCM the software is managed with. This is useful
+in an environment where people may use different SCMs.
 
 Doing a 'git describe' on a tag-name will just show the tag name:
 
-- 
1.7.0.3.257.gcd709
