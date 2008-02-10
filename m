From: "Nikita V. Youshchenko" <yoush@debian.org>
Subject: fetching a single commit from remote repo
Date: Sun, 10 Feb 2008 18:00:08 +0300
Message-ID: <1530970.y9vPlhFxz8@yoush.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 17:35:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOF9b-00079a-PH
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYBJQfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYBJQfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:35:09 -0500
Received: from main.gmane.org ([80.91.229.2]:53946 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbYBJQfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:35:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JOF8w-0003M1-7W
	for git@vger.kernel.org; Sun, 10 Feb 2008 16:35:02 +0000
Received: from ppp85-140-99-143.pppoe.mtu-net.ru ([85.140.99.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 16:35:02 +0000
Received: from yoush by ppp85-140-99-143.pppoe.mtu-net.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 16:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ppp85-140-99-143.pppoe.mtu-net.ru
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73368>

Hello.

I'm looking for a way to fetch a single snapshot, without history, from
remote git repository.

I've found how to do it with a head (clone --depth 1, or fetch --depth 1).

Is it possible to do the same with non-head and non-tagged commit, if only
sha1 name of the commit is known?
Looks like fetch and fetch-pack only take ref names :(
