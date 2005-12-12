From: Darrin Thompson <darrint@progeny.com>
Subject: diff-core segfault
Date: Mon, 12 Dec 2005 11:29:50 -0500
Message-ID: <1134404990.5928.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Dec 12 17:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elqfu-0003fx-VV
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 17:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVLLQgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 11:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLLQgz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 11:36:55 -0500
Received: from zealot.progeny.com ([216.37.46.162]:23186 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1751267AbVLLQgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 11:36:54 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id B71D0636AF
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 11:36:49 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13524>

$ mkdir a
$ cd a/
$ git-init-db
defaulting to local storage area
$ touch a
$ git-update-index --add a
$ git-commit -m 'message'
Committing initial tree 496d6428b9cf92981dc9495211e6e1120fb6f2ba
$ echo hello >a
$ git-diff-files
:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 M      a
$ git-diff-files -B
Segmentation fault

Disclaimer: I'm running 1.0rc2. I did some searching of recent mailing
list posts and commits. I see no evidence that this has been addressed.

Could someone confirm that this exists on more recent git heads and fix
if needed?

Thanks.

--
Darrin
