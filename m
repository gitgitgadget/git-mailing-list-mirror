From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Misc doc improvements
Date: Wed, 07 Jun 2006 20:46:03 +0200
Organization: At home
Message-ID: <e676st$fpm$1@sea.gmane.org>
References: <20060607183233.GA21448@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 07 20:47:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo33D-0006sP-DV
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWFGSqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWFGSqk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:46:40 -0400
Received: from main.gmane.org ([80.91.229.2]:9452 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751141AbWFGSqk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 14:46:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fo32j-0006lu-4r
	for git@vger.kernel.org; Wed, 07 Jun 2006 20:46:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 20:46:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 20:46:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21452>

Jonas Fonseca wrote:

> +grafts::
> +     Grafts enables two otherwise different lines of development to be
> +     joined together by recording fake ancestry information for commits.
> +     This way you can make git pretend the set of parents a commit
> +     has is different from what was recorded when the commit was created.
> +     Configured via the `.git/info/grafts` file.

Actually, grafts are used to "fake" (or change) parents (ancestry) of an
existing commit. It can be used both to add parents (e.g. joining roots of
"current" repository with historical one), or remove parents (e.g. to
shorten (cauterize) history like in the "shalllow clone" idea).

-- 
Jakub Narebski
Warsaw, Poland
