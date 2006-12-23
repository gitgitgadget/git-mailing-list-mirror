From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 23:48:00 +0100
Organization: At home
Message-ID: <emkbhq$amu$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612231655420.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Dec 23 23:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyFcP-0000sz-95
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 23:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbWLWWp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 17:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbWLWWp0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 17:45:26 -0500
Received: from main.gmane.org ([80.91.229.2]:39758 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845AbWLWWp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 17:45:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GyFcG-0003lZ-RN
	for git@vger.kernel.org; Sat, 23 Dec 2006 23:45:21 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 23:45:20 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 23:45:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35332>

Johannes Schindelin wrote:

> On Sat, 23 Dec 2006, Junio C Hamano wrote:

>> Having said that, I think we _could_ do this.
>> 
>> If you (or other people) use branch.*.merge, with its value set
>> to remote name _and_ local name, and actually verify that either
>> form works without confusion, please report back and I'll apply.
> 
> I do not claim to understand your patch (I have no idea if || or && is 
> stronger in shell), but here is another proposition: if the config 
> variable starts with "refs/remotes/", assume it is local.

Why? You can track another repository tracking branches, using it as a kind
of proxy repository, even if it is not bare...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
