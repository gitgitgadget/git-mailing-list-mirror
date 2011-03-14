From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git-reset HEAD --permissions-only
Date: Mon, 14 Mar 2011 15:29:51 -0500
Message-ID: <illts0$c6q$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 21:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzEPM-0008Tr-Dq
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 21:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab1CNUaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 16:30:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:34339 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab1CNUaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 16:30:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PzEOy-0008Iv-1j
	for git@vger.kernel.org; Mon, 14 Mar 2011 21:30:04 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 21:30:04 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 21:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169025>

Is there a way to only reset the file permissions of the working-tree to 
match HEAD file permissions without resetting the content of the files?

HEAD file permissions = the permissions of the objects in the object store.

I'm using the vendor branch method of the git-rm manpage (git ls-files -z | 
xargs -0 rm -f && tar xzf vendor-version.tar.gz && git add -A) and I want to 
discard the vendor's file permissions changes to existing files and reset 
them back to what they are in HEAD.

"existing files" = ALL files that already existed in the HEAD and are not 
"deleted" or "new" in the working-tree relative to the HEAD.
HEAD = before "rm"
Working-Tree = after the untar.

v/r,
Neal 
