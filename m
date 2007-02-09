From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: restriction of pulls
Date: Fri, 09 Feb 2007 12:19:05 +0100
Organization: At home
Message-ID: <eqhl87$ut3$1@sea.gmane.org>
References: <200702091149.12462.duelli@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 12:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFTlM-0006dI-UD
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 12:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946367AbXBILRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 06:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946362AbXBILRy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 06:17:54 -0500
Received: from main.gmane.org ([80.91.229.2]:57517 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946367AbXBILRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 06:17:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFTl7-0003Zk-5j
	for git@vger.kernel.org; Fri, 09 Feb 2007 12:17:41 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:17:41 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:17:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39177>

Christoph Duelli wrote:

> Is it possible to restrict a chechout, clone or a later pull to some 
> subdirectory of a repository?
> (Background: using subversion (or cvs), it is possible to do a file or 
> directory-restricted update.)
> 
> Say, I have a repository containing 2 (mostly) independent projects
> A and B (in separate) directories:
> - R
>   -  A
>   -  B
> Is it possibly to pull all the changes made to B, but not those made to A. 
> (Yes, I know that this causes trouble if there are dependencies into A.)

No, it is not possible. Moreover, it is not sensible, as it breaks atomicity
of a commit. Well, you can hack, but...

That said, there is experimental submodule (subproject) support
  http://git.or.cz/gitwiki/SubprojectSupport
  http://git.admingilde.org/tali/git.git/module2
(there was also proposal of more lightweight submodule support, but I don't
have a link to it), and you should have set A and B as submodules
(subprojects).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
