From: Jari Aalto <jari.aalto@cante.net>
Subject: BUG: git remote show origin => error code 1
Date: Sat, 29 Sep 2007 21:13:26 +0300
Organization: Private
Message-ID: <ps01nxvd.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 20:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibgkj-0000vb-9A
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 20:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbXI2SJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbXI2SJL
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 14:09:11 -0400
Received: from main.gmane.org ([80.91.229.2]:60959 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXI2SJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 14:09:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IbgkL-0007t8-51
	for git@vger.kernel.org; Sat, 29 Sep 2007 18:08:57 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 18:08:57 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 18:08:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:LJmnddwZL7iaqcIA9T5MDskA3kw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59482>


Consider this:

    $ git remote show origin
    No such remote origin

    $ echo $?
    0

Perhaps the code should return non-zero in this case, so that shell
scripts could use construct:

    git remote show origin; || <another action>

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
