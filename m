From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: what's the current wisdom on git over NFS/CIFS?
Date: Thu, 2 Jul 2009 13:11:04 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 15:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMM4V-0004oy-0t
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 15:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZGBNLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 09:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZGBNLQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 09:11:16 -0400
Received: from main.gmane.org ([80.91.229.2]:47527 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbZGBNLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 09:11:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMM4L-0006ZI-Ny
	for git@vger.kernel.org; Thu, 02 Jul 2009 13:11:17 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 13:11:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 13:11:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122644>

Hi all,

A couple of us were beating each other senseless on this
issue over on #git, so I thought I'd ask: is it OK to do
this?  Or would there potential be race conditions due to
the lack of proper locking?

The git faq says SMBFS is not recommended.  Searching for
"git on NFS" gets me too many hits about the NFS _code_ :-)

Thanks,

Sitaram
