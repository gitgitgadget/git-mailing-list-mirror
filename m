From: Michal Ludvig <michal@logix.cz>
Subject: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Fri, 30 Jun 2006 13:18:24 +1200
Message-ID: <44A47BE0.9060504@logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-crypto@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 03:18:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw7eb-0005UQ-UX
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 03:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWF3BSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 21:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWF3BSi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 21:18:38 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:1223 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S964922AbWF3BSh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 21:18:37 -0400
Received: from [192.168.159.18] (unknown [192.168.159.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by maxipes.logix.cz (Postfix) with ESMTP id E298DBCC30;
	Fri, 30 Jun 2006 03:18:31 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
To: Herbert Xu <herbert@gondor.apana.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22941>

Hi Herbert and others,

just a quick question: how can I create a patch with all changes in
cryptodev-2.6 tree against tag v2.6.16 in Linus tree? I've got
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
cloned here and want to extract all your commits in this tree since
2.6.16. Is there a way to do it in Git/Cogito?

I was playing with cg-mkpatch but that gave me only the last commit
(Twofish updates). I'm sure I could search for your commits in the log
and create those patches one by one but that doesn't seem to be too
efficient. Also tried "cg-mkpatch -r 6246b61[...].." which is your merge
of v2.6.17-rc1 into cryptodev-2.6 but that extracted _all_ commits since
that tag, not only those in your tree.

Any help appreciated :-)

Thanks

Michal
