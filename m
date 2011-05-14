From: =?utf-8?b?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
Subject: git difftool does does not respect current working directory
Date: Sat, 14 May 2011 14:25:40 +0000 (UTC)
Message-ID: <loom.20110514T160931-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 16:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFrD-0003D2-V7
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 16:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab1ENOaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 10:30:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:58514 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756991Ab1ENOaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 10:30:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QLFr2-000372-NE
	for git@vger.kernel.org; Sat, 14 May 2011 16:30:04 +0200
Received: from dra38-7-88-179-84-80.fbx.proxad.net ([88.179.84.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 May 2011 16:30:04 +0200
Received: from frederic.heitzmann by dra38-7-88-179-84-80.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 May 2011 16:30:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.179.84.80 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173589>

Hello.

It is useful to compare the modified version of a file to HEAD's version, in
order to review changes before committing. gitk is fine for this but I often use
git difftool -t gvimdiff, so that I can rewrite code right into my diff editor.
Doing this, it is very likely that I open some more files (e.g. foo.h
corresponding to foo.c) in gvimdiff.
Unfortunately, 'git difftool' does not keep the current working directory while
launching gvimdiff.

=> Is it done on purpose ?
If not, it is probably a good idea to fix this.

I will be more than happy to contribute but I have some hard time to get
familiar with git source code.
Any help to locate the proper pieces of code would be realy appreciated.

--
Fred
