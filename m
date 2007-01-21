From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: make rpm
Date: Sun, 21 Jan 2007 19:44:41 +0100
Organization: At home
Message-ID: <ep0c9d$tph$1@sea.gmane.org>
References: <Pine.LNX.4.64.0701211325250.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jan 21 19:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8hgF-0002fR-Eg
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 19:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXAUSog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAUSog
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 13:44:36 -0500
Received: from main.gmane.org ([80.91.229.2]:51468 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbXAUSog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 13:44:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8hfy-0008Bf-Mm
	for git@vger.kernel.org; Sun, 21 Jan 2007 19:44:22 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 19:44:22 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 19:44:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37335>

[Cc: git@vger.kernel.org]

Nicolas Pitre wrote:

> I just tried 'make rpm' and it died with:
> 
> |rpmbuild -ta git-1.5.0.rc2.tar.gz
> |error: Failed build dependencies:
> |        perl(Error) is needed by git-1.5.0.rc2-1.i386
> 
> Of course I have perl installed.  But what is that "perl(Error)" about?

You don't have Error.pm perl module (in perl-Error package in Fedora Core).
Git distributes it's own copy, but I guess rpm target requires to have it
installed rather than provide it ourself.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
