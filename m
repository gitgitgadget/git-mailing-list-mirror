From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 13:03:17 +0200
Organization: At home
Message-ID: <e0tjpk$ktu$1@sea.gmane.org>
References: <4430D352.4010707@vilain.net> <7vsloucuxk.fsf@assigned-by-dhcp.cox.net> <4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 04 13:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQjJu-0008MF-Bz
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 13:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWDDLDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 07:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWDDLDb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 07:03:31 -0400
Received: from main.gmane.org ([80.91.229.2]:21145 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751853AbWDDLDb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 07:03:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQjJo-0008LV-FV
	for git@vger.kernel.org; Tue, 04 Apr 2006 13:03:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 13:03:28 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 13:03:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18386>

Andreas Ericsson wrote:

> Wouldn't "git commit -M -b topic", for committing to a different branch
> than what is checked out (-b) and also to the checked out branch (-M)
> have the same beneficial effects, but without the complexity of hydras
> and patch dependency theory? It would only remove the cherry-pick stage
> though, but perhaps it's good enough. Although when I think about it, -b
> <branch> for committing to another branch and -B <branch> for doing the
> above probably makes more sense.

Do you mean that you commit current state to the checked out (working)
branch, and commit *changes* (i.e. apply patch) to a different branch?

-- 
Jakub Narebski
Warsaw, Poland
