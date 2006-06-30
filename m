From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Fri, 30 Jun 2006 17:15:10 +0200
Organization: At home
Message-ID: <e83f5j$e6f$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <E1FvvuX-0002Lr-Nt@moooo.ath.cx> <e80lnq$9mi$1@sea.gmane.org> <44A51693.5020501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 17:15:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKiY-0000LK-Cl
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 17:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWF3PPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 11:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWF3PPf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 11:15:35 -0400
Received: from main.gmane.org ([80.91.229.2]:49577 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932182AbWF3PPe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 11:15:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwKiC-0000HL-VG
	for git@vger.kernel.org; Fri, 30 Jun 2006 17:15:16 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 17:15:16 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 17:15:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22994>

Andreas Ericsson wrote:

> grep -q autogen config.mak || \
>       echo "-include config.mak.autogen" >> config.mak
> 
> I wouldn't want my long-standing, functioning config.mak overwritten, 
> but I *might* be interested in trying some of the options provided by 
> ./configure.

Thanks for the solution. Done in my latest patch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
