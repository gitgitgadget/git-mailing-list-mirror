From: elupus <elupus@ecce.se>
Subject: git 1.5.4.3 push incorrectly honors grafts file
Date: Mon, 27 Apr 2009 17:51:05 +0200
Message-ID: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 18:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTdt-0001Qr-8I
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZD0QZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZD0QZH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:25:07 -0400
Received: from main.gmane.org ([80.91.229.2]:36337 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbZD0QZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LyTdg-0001I1-Rm
	for git@vger.kernel.org; Mon, 27 Apr 2009 16:25:04 +0000
Received: from c83-254-4-118.bredband.comhem.se ([83.254.4.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 16:25:04 +0000
Received: from elupus by c83-254-4-118.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 16:25:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c83-254-4-118.bredband.comhem.se
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117685>

Hi, 

I recently had a problem with git push honoring the grafts file. It caused
it not to push all data required for a branch to the remote repository,
rendering it impossible to clone the remote repository (missing blobs)

This was with an not so fresh git version of 1.5.4.3 (ubuntu hardy).

Has this issue been fixed in later git version? I saw a thread talking
about it a long time ago (long before my release in question) on this
mailing list, but nothing was mentioned about if it was actually solved.

Regards
Joakim Plate
