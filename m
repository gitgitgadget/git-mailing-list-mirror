From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 18:11:27 +0100
Organization: eudaptics software gmbh
Message-ID: <45F589BF.28E3A5AD@eudaptics.com>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu> <200703121634.l2CGYtGx027263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 18:11:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQo3g-0002yD-Qo
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030718AbXCLRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbXCLRLh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:11:37 -0400
Received: from main.gmane.org ([80.91.229.2]:40719 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030718AbXCLRLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:11:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HQo3Q-0002BM-VU
	for git@vger.kernel.org; Mon, 12 Mar 2007 18:11:24 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 18:11:24 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 18:11:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42040>

Xavier Maillard wrote:
> -> D -> E -> F -> several commits from old master -> HEAD (of new master)
> 
> So it seems to be cherry-picks + rebase master on new HEAD but I
> am not sure at how things are doing :)

Just to get the wording straight: You mean "reset master to new HEAD",
not "rebase". "reset" means to point the branch identifier ("master") to
some commit - with or without modifying the working directory
accordingly. OTOH, "rebase" means to re-apply a string of commits on top
of some other commit.

-- Hannes
