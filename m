From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 4/6] object: add one bit to let creation of private types 
	(OBJ_MAX + n)
Date: Sun, 22 Feb 2009 20:06:49 +0200
Message-ID: <e29894ca0902221006u77fdaa89s9cc01fb27bffce0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIl0-00047r-OV
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZBVSGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZBVSGv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6329 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZBVSGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:50 -0500
Received: by nf-out-0910.google.com with SMTP id d21so367282nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=qhGwMMkCqlEL89PhfjjWKivtTctyfeHEesTmpFoy80g=;
        b=T3/8gRgU0M0dxYbBlhKCMXGaPr77wvbrdKAFgoNw10tlkizenZF0wsaf9hrifQ1/cN
         //gLJ9uBOeVVHDcyAzjV/0EincJEWOBH2C9WWVazBXTKG6DE+dSgD5oC/Y2/Mpd9uN9P
         QaBaaCHGuDwM5oCOdvrgxyklPSMlhKjC6LEI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=uvdk2o0lYrO7xO0BgVEpZtS2cIvR4r2NmS70kKLKXvfXIbSw60s9tsIGkvpYSPlP90
         co2w5qrE/gIW/jzzqULjYc6w2N61U4iMnON9VHEo7pQBou7Ibcrj5Fq3Gz6bGEwEfV/E
         lGEiiDomf0JUO2n5y+RGqqkPUpmiUVRhcfqXg=
Received: by 10.210.12.18 with SMTP id 18mr2701844ebl.110.1235326009374; Sun, 
	22 Feb 2009 10:06:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111037>

---
 object.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/object.h b/object.h
index 89dd0c4..83d3644 100644
--- a/object.h
+++ b/object.h
@@ -21,7 +21,7 @@ struct object_array {
 	} *objects;
 };

-#define TYPE_BITS   3
+#define TYPE_BITS   4
 #define FLAG_BITS  27

 /*
-- 
1.6.2.rc1.28.g05ef4.dirty
