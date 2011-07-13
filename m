From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git-archive and tar options
Date: Wed, 13 Jul 2011 18:34:32 -0500
Message-ID: <ivla29$liu$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 01:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh8xA-00075n-Kv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1GMXes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 19:34:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:59017 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab1GMXer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 19:34:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qh8x2-00073U-Pj
	for git@vger.kernel.org; Thu, 14 Jul 2011 01:34:44 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 01:34:44 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 01:34:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177092>

the git-archive manpage states:

"git archive [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>] [-o 
| --output=<file>] [--worktree-attributes] [--remote=<repo> 
[--exec=<git-upload-archive>]] <tree-ish>  [path\u2026]

<extra>
    This can be any options that the archiver backend understands. See next 
section."

I have tar 1.23 and want to use the --transform option.  How can I feed 
git-archive additional tar options?

Working syntax starting points for git-archive and tar:

git archive --format=tar -o my.tar HEAD Web/Templates/
tar -cvf my.tar --transform 's,^Web/Templates/,myPath/myWeb/Templates/,' 
WebPortal/Templates/

Failed syntax attempts for feeding tar option to git-archive:

git archive --format=tar -o my.tar HEAD --transform 
's,^Web/Templates/,myPath/myWeb/Templates/,' WebPortal/Templates/
error: unknown option `transform'

git archive --format=tar -o my.tar --transform 
's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD WebPortal/Templates/
error: unknown option `transform'


v/r,
neal 
