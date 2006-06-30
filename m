From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: boolean expression on pattern matching.
Date: Fri, 30 Jun 2006 12:24:32 +0200
Organization: At home
Message-ID: <e82u4l$fvb$1@sea.gmane.org>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <7vsllnj6rh.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 12:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwGBg-0006g6-I9
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 12:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWF3KZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 06:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWF3KZO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 06:25:14 -0400
Received: from main.gmane.org ([80.91.229.2]:35777 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750990AbWF3KZN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 06:25:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwGAk-0006YH-Lw
	for git@vger.kernel.org; Fri, 30 Jun 2006 12:24:26 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 12:24:26 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 12:24:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22977>

Junio C Hamano wrote:

> This extends the behaviour of git-grep when multiple -e options
> are given.  So far, we allowed multiple -e to behave just like
> regular grep with multiple -e, i.e. the patterns are OR'ed
> together.
> 
> With this change, you can also have multiple patterns AND'ed
> together, or form boolean expressions, like this (the
> parentheses are quoted from the shell in this example):
> 
>       $ git grep -e _PATTERN --and \( -e atom -e token \)

And where is documentation update?
 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
