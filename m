From: Jan Engelhardt <jengelh@medozas.de>
Subject: Two-step tag fetching
Date: Sun, 10 Aug 2008 11:19:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0808101115290.1727@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCit-0005vq-7h
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYHJPTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbYHJPTp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:19:45 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:53006 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbYHJPTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:19:44 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 7268818032C9B; Sun, 10 Aug 2008 17:19:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 5DEB81C415402
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 11:19:42 -0400 (EDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91844>

Hi,


I have a somewhat older development tree at git://dev.medozas.de/linux 
(about 2.6.26-rc6), and without any tags. Now, adding in Linus's 
repository makes it gather all the new stuff, and all the missing tags:

$ git remote add linus 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
$ git fetch linus
remote: Counting objects: 85029, done.
remote: Compressing objects: 100% (14727/14727), done.
remote: Total 74992 (delta 61774), reused 72751 (delta 59953)
Receiving objects: 100% (74992/74992), 23.08 MiB | 1375 KiB/s, done.
Resolving deltas: 100% (61774/61774), completed with 6853 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new branch]      master     -> linus/master
 * [new tag]         v2.6.12    -> v2.6.12
 * [new tag]         v2.6.12-rc2 -> v2.6.12-rc2
 * [new tag]         v2.6.12-rc3 -> v2.6.12-rc3
 * [new tag]         v2.6.12-rc4 -> v2.6.12-rc4
[... lots of new tags ...]
 * [new tag]         v2.6.25    -> v2.6.25
 * [new tag]         v2.6.25-rc1 -> v2.6.25-rc1
 * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
 * [new tag]         v2.6.25-rc3 -> v2.6.25-rc3
 * [new tag]         v2.6.25-rc4 -> v2.6.25-rc4
 * [new tag]         v2.6.25-rc5 -> v2.6.25-rc5
 * [new tag]         v2.6.25-rc6 -> v2.6.25-rc6
 * [new tag]         v2.6.25-rc7 -> v2.6.25-rc7
 * [new tag]         v2.6.25-rc8 -> v2.6.25-rc8
 * [new tag]         v2.6.25-rc9 -> v2.6.25-rc9
 * [new tag]         v2.6.26-rc1 -> v2.6.26-rc1
 * [new tag]         v2.6.26-rc2 -> v2.6.26-rc2
 * [new tag]         v2.6.26-rc3 -> v2.6.26-rc3
 * [new tag]         v2.6.26-rc4 -> v2.6.26-rc4
 * [new tag]         v2.6.26-rc5 -> v2.6.26-rc5
 * [new tag]         v2.6.26-rc6 -> v2.6.26-rc6
 * [new tag]         v2.6.26-rc7 -> v2.6.26-rc7
 * [new tag]         v2.6.26-rc8 -> v2.6.26-rc8
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.26    -> v2.6.26
 * [new tag]         v2.6.26-rc9 -> v2.6.26-rc9
 * [new tag]         v2.6.27-rc1 -> v2.6.27-rc1
 * [new tag]         v2.6.27-rc2 -> v2.6.27-rc2


What interests me here is why there are two "From" lines.



thanks,
Jan
