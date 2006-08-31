From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 14:24:55 +0200
Organization: At home
Message-ID: <ed6ken$8e8$1@sea.gmane.org>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 14:26:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIlcL-0001HY-OA
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHaMZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHaMZy
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:25:54 -0400
Received: from main.gmane.org ([80.91.229.2]:41900 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751238AbWHaMZx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 08:25:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIlbn-00017o-Pl
	for git@vger.kernel.org; Thu, 31 Aug 2006 14:25:23 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 14:25:23 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 14:25:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26254>

Johannes Schindelin wrote:

> since you do have a recent snapshot, why not try ./configure, as Pasky 
> suggested?
> 
> BTW I cannot read Finnish, but (...)

So when sending error codes it would be better to set LC_ALL=C (or
equivalent) before producing and sending error message.

> (...) it probably says that you do not have curl 
> installed. configure would detect that, and automatically set NO_CURL=1.

Without curl http:// and https:// transports won't work. So you perhaps want
to install curl instead.

>From INSTALL:
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead

        $ make configure ;# as yourself, if configure does not exist
        $ ./configure --prefix=/usr ;# as yourself
        $ make all doc ;# as yourself
        # make install install-doc ;# as root

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
