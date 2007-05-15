From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newby question about merge.
Date: Tue, 15 May 2007 12:34:55 +0200
Organization: At home
Message-ID: <f2c23k$dm0$1@sea.gmane.org>
References: <20070515113820.2621c8d5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 12:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnuIh-0006Qr-In
	for gcvg-git@gmane.org; Tue, 15 May 2007 12:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331AbXEOKae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 06:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758523AbXEOKae
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 06:30:34 -0400
Received: from main.gmane.org ([80.91.229.2]:44509 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758331AbXEOKad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 06:30:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HnuIS-0004hl-SO
	for git@vger.kernel.org; Tue, 15 May 2007 12:30:24 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 12:30:24 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 12:30:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47336>

[Cc: picca <picca@synchrotron-soleil.Fr>, git@vger.kernel.org]

picca wrote:

> My question is how can I keep the upstream version of the configure
> file instread of the one in the working directory.
> 
> I read about the stage(1:2:3) but I do not know how if it is related to
> my problem.

You can just do "git cat-file -p :2:filename > filename", then
"git add filename" (or "git update-index filename") to resolve conflict.

Check first if :2: is correct file (and not for example :3:).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
