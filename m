From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow INSTALL, bindir, mandir to be set in main Makefile
Date: Thu, 29 Jun 2006 22:16:13 +0200
Organization: At home
Message-ID: <e81ce5$tdq$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <200606291536.18667.jnareb@gmail.com> <200606291704.27677.jnareb@gmail.com> <200606291835.53788.jnareb@gmail.com> <7vy7vfrfc6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 29 22:16:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2w9-0002AX-WD
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWF2UQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWF2UQ0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:16:26 -0400
Received: from main.gmane.org ([80.91.229.2]:13737 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751285AbWF2UQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 16:16:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fw2vx-00027p-Q6
	for git@vger.kernel.org; Thu, 29 Jun 2006 22:16:17 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 22:16:17 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 22:16:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22899>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Part of autoconf series, but independent.
> 
> I'd like to take something like this, independently from
> "optionally managing config.mak with autoconf" series.
> 
>> Should probably be split into two patches:
>>  * first with export + '?='
>>  * second renaming man1 and man7 to man1dir and man7dir
> 
> And I think it is probably a good idea to somehow keep people's
> configurations that have been overriding man1 and man7 if
> possible.  Otherwise things would regress for them.

Done. Resent as two patch "series", starting with
Message-Id: <200606292211.28352.jnareb@gmail.com>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
