From: walt <wa1ter@myrealbox.com>
Subject: 'bad file' error updating from Linus
Date: Thu, 22 Sep 2005 04:40:13 -0700
Organization: none
Message-ID: <dgu56t$d2p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 22 13:45:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIPUK-0005Sf-GG
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 13:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVIVLni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 07:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVIVLni
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 07:43:38 -0400
Received: from main.gmane.org ([80.91.229.2]:21182 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030269AbVIVLnh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 07:43:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EIPSo-00058X-1X
	for git@vger.kernel.org; Thu, 22 Sep 2005 13:42:06 +0200
Received: from adsl-69-234-234-116.dsl.irvnca.pacbell.net ([69.234.234.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 13:42:06 +0200
Received: from wa1ter by adsl-69-234-234-116.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 13:42:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-234-116.dsl.irvnca.pacbell.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050920
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9110>

cg-update this morning is giving me this error:

receiving file list ... done
v2.6.14-rc2

wrote 134 bytes  read 1116 bytes  833.33 bytes/sec
total size is 738  speedup is 0.59
Tree change: 044a500e46742d39d22f1781cfb64ba93b463e39:e98c07b9eabedfb1d7ebef61af475bdebe1dd64d
error: unable to find e98c07b9eabedfb1d7ebef61af475bdebe1dd64d
fatal: git-cat-file e98c07b9eabedfb1d7ebef61af475bdebe1dd64d: bad file
error: unable to find e98c07b9eabedfb1d7ebef61af475bdebe1dd64d
fatal: git-cat-file e98c07b9eabedfb1d7ebef61af475bdebe1dd64d: bad file
Invalid tree id: e98c07b9eabedfb1d7ebef61af475bdebe1dd64d

Is this a kernel.org rsync problem, perhaps?

(I'm running the latest releases of cogito and git from kernel.org.)
