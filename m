From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 10:46:33 +0200
Organization: At home
Message-ID: <f5apha$sj7$3@sea.gmane.org>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com> <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 10:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0vq4-0000bh-EN
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 10:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXFTIqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbXFTIqy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 04:46:54 -0400
Received: from main.gmane.org ([80.91.229.2]:34247 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbXFTIqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 04:46:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0vpv-0006A8-9b
	for git@vger.kernel.org; Wed, 20 Jun 2007 10:46:47 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:46:47 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:46:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50549>

Nicolas Pitre wrote:

> But because you push to a local repository (a mounted USB stick is 
> considered a local repo) then you don't get to negociate the pack 
> capabilities of the final destination, and therefore more "bad" delta 
> objects might sneak in again.

So if he pushes over ssh (ssh localhost) he would get capabilities
negotiation, at the cost of being slower?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
