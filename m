From: layer <layer@known.net>
Subject: git + cygwin + core.editor - adding drive when it shouldn't
Date: Thu, 23 Jun 2011 14:23:10 -0700
Message-ID: <22216.1308864190@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 23:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZrbJ-0006TG-Vh
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 23:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab1FWViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 17:38:07 -0400
Received: from relay.known.net ([173.13.135.57]:49146 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab1FWViG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 17:38:06 -0400
X-Greylist: delayed 896 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jun 2011 17:38:06 EDT
Received: from relay.known.net (localhost [127.0.0.1]) by relay.known.net
    (Allegro Maild v1.2.25) id 000000196618; Thu, 23 Jun 2011 14:23:10 -0700
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176294>

Windows Server 2008 R2.  Git 1.7.5.1.

When I startup bash in my home directory, HOME is /home/layer.

If I rebase -i, when core.editor set to emacsclientw (from GNU Emacs
23.2), I trace the server side and see a bogus filename coming over:

1 -> server-visit-files: files=(("c:/home/layer/acl82.64/src/cl/.git/rebase-merge/git-rebase-todo")) proc=#<process server <127.0.0.1:55428>> nowait=nil


c:/home/layer/... is wrong.  The value in Windows of HOME is
c:\cygwin\home\layer, and as I said, bash makes it /home/layer.

Adding the c: before /home is killing me.  It makes it impossible to
rebase when the inside my home directory.

Help!

Thanks.

Kevin
