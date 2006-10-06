From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: [commit view] Do not suppress commitdiff link in root commit
Date: Fri, 06 Oct 2006 22:57:05 +0200
Organization: At home
Message-ID: <eg6fti$ffc$1@sea.gmane.org>
References: <20061006165933.4127.72491.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 22:57:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVwko-0000rP-CA
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 22:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWJFU5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbWJFU5H
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 16:57:07 -0400
Received: from main.gmane.org ([80.91.229.2]:42730 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422956AbWJFU5E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 16:57:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVwkW-0000mR-Tz
	for git@vger.kernel.org; Fri, 06 Oct 2006 22:56:53 +0200
Received: from host-81-190-26-229.torun.mm.pl ([81.190.26.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 22:56:52 +0200
Received: from jnareb by host-81-190-26-229.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 22:56:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-229.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28444>

Petr Baudis wrote:

> There's no reason for that, the commitdiff view is meaningful for the
> root commit as well and we link to it everywhere else.

It not used to be. It is since we added '--root' as hash_parent ('hp')
parameter for parentless commits.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
