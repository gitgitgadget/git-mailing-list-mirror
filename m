From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 16:17:51 +0000 (UTC)
Message-ID: <loom.20111013T175500-495@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <loom.20111013T141239-151@post.gmane.org> <20111013144450.GA2856@victor.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 18:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RENz3-0001Bm-BK
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 18:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab1JMQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 12:18:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:52882 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab1JMQSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 12:18:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RENyv-000170-V4
	for git@vger.kernel.org; Thu, 13 Oct 2011 18:18:05 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 18:18:05 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 18:18:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183495>

Victor Engmark <victor.engmark <at> terreactive.ch> writes:
> 1. `checkout master` and commit the fix there, then shift back and
> continue working

I absolutely agree. And it's far more common than any of us would like.
My point is, you *can't* do this in git without first staging your current branch
via either commit or stash, or you risk changes bleeding between the branches
and/or work being lost irretrievably. This is not something that you would
expect, and as you say:

> The second most important thing a VCS should do is not destroy any of your
uncommitted work unless you tell it to

... which is exactly what git does, and why I have a problem with it.
But the response here is uniformly "that's just how git is", so obviously it's
something you learn to become aware of over time, and avoid. It's not going to
get "fixed", because people who are used to git don't see it as a bug, so I just
have to decide whether I can live with it or not.
