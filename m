From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 21:58:48 +0200
Organization: At home
Message-ID: <ees6hl$jdv$1@sea.gmane.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 22:00:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ8Er-0003WM-Rg
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 22:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWITUAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 16:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWITUAF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 16:00:05 -0400
Received: from main.gmane.org ([80.91.229.2]:52966 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932353AbWITUAD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 16:00:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQ8EA-0003KY-Nf
	for git@vger.kernel.org; Wed, 20 Sep 2006 21:59:31 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 21:59:26 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 21:59:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27396>

Petr Baudis wrote:

> Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...

>> However, you can tell git that Jeff is being difficult by marking such 
>> branches individually as being rebased.
> 
> This is really a wrong way of describing the problem - I'd say that Git
> is being difficult here. The point is, the subsystem maintainers need to
> maintain stacks of patches and rebase against the main kernel branch
> regularily, and they want to still publish their current state. So it's
> not really any of them being strange or difficult, but Git being so
> because it has no seamless support for tracking those branches.

There was idea around moving remotes configuration to config file to have
some per branch configureation, including readonly for protecting tracking
branches, marking default branch for merge with (and which tracking
branch(es) to merge)...

...and that included marking branch _on the server side_ as being rebased,
i.e. without preserved history. Unfortunately, the discussion petered out
without changes to git. Branch marked as pu-like would either get '+'
in appropriate Pull line in remotes file generated during clone, or they
wouldn't need '+'.

By the way, there is '--force' option to git-pull/git-fetch...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
