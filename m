From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git --trace: trace command execution
Date: Thu, 29 Jun 2006 20:06:21 +0200
Organization: At home
Message-ID: <e814qm$sa$1@sea.gmane.org>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 29 20:09:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw0wc-0005b2-Up
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWF2SIr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWF2SIr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:08:47 -0400
Received: from main.gmane.org ([80.91.229.2]:19096 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751228AbWF2SIq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:08:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fw0vI-0005Kc-LL
	for git@vger.kernel.org; Thu, 29 Jun 2006 20:07:29 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 20:07:28 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 20:07:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22879>

Junio C Hamano wrote:

> By the way "git cat-file -p" or "git verify-tag -v" might be
> more pleasant to view a tag since they make the tagger timestamp
> human readable.

Interesting, -p makes tagger timestamp human readable, but not author or
commiter:

$ git cat-file -p `cat .git/refs/tags/v1.4.0`
tagger Junio C Hamano <junkio@cox.net> Sat Jun 10 12:43:37 2006 -0700

$ git cat-file -p `cat .git/refs/heads/origin`
author Johannes Schindelin <Johannes.Schindelin@gmx.de> 1151491527 +0200
committer Junio C Hamano <junkio@cox.net> 1151492136 -0700

Is it intended, or a bug/missing feature (git 1.4.0)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
