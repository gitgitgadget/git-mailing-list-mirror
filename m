From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to create independent branches
Date: Sat, 08 Apr 2006 20:28:58 +0200
Organization: At home
Message-ID: <e18vcv$rhf$1@sea.gmane.org>
References: <20060407184701.GA6686@xp.machine.de> <7vr749i48s.fsf@assigned-by-dhcp.cox.net> <20060408180244.GA4807@xp.machine.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Apr 08 20:29:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSIBb-0000ca-2c
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDHS3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 14:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWDHS3H
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 14:29:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751417AbWDHS3G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 14:29:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FSIB6-0000Wv-5P
	for git@vger.kernel.org; Sat, 08 Apr 2006 20:28:56 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Apr 2006 20:28:56 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Apr 2006 20:28:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18521>

Peter Baumann wrote:

> Another question. I'd like to create a totaly independent branch (like
> the "todo" branch in git). Is there a more user friendly way than doing
> 
> git-checkout -b todo
> rm .git/refs/heads/todo
> rm .git/index
> rm <all_files_in_your_workdir>
> 
> ... hack hack hack ...
> git-commit -a

Wouldn't it be better and more natural to go back to first commit, or even
empty repository state at the beginning, and branch there? Or make separate
repository?

-- 
Jakub Narebski
Warsaw, Poland
