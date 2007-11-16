From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Fri, 16 Nov 2007 09:43:11 +0100
Organization: At home
Message-ID: <fhjl70$db4$1@ger.gmane.org>
References: <473D3593.9080806@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 09:43:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iswnm-00051m-1C
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 09:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbXKPInd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 03:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXKPInd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 03:43:33 -0500
Received: from main.gmane.org ([80.91.229.2]:52863 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbXKPInc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 03:43:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IswnI-0004sI-LI
	for git@vger.kernel.org; Fri, 16 Nov 2007 08:43:20 +0000
Received: from aabk102.neoplus.adsl.tpnet.pl ([83.4.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 08:43:20 +0000
Received: from jnareb by aabk102.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 08:43:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: aabk102.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65205>

[Cc: Dan Zwell <dzwell@gmail.com>, Petr Baudis <pasky@suse.cz>,
     git@vger.kernel.org]

Dan Zwell wrote:

> Previously, the Git->repository()->config('non-existent.key')
> evaluated to as true in a vector context. Return an empty list
> instead.

Nice.

By the way, what do you think about changing Git.pm config handling
to the 'eager' one used currently by gitweb, namely reading all the
config to hash, and later getting config values from hash instead of
calling git-config? Or at least make it an option?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
