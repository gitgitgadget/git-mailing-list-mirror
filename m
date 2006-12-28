From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Teach git-reset to let others override its reflog entry.
Date: Thu, 28 Dec 2006 12:52:38 +0100
Organization: At home
Message-ID: <en0b0n$bjm$2@sea.gmane.org>
References: <20061228014336.GA16790@spearce.org> <7vslf0zgwp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 28 12:50:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gztlz-0003Er-3q
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 12:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWL1LuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 06:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbWL1LuH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 06:50:07 -0500
Received: from main.gmane.org ([80.91.229.2]:38014 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbWL1LuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 06:50:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gztlq-0006Ay-6A
	for git@vger.kernel.org; Thu, 28 Dec 2006 12:50:02 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:50:02 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:50:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35555>

Junio C Hamano wrote:

> Then calls to "git-update-ref -m" could use the value of
> "$GIT_REFLOG_ACTION", without explicit --reflog-action=
> parameters and $rloga variables.

I think that --reflog-action should then be used to set GIT_REFLOG_ACTION,
slightly similarly to how --git-dir sets GIT_DIR variable.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
