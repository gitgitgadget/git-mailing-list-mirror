From: Sergei Organov <osv@javad.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 21:06:10 +0400
Message-ID: <871uug7rel.fsf@osv.gnss.ru>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	<loom.20111013T152144-60@post.gmane.org>
	<1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	<loom.20111013T171530-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 19:23:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REP0U-0006gd-5D
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 19:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab1JMRXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 13:23:41 -0400
Received: from javad.com ([65.98.97.82]:43696 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1JMRXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 13:23:41 -0400
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Oct 2011 13:23:40 EDT
Received: from javad.com (localhost.localdomain [127.0.0.1])
	by javad.com (Postfix) with ESMTP id 1C36D3725CC;
	Thu, 13 Oct 2011 17:06:15 +0000 (GMT)
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by javad.com (Postfix) with ESMTP;
	Thu, 13 Oct 2011 17:06:15 +0000 (GMT)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1REOjS-0000jy-1U; Thu, 13 Oct 2011 21:06:10 +0400
In-Reply-To: <loom.20111013T171530-970@post.gmane.org> (arqon@gmx.com's
	message of "Thu, 13 Oct 2011 15:53:07 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183499>

arQon <arqon@gmx.com> writes:

[...]

> Lucky you. :P  The most likely reason for me is, I'm working on something
> and I get interrupted and have to switch. Since the code may well not even
> compile at this point, the last thing I want to do is commit it.

'git stash' is exactly what you need then.

-- Sergei.
