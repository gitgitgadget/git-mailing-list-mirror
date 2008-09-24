From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [BUG] git ls-files -m --with-tree does double output
Date: Wed, 24 Sep 2008 18:19:32 +0200
Message-ID: <87od2dv7mz.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 18:22:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiX6c-0005Db-Dh
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYIXQTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbYIXQTg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:19:36 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:34426 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbYIXQTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:19:35 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id B7A4214062
	for <git@vger.kernel.org>; Wed, 24 Sep 2008 18:19:35 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 8ACE11405A
	for <git@vger.kernel.org>; Wed, 24 Sep 2008 18:19:35 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96656>

I think that this is wrong? The combination of -m and --with-tree
shows duplicate entries. Git 1.6.0.2.


Cheers,
Anders.


and@dylle:~$ mkdir repo ; cd repo
and@dylle:~/repo$ git init
Initialized empty Git repository in /home/and/repo/.git/
and@dylle:~/repo$ date >a ; git add a ; git commit -m'Add 1'
Created initial commit c027435: Add 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
and@dylle:~/repo$ date >a
and@dylle:~/repo$ git ls-files -m --with-tree=HEAD
a
a
