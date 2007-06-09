From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH] Whitespace: replace spaces with tabs.
Date: Sat, 09 Jun 2007 23:25:54 +0100
Message-ID: <466B28F2.7030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 00:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx9Ei-0005uT-IB
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbXFIWQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXFIWQn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:16:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:35701 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbXFIWQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:16:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1207298ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 15:16:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ueF/y3hwy+xLZFdVevaZwaHT0YNATpmUUNgb8DBmCcS4SLd6g8OVxKP6WWYF8iGBedKFaPg0NpUgmScIvZstzRmZvUn1F4KRnsZj+FWnogg4ewZJpTRRcTOioa9XrZlKmfHm+V+i4NDDDv48qkbINBKB2kXEs63FvWXXaLto1BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZgHy/xrYrA4N4hit1HpLPoJc1OmD5ux8W1EUNmjo02w4G33VzRXG3jm+JzlI/fcF9NAmONsGvGMaJ8BO03uveStE85TgYWUrLrjparReW7xeGFqvu5KkD9DBMp1cub6P9ThCpxv5K0S5WUxTwqXLrkBT4Jmw3PDE0h84h7oAUVs=
Received: by 10.82.112.3 with SMTP id k3mr8031073buc.1181427401184;
        Sat, 09 Jun 2007 15:16:41 -0700 (PDT)
Received: from ?192.168.1.105? ( [82.17.45.135])
        by mx.google.com with ESMTP id 6sm8882360nfv.2007.06.09.15.16.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jun 2007 15:16:39 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49634>


Two lines of alloc.c contain indentation using spaces, while the 
remainder of the file uses tabs.  This change brings those 2 lines
into conformance with the predominant indentation style.
---
  alloc.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..baf9fce 100644
--- a/alloc.c
+++ b/alloc.c
@@ -59,13 +59,13 @@ DEFINE_ALLOCATOR(object, union any_object)

  static void report(const char* name, unsigned int count, size_t size)
  {
-    fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
+       fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
  }

  #undef SZ_FMT

  #define REPORT(name)   \
-    report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)
+       report(#name, name##_allocs, name##_allocs*sizeof(struct name) 
 >> 10)

  void alloc_report(void)
  {
--
1.4.4.4
