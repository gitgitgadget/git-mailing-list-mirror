From: "Neal Kreitzinger" <neal@rsss.com>
Subject: integrity of linux copy of a git repo
Date: Fri, 1 Oct 2010 14:47:50 -0500
Message-ID: <i85dub$fp5$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 21:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1lb4-0007z1-S2
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 21:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab0JATsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 15:48:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:47374 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab0JATsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 15:48:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P1lav-0007xl-7M
	for git@vger.kernel.org; Fri, 01 Oct 2010 21:48:37 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:48:37 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:48:37 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157775>

If I make a recursive linux copy, "cp -rfp", of a git repo working tree is 
the resulting copy interchangeable with the original?

e.g.
/orig-wk-tree was created via git-clone with the file:/// url and therefore 
is a "full copy"
cp -rfp /orig-wk-tree /orig-wk-tree-copy
(do some stuff that breaks /orig-wk-tree)
rm -rf /orig-wk-tree
mv /orig-wk-tree-copy /orig-wk-tree

Have I truly recovered the full integrity of the original, or have I 
unwittingly introduced some sort of corruption?

v/r,
Neal
