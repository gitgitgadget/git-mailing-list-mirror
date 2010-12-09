From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/3] git-gui: fix typo in image data
Date: Thu,  9 Dec 2010 21:46:21 +0100
Message-ID: <c373e73fb114ebc580c36bc494dc62f80a19ece9.1291927374.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnNr-0002Ki-TG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab0LIUqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:46:30 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41154 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0LIUq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:46:29 -0500
Received: by fxm18 with SMTP id 18so2914425fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TIwp1u4iM1gqqR5fV/15nTop2daUhtrop0tj8wM4O1s=;
        b=heSgLD6gKWrs78wUem+wtE+jK6RTm0evSWmt/zlyqGnlPRX6Vo1FTeB+rW3X+1JxSH
         5K5zt1ERZNftxesehsKpmGuwvpWL3tQaTyPhL8OWJzCZFhWFrp5Ob+j0fBikfn0SB4cr
         3dLouq9EtN7I/diVAfgrtjfm+LVpcQqd+5rY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qp4tKi9ClJGamhugQ3Ciyiz99FsccBDssl/cFnIshZRJv98PVOozydRSyObOZHTSR8
         pfcmYaqg+dbX77IsaqTCBP/Ncho9L+x3VgKk19371wpGtzS6gDgGSv0h95MTYrw9GzWh
         Q2baO7Rlfpe6jhtGU0tkJHIeYev24LYu5k6Fo=
Received: by 10.223.71.199 with SMTP id i7mr10786720faj.57.1291927587808;
        Thu, 09 Dec 2010 12:46:27 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id a2sm695601faw.46.2010.12.09.12.46.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:46:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163310>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c85a53c..3ef9129 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1958,8 +1958,8 @@ static unsigned char file_merge_bits[] = {
 } -maskdata $filemask
 
 image create bitmap file_statechange -background white -foreground green -data {
-#define file_merge_width 14
-#define file_merge_height 15
+#define file_statechange_width 14
+#define file_statechange_height 15
 static unsigned char file_statechange_bits[] = {
    0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x62, 0x10,
    0x62, 0x10, 0xba, 0x11, 0xba, 0x11, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10,
-- 
1.7.3.2.1200.ge4bf6
