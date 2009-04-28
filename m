From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 08:49:08 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 10:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyj12-0002Xh-6v
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 10:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZD1It2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZD1It2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 04:49:28 -0400
Received: from main.gmane.org ([80.91.229.2]:58347 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbZD1It1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 04:49:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lyj0H-0007ID-3k
	for git@vger.kernel.org; Tue, 28 Apr 2009 08:49:25 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 08:49:25 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 08:49:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117757>

HI,

[Apologies if this is not the right place to ask; please let
me know if so...]

I know "tg depend" only has the "add" subcommand right now,
but is there a manual way of getting the effect of a
hypothetical "tg depend remove"?

For branches which do not introduce any changes of their
own, can I just "tg delete" the branch and "tg create" it
again with the reduced list of dependencies?  How does this
affect the remote (which would still become a forced push of
some kind).

And is there a way to do this for dependent branches which
*do* have changes of their own?  Even if it is manual and
comes with "here be dragons" warnings :-)

Thanks,

Sitaram
