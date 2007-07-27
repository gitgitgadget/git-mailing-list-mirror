From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 11:11:13 +0200
Message-ID: <86lkd2mcsu.fsf@lola.quinscape.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz> <20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz> <20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz> <20070727054815.GJ20052@spearce.org> <85ejiu5r9r.fsf@lola.goethe.zz> <86k5smnvhw.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 11:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IELrM-0003aF-DL
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 11:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761081AbXG0JLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 05:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759211AbXG0JLg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 05:11:36 -0400
Received: from main.gmane.org ([80.91.229.2]:47418 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760851AbXG0JLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 05:11:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IELr6-0001FC-G0
	for git@vger.kernel.org; Fri, 27 Jul 2007 11:11:28 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 11:11:28 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 11:11:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:tzCzWuLQig3hePgZC+ANfWsJOuk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53910>

David Kastrup <dak@gnu.org> writes:

> Now that is funny.  I am pretty sure (or rather _have_ been pretty
> sure) that I cloned the respective repositories with the same command.
> Yet now both are up-to-date according to git-pull (and have identical
> .config contents), and the first compiles version git version
> 1.5.3.rc2.41.gb47b1 while the second compiles version
> 1.5.3.rc3.7.gd58e-dirty.  Both have been cloned from git.git, the

A combination of rebasing and pushing made the difference go away and
made git-gui work again.  Nevertheless, it would be a good idea not to
balk at the dirty version strings.

-- 
David Kastrup
