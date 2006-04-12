From: Aubrey <aubreylee@gmail.com>
Subject: how to make a git-format patch
Date: Wed, 12 Apr 2006 18:28:01 +0800
Message-ID: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 12 12:28:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTca3-0007p9-Qz
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 12:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWDLK2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 06:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWDLK2E
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 06:28:04 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:25270 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932137AbWDLK2D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 06:28:03 -0400
Received: by nproxy.gmail.com with SMTP id g2so1000849nfe
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 03:28:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oCYl9DujtMTGwoWuvyw/nuzM+2Tvg0t+fbgGvdY1/KSWHygiMD5PMI6nWp+1WoRQ/IRGyu0/LYiXY2GyHh3n3m+lhAAlIxl2YMPr3gp8mBuC9V5YtNpPUIBntSAazv9/CJSREfWRrC/ZFrLcw7aD6vJiRBULih1r1nj5+5fSRWE=
Received: by 10.48.217.16 with SMTP id p16mr1010322nfg;
        Wed, 12 Apr 2006 03:28:01 -0700 (PDT)
Received: by 10.48.220.18 with HTTP; Wed, 12 Apr 2006 03:28:01 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18628>

Hi list,

When I use GIT to generate a patch, I can use git-diff, if one file
changed, I can get the following patch:
=================================
diff --git a/net/packet/Kconfig b/net/packet/Kconfig
index 34ff93f..959c272 100644
--- a/net/packet/Kconfig
+++ b/net/packet/Kconfig
@@ -17,7 +17,7 @@ config PACKET

 config PACKET_MMAP
        bool "Packet socket: mmapped IO"
-       depends on PACKET
+       depends on PACKET && MMU
        help
          If you say Y here, the Packet protocol driver will use an IO
          mechanism that results in faster communication.
=================================
But I saw most of the git-format patches have a header in the front of
the patch file, like:
=================================
 * Added xxxxxx support

Signed-off-by: xxxxxxxx <xxxxxxx@email.com>
---

 net/packet/Kconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/net/packet/Kconfig b/net/packet/Kconfig
index 34ff93f..959c272 100644
--- a/net/packet/Kconfig
+++ b/net/packet/Kconfig

----snip----
=================================

Just want to know how this kind of patch format generated.
Thanks for any hints.

Regards,
-Aubrey
