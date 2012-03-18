From: <oldb0t@ro.ru>
Subject: Git stops forever while cloning remote repo
Date: Sun, 18 Mar 2012 17:47:26 +0400
Message-ID: <805073108.1332078446.170729064.12423@mcgi-wr-20.rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 14:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9GXd-0002Wb-63
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 14:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2CRNwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 09:52:55 -0400
Received: from mx-out-wr-2.rambler.ru ([81.19.92.41]:54277 "EHLO
	mx-out-wr-2.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2CRNwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 09:52:54 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Mar 2012 09:52:54 EDT
Received: from mcgi-wr-20.rambler.ru (mcgi-wr-20.rambler.ru [10.32.5.20])
	by mx-out-wr-2.rambler.ru (Postfix) with ESMTP id 7C26C7E2C24
	for <git@vger.kernel.org>; Sun, 18 Mar 2012 17:47:27 +0400 (MSK)
Received: from mcgi-wr-20.rambler.ru (localhost [127.0.0.1])
	by mcgi-wr-20.rambler.ru (Postfix) with ESMTP id 608072868430
	for <git@vger.kernel.org>; Sun, 18 Mar 2012 17:47:27 +0400 (MSK)
Received: from [93.74.202.53] by mcgi-wr-20.rambler.ru with HTTP (mailimap); Sun, 18 Mar 2012 17:47:26 +0400
Content-Disposition: inline
X-Mailer: Ramail 3u, (chameleon), http://mail.rambler.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193382>

Hello all.

I try to clone https://github.com/angband/angband.git locally, and git 
stops in the middle, again and again, in different places. For instance, 
one time it was 38% of full repo, and another time it was 4% of depth 1 
shallow clone. Once it stopped, it doesn't try to continue anymore, just 
get stuk forever. My internet connection is fine, all other works 
perfect: wget, browsers, mail client. Is there any way to force git to 
retry the connection? Something like wget does with -t and -T options. I 
use git 1.7.9.1 from Debian testing.

--
Brgds, oldbot
