From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to checkout a tag?
Date: Fri, 06 Oct 2006 09:32:16 +0200
Organization: At home
Message-ID: <eg50om$7rs$1@sea.gmane.org>
References: <4524E2D5.3030907@garzik.org> <4524E72D.9030101@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 09:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVkCB-0003S1-Hr
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 09:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWJFHcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 03:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJFHcc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 03:32:32 -0400
Received: from main.gmane.org ([80.91.229.2]:30090 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751367AbWJFHcb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 03:32:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVkBj-0003JW-Se
	for git@vger.kernel.org; Fri, 06 Oct 2006 09:32:08 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:32:07 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:32:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28389>

Andy Whitcroft wrote:

> Jeff Garzik wrote:
>> 
>> Sometimes I receive a kernel patch based off an older version of the
>> kernel, for example a 2.6.18 patch when the current kernel is 2.6.19-rc1.
>> 
>> I would like to create a branch starting at 2.6.18, merge the patch, and
>> then merge up to the current kernel.
>> 
>> How does one check out a tag, or create a branch based on a tag's
>> starting point?
> 
> A tag is a ref like any other:
> 
>       git checkout -b branchname tag

Which is a shortcut for
        git branch branchname tag
        git checkout branchname

You cannot checkout a tag [object], because branch has to be able to move
forward to the new commit when you commit changes,

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
