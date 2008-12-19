From: jidanni@jidanni.org
Subject: sneakernet everyday recommendations?
Date: Fri, 19 Dec 2008 10:33:06 +0800
Message-ID: <877i5whp25.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: etckeeper@packages.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 03:34:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDVCD-0001Gw-Is
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 03:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYLSCdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 21:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbYLSCdL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 21:33:11 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:41128 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751021AbYLSCdK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 21:33:10 -0500
Received: from jidanni.org (122-127-37-70.dynamic.hinet.net [122.127.37.70])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 4DCD0119DE5;
	Thu, 18 Dec 2008 18:33:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103530>

Say, on a sneakernet what would you use for
A>B A<B A>B... updating? git-commit and git-bundle and git-merge?

You see I have the two computers, that I use on alternating days, a
sort of redundancy strategy.

Normally if I change my .bashrc or /etc/ppp/ip-up.d/bla, etc. I just
cpio -o it to a CF card, the common sneakernet junction between my two
systems that are never powered up at the same time. And then cpio -i
it to the other system the following day.

To use git instead, On each computer I shall have my shutdown script
ask me about a commit, and my boot script ask me about a merge.

To track metadata, I will employ etckeeper.

I don't want to track the entire machines, just 100 or so files, which
I have git-added.

(Hmmm, also copying /var/cache/debconf/config.dat and
/var/lib/aptitude/pkgstates to the CF card
should be enough to complete my minimal restoreability strategy
in contrast to the many more bulkier 'system snapshot' solutions out there).
