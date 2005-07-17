From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [offtopic]Re: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 22:02:48 +0400
Message-ID: <200507172202.48642.snake@penza-gsm.ru>
References: <20050717084053.94D603525D1@atlas.denx.de> <200507171448.09049.snake@penza-gsm.ru> <200507171633.17667.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 17 20:05:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuDVo-00017U-1e
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 20:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGQSFB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 14:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVGQSFB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 14:05:01 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:26820
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261345AbVGQSE7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 14:04:59 -0400
Received: (qmail 23401 invoked from network); 17 Jul 2005 18:04:56 -0000
Received: from unknown (HELO snake-modem.penza-gsm.ru) (192.168.5.2)
  by fileserver.penza-gsm.ru with SMTP; 17 Jul 2005 18:04:54 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <200507171633.17667.snake@penza-gsm.ru>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry for noise again.
I have found two bugs in cvsps that results in the wrong import to git.
I tried to contact developer but it seems that his mail have no mailserver 
ATM. Since he has made some changes for git already - probably someone on 
this list have his new contact. Please tell me it or forward my mail to him. 
Thanks.

For the curious, here are the bugs:
1) some branches fork off too late - cvsps shifts brahches starts forward to 
the future
Example:
http://www.penza-gsm.ru/snake/testscript

2) some branches are not detected at all, not recorded as patchsets and 
consequently not imported into git.
Example (branch "old"):
http://www.penza-gsm.ru/snake/simplexml.py,v


-- 
Respectfully
Alexey Nezhdanov
