From: Yann Dirson <yann.dirson@bertin.fr>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 07:02:05 +0000 (UTC)
Message-ID: <loom.20100420T085842-887@post.gmane.org>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com> <20100407210010.GB27012@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 09:35:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O47zH-0001zI-VK
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 09:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab0DTHfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 03:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:59116 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab0DTHfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 03:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O47z6-0001v5-5A
	for git@vger.kernel.org; Tue, 20 Apr 2010 09:35:06 +0200
Received: from host.1.68.26.195.rev.coltfrance.com ([host.1.68.26.195.rev.coltfrance.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 09:35:04 +0200
Received: from yann.dirson by host.1.68.26.195.rev.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 09:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.68.26.1 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.1.8) Gecko/20100312 Iceweasel/3.5.8 (like Firefox/3.5.8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145353>

Jeff King <peff <at> peff.net> writes:
> On Wed, Apr 07, 2010 at 12:58:33PM -0400, Avery Pennarun wrote:
> 
> > This is on purpose, based on the theory that you don't want to lose
> > data from your local repo just because someone (accidentally?) deletes
> > a branch on the remote server.  Unfortunately, this theory is a bit
> > flawed, since someone could just as easily overwrite the remote branch
> > with a totally different commit, and you'd still lose it in *that*
> > case.  So mostly it's just confusing.
> 
> You do have a reflog in the case of overwrite. Delete kills off any
> associated reflog (it would be cool if we had a "graveyard" reflog that
> kept deleted branch reflogs around for a while).

Wouldn't it jus be sufficient to keep reflogs on branch deletion, and let reflog
entries subject be expired by gc just like for any branch, so that way we may
only need to gc the reflog itself when it becomes empty ?

-- 
Yann
