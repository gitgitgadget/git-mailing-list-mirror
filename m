From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white space in a context header.
Date: Mon, 23 Oct 2006 23:15:27 +0200
Organization: At home
Message-ID: <ehjbcl$vda$2@sea.gmane.org>
References: <87y7r63hq6.fsf@rho.meyering.net> <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org> <20061023210327.GT20017@pasky.or.cz> <Pine.LNX.4.64.0610231409430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 23 23:16:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc79M-0001bu-FN
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWJWVP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWJWVP4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:15:56 -0400
Received: from main.gmane.org ([80.91.229.2]:47529 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752006AbWJWVPz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:15:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc78w-0001Ul-4p
	for git@vger.kernel.org; Mon, 23 Oct 2006 23:15:35 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 23:15:34 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 23:15:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29885>

Linus Torvalds wrote:

> On Mon, 23 Oct 2006, Petr Baudis wrote:
>> 
>> Not really - mind you, this is only about the diff headers. Actually, it
>> is only about the hunk headers, specifically when we append the function
>> name to the hunk header.
> 
> Ahh. I totally misunderstood, looking at just the diff, and not the bigger 
> context of it.
> 
> Removing whitespace from the "comment" in the hunk header is obviously 
> fine.
> 
> Sorry for the noise.

Well, this points out that commit message was not clear enough.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
