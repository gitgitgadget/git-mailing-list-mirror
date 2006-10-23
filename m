From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white space in a context header.
Date: Mon, 23 Oct 2006 23:06:20 +0200
Organization: At home
Message-ID: <ehjari$vda$1@sea.gmane.org>
References: <87y7r63hq6.fsf@rho.meyering.net> <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 23 23:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc70v-0007Wu-Px
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWJWVHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWJWVHN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:07:13 -0400
Received: from main.gmane.org ([80.91.229.2]:16555 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752002AbWJWVHL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:07:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gc6zi-00079j-Sc
	for git@vger.kernel.org; Mon, 23 Oct 2006 23:06:03 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 23:06:02 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 23:06:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29883>

Linus Torvalds wrote:

> On Mon, 23 Oct 2006, Jim Meyering wrote:
>>
>> This removes trailing blanks from git-generated diff headers
>> the same way a similar patch did that for GNU diff:
> 
> NO!
> 
> This is _wrong_
> 
> You should only remove the space IF IT IS THE ONLY THING ON THE WHOLE 
> LINE!

If I understand the description of this patch given by the mentioned article
and example therein (Jim, you should include appropriate parts of mentioned
email in commit message, not just provide link to it), trailing spaces are
removed from extended diff header, i.e. the "which function are we in",
diff -p header. Not from diff body.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
