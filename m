From: Jingzhao Ou <jingzhao.ou@gmail.com>
Subject: Re: Unable to delete remote branch with a strange name
Date: Tue, 28 Dec 2010 16:10:14 +0000 (UTC)
Message-ID: <loom.20101228T170808-756@post.gmane.org>
References: <loom.20101228T080344-503@post.gmane.org> <m2hbdy9top.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 17:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXc8V-00046s-La
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 17:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab0L1QKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 11:10:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:49063 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab0L1QKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 11:10:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PXc86-0003s3-9a
	for git@vger.kernel.org; Tue, 28 Dec 2010 17:10:30 +0100
Received: from adsl-99-60-231-4.dsl.pltn13.sbcglobal.net ([99.60.231.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 17:10:30 +0100
Received: from jingzhao.ou by adsl-99-60-231-4.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 17:10:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.60.231.4 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164273>

Andreas Schwab <schwab <at> linux-m68k.org> writes:
> 
> Jingzhao Ou <jingzhao.ou <at> gmail.com> writes:
> 
> > I guess somehow, git is confused by "origin/dev/main" and 
> > "origin/remotes/origin/dev/main". Especially, it cannot identify the latter
> > properly.
> 
> Try fully qualifying the remote branch (beginning with refs/heads/).
> 
> Andreas.
> 

Hi, Andreas,

Yes, using the absolute path works like a champ! 

git push origin :refs/heads/remotes/origin/dev/main

Thanks a lot for your help!

Jingzhao
