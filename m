From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: push problem for new repo on repo.or.cz
Date: Mon, 09 Mar 2009 17:02:55 +0100
Message-ID: <49B53DAF.9080004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lghy3-0003l5-Ak
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZCIQDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbZCIQDJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:03:09 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60957 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079AbZCIQDI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 12:03:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 350F22EB290;
	Mon,  9 Mar 2009 12:03:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 09 Mar 2009 12:03:06 -0400
X-Sasl-enc: Aq2UVd+DH8XHyNeScaC3Dq31PlMHunbS0tVbsUL8q7RB 1236614585
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E6975120B;
	Mon,  9 Mar 2009 12:03:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090305 Lightning/1.0pre Shredder/3.0b3pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112711>

Hi there

I have problems pushing into a new project on repo.or.cz. My user (mjg)
is added in the admin interface, the key is correct because I've been
using it for a while already for other projects (forks though). I'm
using a qualified refspec. What else could be wrong on my side, assuming
it's not the scripts on repo.or.cz? My git is 1.6.2.

Michael

git  push  git+ssh://repo.or.cz/srv/git/conformal.git master:master
Counting objects: 14, done.
Delta compression using 2 threads.
Compressing objects: 100% (11/11), done.
Writing objects: 100% (14/14), 11.50 KiB, done.
Total 14 (delta 3), reused 0 (delta 0)
error: unpack failed: unpacker exited with error code
To git+ssh://repo.or.cz/srv/git/conformal.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: unable to create temporary sha1 filename ./objects/a3: Permission
denied

fatal: failed to write object
error: failed to push some refs to
'git+ssh://repo.or.cz/srv/git/conformal.git'
