From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] format-patch: Generate a newline between the subject header and the message body.
Date: Thu, 13 Jul 2006 21:38:48 +0200
Organization: At home
Message-ID: <e967en$bi6$1@sea.gmane.org>
References: <44B6369D.6070602@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jul 13 21:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G171P-0003aK-SY
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 21:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWGMTir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWGMTir
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 15:38:47 -0400
Received: from main.gmane.org ([80.91.229.2]:5522 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030329AbWGMTiq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 15:38:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G1717-0003Vz-9K
	for git@vger.kernel.org; Thu, 13 Jul 2006 21:38:33 +0200
Received: from host-81-190-20-193.torun.mm.pl ([81.190.20.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 21:38:33 +0200
Received: from jnareb by host-81-190-20-193.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 21:38:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-193.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23844>

Robert Shearman wrote:

> 
> format-patch previously didn't generate a newline after a subject. This 
> caused the diffstat to not be displayed in messages without a blank line 
> and the first blank line to be eaten in messages with a blank line.

Does this _enforce_ separating commit message into subject+empty
line+description? What about commit messages without this structire (e.g.
legacy commit messages from import from other SCM, e.g. GNU ChangeLog
style)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
