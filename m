From: Marc Weber <marco-oweber@gmx.de>
Subject: Distribution size
Date: Sat, 26 Sep 2009 13:11:00 +0200
Message-ID: <1253962653-sup-1882@nixos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 13:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrVBM-0003Hr-I0
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 13:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZIZLLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 07:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbZIZLLE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 07:11:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750880AbZIZLLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 07:11:04 -0400
Received: (qmail invoked by alias); 26 Sep 2009 11:11:05 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp040) with SMTP; 26 Sep 2009 13:11:05 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+0tJ1I/D+0AGyQYXjZ3jTLL+nFpNrlnR9MfK9xQ7
	S+vYZZW1gT6m4D
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 26 Sep 2009 13:11:00 +0200
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129148>

Hi,

Has anyone thought about reducing distribution size ?

comparison:

git-1.6.4.4 i%du -hs .
115M    .

mercurial-1.0.2 i%du -hs .
5.4M    .

bazaar-1.10rc1 i%du -hs
21M     .

darcs-2.2.1 i%du -hs    /nix/store/8xwfavyv22pvm3s60wvzcbq561fjk5di-darcs-2.2.1 nixos   
32M	.

There was an attempt to reduce size by using a shared library in 2007:
http://markmail.org/message/vzukaie4qvbghkq5

So is there a reason why git takes up so much more disk space other than
that its using many small executables?

Marc Weber
