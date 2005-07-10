From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: cg-clone failure
Date: Mon, 11 Jul 2005 02:02:53 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20050711.020253.63599702.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 10 19:03:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrfCJ-0008JV-CY
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 19:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVGJRCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGJRCY
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 13:02:24 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:32784 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261974AbVGJRCX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 13:02:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP id 0F63933CC2
	for <git@vger.kernel.org>; Mon, 11 Jul 2005 02:02:59 +0900 (JST)
To: git@vger.kernel.org
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Am I doing something wrong?

% cg-version 
cogito-0.12 (a2503fd85e6bb7f25d134a5634a1d8efc93fee5f)

% cg-clone -s ../linux-2.6
defaulting to local storage area
`/home/yoshfuji/GIT/linux-2.6+test/../linux-2.6/.git/refs/heads/master' -> `.git/refs/heads/origin'
progress: 1011 objects, 2976247 bytes
does not exist /home/yoshfuji/GIT/linux-2.6+test/../linux-2.6/.git/objects/3b/791b97522eb19f885a5c906d70c296a628ed25
Cannot obtain needed tree 3b791b97522eb19f885a5c906d70c296a628ed25
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed
rm: cannot remove `.' or `..'

--yoshfuji
