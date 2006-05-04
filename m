From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2
Date: Thu, 04 May 2006 10:32:22 +0200
Organization: At home
Message-ID: <e3ce4j$chl$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 04 10:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbZFL-0001pt-HN
	for gcvg-git@gmane.org; Thu, 04 May 2006 10:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWEDIb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 04:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWEDIb3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 04:31:29 -0400
Received: from main.gmane.org ([80.91.229.2]:13767 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751441AbWEDIb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 04:31:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FbZF7-0001n7-P8
	for git@vger.kernel.org; Thu, 04 May 2006 10:31:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 May 2006 10:31:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 May 2006 10:31:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19557>

Junio C Hamano wrote:

> * #irc 2006-04-10
>   Shallow clones (Carl Worth).
> 
>   The experiment last round did not work out very well, but as
>   existing repositories get bigger, and more projects being
>   migrated from foreign SCM systems, this would become a
>   must-have from would-be-nice-to-have.
> 
>   I am beginning to think using "graft" to cauterize history
>   for this, while it technically would work, would not be so
>   helpful to users, so the design needs to be worked out again.

Perhaps use comment for marking graft as cauterizing history?

There was also talk about proposed git-splithist, which would move some of
the history to other (historical, archive) repository.

-- 
Jakub Narebski
Warsaw, Poland
