From: Sebastian Kuzminsky <seb@highlab.com>
Subject: trivial fix to gitstatus.sh
Date: Mon, 18 Apr 2005 16:37:55 -0600
Message-ID: <E1DNesN-0003g0-RY@sphincter>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:34:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeod-0001gA-Gg
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDRWiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDRWiC
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:38:02 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58034 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261169AbVDRWh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 18:37:58 -0400
Received: from sphincter (c-67-174-179-171.hsd1.co.comcast.net[67.174.179.171])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2005041822375701500nm86he>; Mon, 18 Apr 2005 22:37:58 +0000
Received: from seb (helo=sphincter)
	by sphincter with local-esmtp (Exim 4.50)
	id 1DNesN-0003g0-RY; Mon, 18 Apr 2005 16:37:55 -0600
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is against git-pasky-0.5, just a little typo.  


gitstatus.sh: d5d0f82aca3f668655469cefb08a4d06049f2580
--- gitstatus.sh
+++ gitstatus.sh        2005-04-18 16:31:26.000000000 -0600
@@ -12,7 +12,7 @@
 } | sort -z -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
        tag=${1% *};
-       filename=${1r* };
+       filename=${1#* };
        case "$filename" in
        *.[ao] | tags | ,,merge*) ;;
        *)   echo "$tag $filename";;




--
Sebastian

