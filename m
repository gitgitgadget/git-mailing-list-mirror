From: Eric Raible <raible@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 16:21:37 +0000 (UTC)
Message-ID: <loom.20090827T180201-590@post.gmane.org>
References: <1251387045053-3527289.post@n2.nabble.com> <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mghjl-0007KH-RL
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZH0QWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZH0QWA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:22:00 -0400
Received: from lo.gmane.org ([80.91.229.12]:33975 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbZH0QV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:21:59 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mghjc-0007IT-4A
	for git@vger.kernel.org; Thu, 27 Aug 2009 18:22:00 +0200
Received: from dsl-63-249-112-73.static.cruzio.com ([63.249.112.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 18:22:00 +0200
Received: from raible by dsl-63-249-112-73.static.cruzio.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 18:22:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.249.112.73 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127171>

Avery Pennarun <apenwarr <at> gmail.com> writes:

> Git currently promises that your refs/remotes/* branches will
> never be updated unless you explicitly request it, even if you're
> fetching, merging, and pulling other stuff.

So your claim is that "git fetch central" is somehow more
explicit than "git fetch central master"?

I understand that "git fetch central" will use
remote.central.fetch (which _is_ explicit), but
the command itself is certainly _less_ explicit about
specifying the remote branch.

Either way, AFAICT it seems purely historical that
"git fetch central master" doesn't update remotes/central.

- Eric
