From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Getting git to help my memory
Date: Tue, 5 Jul 2011 21:34:18 +0000 (UTC)
Message-ID: <loom.20110705T232905-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 23:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeDH0-0003j3-UN
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 23:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab1GEVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 17:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:47452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab1GEVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 17:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QeDGr-0003fI-CD
	for git@vger.kernel.org; Tue, 05 Jul 2011 23:35:05 +0200
Received: from hank.cs.wisc.edu ([128.105.181.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 23:35:05 +0200
Received: from driscoll by hank.cs.wisc.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 23:35:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.105.181.52 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.127 Safari/534.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176627>

I have a somewhat unusual question. I often forget to push after committing,
and a few times this has come back to bite me. (One time I didn't even really
realize for a couple months because I was working on other stuff, so
unraveling the conflicts was "fun".)

Is there a way I can get git to print a "don't forget to push!" reminder
after it commits?

The best way I can think of is to put a post-commit hook in there. I haven't
tried it but I'd assume it would work, but would have to be on a
per-repository basis instead of global.

(I use git mostly for just my own projects, and almost always mostly in sort
of a centralized setup: I've got one bare *the* repository that I clone, and
push to and pull from that rather than between the copies. For a variety of
reasons, I'm pretty sure that model wouldn't work super well for me.)

Thanks,
Evan
