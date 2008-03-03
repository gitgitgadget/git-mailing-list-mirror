From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 16:21:46 +0100
Message-ID: <vpq63w325px.fsf@bauges.imag.fr>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	<vpqskz82bm3.fsf@bauges.imag.fr>
	<4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWCVz-0000FT-9K
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 16:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbYCCPXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYCCPXE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 10:23:04 -0500
Received: from imag.imag.fr ([129.88.30.1]:58938 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbYCCPXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 10:23:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m23FLl4Z014169
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2008 16:21:47 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWCU6-0004xj-Ao; Mon, 03 Mar 2008 16:21:46 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWCU6-0000yD-8Q; Mon, 03 Mar 2008 16:21:46 +0100
In-Reply-To: <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com> (Paolo Ciarrocchi's message of "Mon\, 3 Mar 2008 15\:33\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Mar 2008 16:21:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75935>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> "A merge is always between the current HEAD and one or more remote
> branch heads"

I think this is just wrong. Would this be correct?

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0c9ad7f..e46dea1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -68,7 +68,7 @@ HOW MERGE WORKS
 ---------------
 
 A merge is always between the current `HEAD` and one or more
-remote branch heads, and the index file must exactly match the
+branch heads (remote or local), and the index file must exactly match the
 tree of `HEAD` commit (i.e. the contents of the last commit) when
 it happens.  In other words, `git-diff --cached HEAD` must
 report no changes.


-- 
Matthieu
