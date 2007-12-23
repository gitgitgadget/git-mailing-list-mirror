From: David Soria Parra <sn_@gmx.net>
Subject: Re: cvsimport: trying to convert freebsd cvs to git
Date: Sun, 23 Dec 2007 13:06:05 +0100
Message-ID: <fklivc$cio$1@ger.gmane.org>
References: <20071222171801.GE15286@genesis.frugalware.org> <pan.2007.12.23.01.47.29@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 13:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Pbg-0002vH-Oc
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 13:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbXLWMGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 07:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXLWMGg
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 07:06:36 -0500
Received: from main.gmane.org ([80.91.229.2]:42387 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXLWMGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 07:06:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J6PbA-0002PY-K7
	for git@vger.kernel.org; Sun, 23 Dec 2007 12:06:28 +0000
Received: from p57aeca0c.dip.t-dialin.net ([87.174.202.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 12:06:28 +0000
Received: from sn_ by p57aeca0c.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 12:06:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57aeca0c.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <pan.2007.12.23.01.47.29@progsoc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69175>


> If you have access to the raw ",v" files as you do, I would suggest you 
> try out parsecvs. It will not do incremental imports but will you a good 
> idea of how you can expect the converted repository to behave / act.


ParseCVS works out fine with the PHP repository for us while cvsimport
has some problems with branches. For me it looks like doing parsecvs on
an existing repository tries to check all ,v files but in fact producing
a more or less incremental update.

If you try to use parsecvs make sure that your branchname doesnot
contain / or ~ as this will cause an error on parsecvs. If you need it,
we have a simple patch for that with a small workaround on that.
