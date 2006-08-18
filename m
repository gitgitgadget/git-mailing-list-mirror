From: nico-linux-git@schottelius.org
Subject: Standard cogito + patches: Changes to 'master'
Date: 18 Aug 2006 17:54:54 -0000
Message-ID: <20060818175454.8961.qmail@bruehe.schottelius.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 19:54:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE8YR-0006za-Lz
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWHRRyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 13:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWHRRyo
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:54:44 -0400
Received: from cable-static-233-101.eblcom.ch ([213.188.233.101]:42704 "HELO
	bruehe.schottelius.org") by vger.kernel.org with SMTP
	id S1751443AbWHRRyo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 13:54:44 -0400
Received: (qmail 8962 invoked by uid 1000); 18 Aug 2006 17:54:54 -0000
To: git@vger.kernel.org, nico-linux-git@schottelius.org, pasky@suse.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25685>

 Documentation/hooks.txt |   25 +++++++++++++++++++++++++
 HOOKS                   |   12 ------------
 cg-Xlib                 |   19 +++++++++++++++----
 3 files changed, 40 insertions(+), 16 deletions(-)

New commits:
commit fbf2f2d95e1e6994d1604504d4edee453e563454
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 19:46:56 2006 +0200

    Commit the running posix compatible showdate version (date is still
    broken, but bashism is out)

commit da88c243c39abacbe0d19d65c388fc936a3ca89c
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 18:51:38 2006 +0200

    Correct calculation, just very less slower than bashism variant

commit f04fb7a8673fa16593433e630ca0005233f01a25
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 18:02:31 2006 +0200

    showdate with posix compatible expansion, test1

commit dee5043515eebecd11951001d65001c2b308d606
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 17:37:43 2006 +0200

    showdate with sed+bc, testing

commit dae59abc62b8fa8c8246f5c4833cfae7edfad11b
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 17:37:13 2006 +0200

    showdate with sed, testing

commit f4c17ba39056abeb5a995b375866c1220885d2ad
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Fri Aug 18 17:22:58 2006 +0200

    Begin to remove bashism from showdate

commit 5283df5cca519921edca1b30402f9e6010f6404a
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Mon Jul 31 13:33:24 2006 +0200

    Doc:hooks: Added information about "update"

commit f30eeb8b476d0d09d2b1b6012ff62d008bcaabfe
Author: Nico Schottelius <nico@hydrogenium.schottelius.org>
Date:   Mon Jul 31 13:27:02 2006 +0200

    Move hooks to Documentation subdirectory
