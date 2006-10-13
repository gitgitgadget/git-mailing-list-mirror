From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 14:39:47 +0200
Organization: At home
Message-ID: <ego1ea$tsn$1@sea.gmane.org>
References: <87y7rk3b9n.fsf@gmail.com> <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net> <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com> <Pine.LNX.4.63.0610131324090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 13 14:41:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYML4-0006zn-HH
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 14:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWJMMk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 08:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWJMMk2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 08:40:28 -0400
Received: from main.gmane.org ([80.91.229.2]:45237 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751661AbWJMMk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 08:40:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYMKb-0006tp-4d
	for git@vger.kernel.org; Fri, 13 Oct 2006 14:40:05 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 14:40:05 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 14:40:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28837>

Johannes Schindelin wrote:

> There is a subtle problem here. Up until now, "remote" meant a short cut. 
> You either had a file with that name in .git/remotes/ or .git/branches, or 
> an entry in the config (remote.<name>.url).

Not exactly. "git-pull . <branch>" and "git-peek-remote ." meant use
_current_ repository. "." as remote name means "current", i.e. local 
repository.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
