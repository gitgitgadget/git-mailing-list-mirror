From: Ted Zlatanov <tzz@lifelogs.com>
Subject: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 09 Sep 2011 05:22:00 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87lityxbg7.fsf@lifelogs.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 12:22:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yEB-0000QK-A2
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688Ab1IIKW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:22:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:39290 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758329Ab1IIKWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:22:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R1yE4-0000O9-39
	for git@vger.kernel.org; Fri, 09 Sep 2011 12:22:24 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:22:24 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:22:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:k9oN/HqFaI70zqaMAXoeF3bagBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181044>

I need to store some encrypted files in Git but for some clients with
the right GPG keys, decrypt them on checkout (possibly also encrypt them
back on commit, but that's not as important).  

diff doesn't have to work, this is just for convenience.  Can Git do
this (matching only .gpg files) or do I need my own command to run after
the checkout/fetch and before commit?  It seems pretty out of Git's
scope but perhaps others have done this before.

Thanks
Ted
