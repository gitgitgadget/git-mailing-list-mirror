From: Miles Bader <miles@gnu.org>
Subject: Re: Newbie in Git. How to get back from last pull?
Date: Sun, 01 Aug 2010 18:14:35 +0900
Message-ID: <87bp9mbsp0.fsf@catnip.gol.com>
References: <1280649966984-5360499.post@n2.nabble.com>
	<20100801083000.GF26006@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 11:14:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfUdB-0005ny-Dp
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 11:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab0HAJOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 05:14:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:45555 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab0HAJOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 05:14:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OfUd2-0005k3-5v
	for git@vger.kernel.org; Sun, 01 Aug 2010 11:14:44 +0200
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 11:14:44 +0200
Received: from miles by 218.231.154.125.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 11:14:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.154.125.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:9r/i119vPGQGLnMxPGb/Ajl/8oo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152372>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> I don't understand exactly what you want to do, but here are the
> basics- you can decide what you want to do.
> 1. Use `git reflog` to see a history of your operations.
> 2. If you want your working copy to switch to an existing commit, use
>    `git checkout <SHA1 of commit>`.
> 3. If you want to irreversibly destroy everything and switch your
>    working copy to a desired commit, use `git reset --hard <SHA1 of
>    commit>`. Use with care!

... and:  0. In "emergency recovery situations", _back up your whole
source dir (including .git subdir) somewhere else before screwing
around_!

E.g., "cp -a my_src_dir /somewhere_else/my_src_dir_backup"

-Miles

-- 
Pray, v. To ask that the laws of the universe be annulled in behalf of a
single petitioner confessedly unworthy.
