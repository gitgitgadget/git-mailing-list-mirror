From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 11:27:25 +0100
Organization: At home
Message-ID: <esu11i$m54$1@sea.gmane.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 11:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPylb-0000DG-Uy
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 11:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbXCJKZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbXCJKZK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 05:25:10 -0500
Received: from main.gmane.org ([80.91.229.2]:49331 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbXCJKZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 05:25:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HPyl1-0001sp-Un
	for git@vger.kernel.org; Sat, 10 Mar 2007 11:24:59 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 11:24:59 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 11:24:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41863>

Shawn O. Pearce wrote:

> One thing that you could do is segment the repository into multiple
> packfiles yourself, and then clone using rsync or http, rather than
> using the native Git protocol.

By the way, it would be nice to have talked about fetch / clone
support for sending (and creating) _multiple_ pack files. Beside
the situation where we must use more than one packfile because
of size limits, it would also help clone as it could send existing
packs and pack only loose objects (trading perhaps some bandwidth
with CPU load on the server; think kernel.org).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
