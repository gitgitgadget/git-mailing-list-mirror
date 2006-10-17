From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Delete ref $frotz by moving ref file to "deleted-$frotz~ref".
Date: Tue, 17 Oct 2006 11:24:24 +0200
Organization: At home
Message-ID: <eh27f9$uog$1@sea.gmane.org>
References: <20061014153949.2994a114.chriscool@tuxfamily.org> <7vr6xa91kj.fsf@assigned-by-dhcp.cox.net> <200610170626.25654.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 17 11:24:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlBI-0006MJ-Sz
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187AbWJQJYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423186AbWJQJYM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:24:12 -0400
Received: from main.gmane.org ([80.91.229.2]:51175 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423184AbWJQJYL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 05:24:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZlB2-0006K0-NT
	for git@vger.kernel.org; Tue, 17 Oct 2006 11:24:00 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:24:00 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:24:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29040>

Christian Couder wrote:

>> Ref deletion is an operation that happens far far rarer than
>> updates and lookups, and I deliberately chose to optimize for
>> the latter.
> 
> I think that the ref deletion usage depends on the policy of people using 
> git, and there may be people that delete a ref very often.
> 
> For example, when git becomes a major SCM, there may be people working on 
> big projects that want to create a new branch for each new bug and then 
> delete the branch when the code on the bug branch has been integrated into 
> a new release and the bug is closed.

So do not pack branches then, pack only tags.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
