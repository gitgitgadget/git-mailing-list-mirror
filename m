From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Thu, 17 Aug 2006 11:41:43 +0200
Organization: At home
Message-ID: <ec1dis$823$3@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 17 11:41:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeN9-0004us-K7
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWHQJlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWHQJlE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:43406 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964786AbWHQJlC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:41:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDeN1-0004tb-JC
	for git@vger.kernel.org; Thu, 17 Aug 2006 11:40:59 +0200
Received: from host-81-190-24-196.torun.mm.pl ([81.190.24.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:40:59 +0200
Received: from jnareb by host-81-190-24-196.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:40:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-196.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25575>

Martin Waitz wrote:

> Project list and OPML generation are now hooked into the list as
> "/summary" and "/opml".

It would be better to use "/list" or "/projects", although empty or undef or
"/" action would work as well.

Having both "/summary" (for projects list) and "summary" (for project
summary) is bad, bad idea.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
