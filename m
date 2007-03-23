From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 15:21:20 +0100
Organization: At home
Message-ID: <eu0njb$q3b$1@sea.gmane.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 16:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUlIA-0004gF-R2
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992445AbXCWPC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992439AbXCWPCz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:02:55 -0400
Received: from main.gmane.org ([80.91.229.2]:54052 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992445AbXCWPCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:02:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HUkyc-0002X2-1F
	for git@vger.kernel.org; Fri, 23 Mar 2007 15:42:46 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 15:42:46 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 15:42:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42936>

Shawn O. Pearce wrote:

> - Assigning repository-wide revision numbers. =A0Git doesn't have
> such a concept, but its key to SVN. =A0These would need to be stored
> in a file so the server can quickly map from revision number to
> Git commit SHA-1. =A0The reflogs may help here, but currently they
> also expire. =A0Any reflog that is being used to do this mapping
> cannot be expired, ever.

Another idea is to use lightweight tags for that, especially now
with packed refs support in git.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
