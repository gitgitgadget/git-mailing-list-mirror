From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 20:22:21 +0200
Organization: At home
Message-ID: <e86ega$gnc$1@sea.gmane.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 01 20:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwk6n-0000V8-WC
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWGASWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGASWT
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:22:19 -0400
Received: from main.gmane.org ([80.91.229.2]:48273 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751414AbWGASWS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 14:22:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fwk6b-0000Sk-NI
	for git@vger.kernel.org; Sat, 01 Jul 2006 20:22:09 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 20:22:09 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 20:22:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23055>

J. Bruce Fields wrote:

> On Sat, Jul 01, 2006 at 05:09:26PM +0200, Rene Scharfe wrote:
>> +Another special notation is <commit1>...<commit2> which is useful for
>> +merges.  The resulting set of commits is the symmetric difference
>> +between the two operands.  The following two commands are equivalent:
> 
> What's the logic behind naming the operator "..."?
> 
> Seems like asking for trouble to have two visually similar operators (".." and
> "...") with different meanings, and "..." seems like kind of an arbitrary
> choice anyway.

Because A...B is extension of A..B for merges.

> A symmetric difference is basically equivalent to an xor--would a carat ("^")
> work?  Or could we just stick a word there instead of using some tricky
> notation?

Caret is used twice, with different meaning. As prefix operator "^" means 
"exclude lineage of commit" (while commit without "^" in front means:
"include lineage of commit and commit itself"). BTW. why we don't use '!'
for that?

As postfix operator "^" means "dereference", i.e. parent in the case 
of commit; allows choosing a parent (commit^n) and listing all parents 
(commit^@). Using it as binary infix operator that would be I think 
too much. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
