From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 13:14:36 +0200
Message-ID: <1127128475.781.6.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 13:16:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHJb3-0000Cv-9l
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 13:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVISLNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 07:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVISLNs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 07:13:48 -0400
Received: from khepri.openbios.org ([80.190.231.112]:35987 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP
	id S1750708AbVISLNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 07:13:47 -0400
Received: from dsl-082-083-077-252.arcor-ip.net ([82.83.77.252] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1EHJaf-0007L7-2c
	for git@vger.kernel.org; Mon, 19 Sep 2005 13:13:41 +0200
Received: from 192.168.1.201 (divert.studentenbude.ath.cx [192.168.1.201])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j8JBDYWp007206
	for <git@vger.kernel.org>; Mon, 19 Sep 2005 13:13:40 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Mon, 19 Sep 2005 13:13:40 +0200 (CEST)
X-Spam-Score: -1.3 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8855>

hello,

attached are two patches.

the first is an updated implementation of CURLDIR support (for those who
have libcurl outside their library search path)

the second changes cmd-rename.sh so that it only adds symlinks to
executables that actually exist (eg. when building with NO_CURL,
git-http-pull would still be created).

another issue I had was that mailinfo uses strcasestr, which isn't in
solaris' libc (and not in posix according to
http://lists.gnu.org/archive/html/bug-gnulib/2005-08/msg00076.html). I
disabled it in my build for now, and might come up with a patch later,
unless someone beats me to it.


patrick mauritz
