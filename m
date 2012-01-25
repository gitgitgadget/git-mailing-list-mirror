From: freefly <free.fly@live.com>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 19:32:10 +0000 (UTC)
Message-ID: <loom.20120125T202642-92@post.gmane.org>
References: <loom.20120125T173801-500@post.gmane.org>  <loom.20120125T181639-351@post.gmane.org> <1327517841.31804.75.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 20:32:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq8aB-0003El-ED
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 20:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2AYTcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 14:32:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:58923 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2AYTcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 14:32:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rq8Zy-0003AQ-C0
	for git@vger.kernel.org; Wed, 25 Jan 2012 20:32:22 +0100
Received: from 0x5da1596e.cpe.ge-0-2-0-1104.fsnqu1.customer.tele.dk ([93.161.89.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 20:32:22 +0100
Received: from free.fly by 0x5da1596e.cpe.ge-0-2-0-1104.fsnqu1.customer.tele.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 20:32:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.161.89.110 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189122>



> What do `which git` and `type git` say? Bash remembers where it ran a
> command so if you install a binary to a new location, it might not find
> it straight away.

which git => /usr/bin/git

type git => git is hashed (/usr/bin/git)

> So the script detected that no change was needed presumably. What's your
> $PATH and is /usr/local/bin/ before /usr/bin/?
 
echo $PATH => /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:
                         /usr/X11/bin:/usr/local/git/bin:/opt/local/bin

from the above output it is not before /usr/bin :(
