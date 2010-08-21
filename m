From: Jan Engelhardt <jengelh@medozas.de>
Subject: git-describe --contains fails on given tree
Date: Sat, 21 Aug 2010 21:47:46 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 21:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omu2j-0001ND-UY
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 21:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab0HUTru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 15:47:50 -0400
Received: from borg.medozas.de ([188.40.89.202]:60401 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab0HUTrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 15:47:48 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id 9874BF0C32A8E; Sat, 21 Aug 2010 21:47:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 8E77165CB
	for <git@vger.kernel.org>; Sat, 21 Aug 2010 21:47:46 +0200 (CEST)
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154153>

Hi,



for some reason, git-describe cannot figure out v1.17~15^2^2 in
the pam_mount tree, despite me being able to actually give
a description that would fit the contains syntax:

$ git clone
git://pam-mount.git.sf.net/gitroot/pam-mount/pam-mount
Initialized empty Git repository in /dev/shm/pam-mount/.git/
remote: Counting objects: 7261, done.
remote: Compressing objects: 100% (1819/1819), done.
remote: Total 7261 (delta 5557), reused 6990 (delta 5348)
Receiving objects: 100% (7261/7261), 1.40 MiB | 832 KiB/s, done.
Resolving deltas: 100% (5557/5557), done.

$ cd pam-mount/
$ git describe --contains v1.17~15^2^2
fatal: cannot describe '95ce932690dfce8cbe50b6a3a8949e41a54c8966'

(Expected to get back: v1.17~15^2^2)

Why would it not want to return something? Possible bug?

Using git 1.7.1 on openSUSE 11.3.


thanks,
Jan
