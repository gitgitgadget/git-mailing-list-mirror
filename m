From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 09:20:14 +0200
Organization: eudaptics software gmbh
Message-ID: <467B782E.84A6742F@eudaptics.com>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 09:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1dZf-0002KM-QO
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 09:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXFVH2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXFVH2v
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 03:28:51 -0400
Received: from main.gmane.org ([80.91.229.2]:56110 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbXFVH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 03:28:50 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I1dVu-00051i-7r
	for git@vger.kernel.org; Fri, 22 Jun 2007 09:25:04 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 09:25:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 09:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50682>

Adam Mercer wrote:
> [ram@skymoo glue]$ git push
> ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git
> bash: line 1: git-receive-pack: command not found
> fatal: The remote end hung up unexpectedly
> error: failed to push to
> 'ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git'
> [ram@skymoo glue]$ which git-receive-pack
> /Users/ram/opt/git/bin/git-receive-pack
> [ram@skymoo glue]$
> 
> git-receive-pack is in my $PATH so why can't it be found when trying to push?

You must have git installed on the remote end, too.

-- Hannes
