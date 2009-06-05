From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: preventing checking out remote branch in gitk
Date: Fri, 5 Jun 2009 15:21:41 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh2ie05.8mr.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 17:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbFG-0005tG-VW
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZFEPV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZFEPV5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 11:21:57 -0400
Received: from main.gmane.org ([80.91.229.2]:49016 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbZFEPV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 11:21:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MCbEv-0002v4-RZ
	for git@vger.kernel.org; Fri, 05 Jun 2009 15:21:53 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 15:21:53 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 15:21:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120779>

Hello,

I have a fair number of new users, mostly refugees from VSS
and SVN, and they do use the GUIs a fair bit.

And they keep doing this :-)  I know what you're thinking:
teach them not to do it...

But doing this at the command line gives you a nice warning,
and a GUI is (like it or not) considered more "safe" (aka
less powerful).  So it should go one better and just refuse
:-)

Is there any way we can disable "Checkout this branch" for
branches that are not local in gitk?  I'm willing to play
around with the code and test it if someone can give me a
couple of pointers at least.

Thanks,

Sitaram
