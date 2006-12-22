From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 09:28:43 +0100
Organization: At home
Message-ID: <emg4qp$f8v$2@sea.gmane.org>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 22 09:30:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfnG-000775-0V
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945981AbWLVIaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945985AbWLVIaO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:30:14 -0500
Received: from main.gmane.org ([80.91.229.2]:60027 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945981AbWLVIaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:30:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gxfn0-0000hM-Pb
	for git@vger.kernel.org; Fri, 22 Dec 2006 09:30:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 09:30:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 09:30:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35144>

Junio C Hamano wrote:

> (1) Why is this needed?

Probably for completeness.

> (2) What does this do when the index is unmerged?

I think it should show "git ls-files --unmerged --abbrev", perhaps...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
