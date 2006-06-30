From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 21:11:31 +0200
Organization: At home
Message-ID: <e83t0m$4s0$2@sea.gmane.org>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net> <E1FwMPf-0005XA-N9@moooo.ath.cx> <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org> <E1FwN7M-0007GI-Ng@moooo.ath.cx> <e83p0q$dla$1@sea.gmane.org> <7v1wt6ik4x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 21:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwOPD-000392-Mg
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 21:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbWF3TLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWF3TLw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 15:11:52 -0400
Received: from main.gmane.org ([80.91.229.2]:19685 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933088AbWF3TLv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 15:11:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwOOu-00036t-2b
	for git@vger.kernel.org; Fri, 30 Jun 2006 21:11:36 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 21:11:36 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 21:11:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23015>

Junio C Hamano wrote:

> The --near Matthias talk about is syntactically not like --and
> but more like --not.  It takes a condition for a line after
> that, and loosens it to cover nearby lines.  So "-e A"
> means "the line must have A on it" but "--near -e A" means "the
> line must be nearby a line that satisfies `-e A'".
> 
> Matthias's "--near EXP" is spelled as "-e '' --near EXP" (the
> first one is always true) with our syntax, in other words.
> 
> I do not think either of these semantics is invalid; they are
> just different.  The version by Matthias is more general and
> more expressive.

It also uses the fact that grep search for _lines_, the fact I have forgot
about. But if we cannot search for multiline regexp using git-grep,
Matthias version is truly more expressive, especially with context limiting
extension. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
