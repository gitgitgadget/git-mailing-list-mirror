From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 20:55:12 +0200
Organization: At home
Message-ID: <eek5l4$kaa$1@sea.gmane.org>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com> <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net> <450D9847.4080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 20:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP1nS-0006Cl-Or
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 20:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWIQSzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWIQSzL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 14:55:11 -0400
Received: from main.gmane.org ([80.91.229.2]:58792 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932364AbWIQSzK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 14:55:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GP1n2-00066S-6Y
	for git@vger.kernel.org; Sun, 17 Sep 2006 20:54:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 20:54:52 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 20:54:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27200>

A Large Angry SCM wrote:

> There is no fundamental reason Git can not support partial 
> checkouts/working directories. In fact, there is no fundamental reason 
> Git can not support operations on partial (sparse?) repositories in both 
> space (working content/state, etc.) and time (history); it's just a 
> matter of record keeping[*1*]. That isn't how the Linux kernel 
> developers want to use their VCS but it _is_ how others want to use
> theirs. 

There is perhaps not much trouble with partial checkouts, but there is
problem with partial _commits_, at least for snapshot based SCM (as opposed
to patchset based SCM). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
