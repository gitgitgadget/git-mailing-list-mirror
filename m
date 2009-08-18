From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of  function
Date: Tue, 18 Aug 2009 18:52:25 +0200
Message-ID: <vpqr5v93vzq.fsf@bauges.imag.fr>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	<1250524872-5148-2-git-send-email-lznuaa@gmail.com>
	<alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
	<3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
	<alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>
	<4A8A3ADE.9010703@gmail.com>
	<alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302>
	<1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRz6-0003hJ-OL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbZHRQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbZHRQwq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:52:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51891 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535AbZHRQwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:52:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7IGp1im024221
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 18:51:01 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdRv7-0002b5-AB; Tue, 18 Aug 2009 18:52:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdRv7-0004y2-8r; Tue, 18 Aug 2009 18:52:25 +0200
In-Reply-To: <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com> (Frank Li's message of "Wed\, 19 Aug 2009 00\:11\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Aug 2009 18:51:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7IGp1im024221
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251219062.21183@QOylrAEUtUB63nAmmr7pyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126419>

Frank Li <lznuaa@gmail.com> writes:

>> Okay, I will wait for Frank's updates (just fetched tgit.git and it still
>> contains the old branch), merge the early part and add the compiler flags.
>>
> Today, I just update 5 patch according review feedback.
> Do I need send it again?

Yes, this is the use here. Preferably edit the message to replace
[PATCH] with [PATCH v2] or so.

> How do I know if patch has been applied main line?

Answering the question with another: shouldn't we add a section like
this to SubmittingPatches ?

>From 3ee45ab5992fd084c130460f07454061ce3cf057 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 18 Aug 2009 18:48:47 +0200
Subject: [PATCH] SubmittingPatches: draft section to know patches status

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/SubmittingPatches |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 76fc84d..c686f86 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -280,6 +280,20 @@ people play with it without having to pick up and apply the patch to
 their trees themselves.
 
 ------------------------------------------------
+Know the status of your patch after submission
+
+* You can use Git itself to find out when your patch is merged in
+  master. 'git pull --rebase' will automatically skip already-applied
+  patches, and will let you know. This works only if you rebase on top
+  of the branch in which your patch has been merged (i.e. it will not
+  tell you if your patch is merged in pu if you rebase on top of
+  master).
+
+* Read the git mailing list, the maintainer regularly posts messages
+  entitled "What's cooking in git.git" and "What's in git.git" giving
+  the status of various proposed changes.
+
+------------------------------------------------
 MUA specific hints
 
 Some of patches I receive or pick up from the list share common
-- 
1.6.4.313.g38b9



-- 
Matthieu
