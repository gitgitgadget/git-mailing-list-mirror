From: Max Nanasy <max.nanasy@gmail.com>
Subject: [PATCH] diff.c: diff.renamelimit => diff.renameLimit in message
Date: Thu, 21 Mar 2013 12:53:38 -0700
Message-ID: <CAM998vHDay2o55Q3v4tfh=tvcmpOHHCPX-Ya5KxVxsn3=jzs3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 20:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlYt-0000KS-N6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab3CUTxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:53:41 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45752 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3CUTxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:53:40 -0400
Received: by mail-wg0-f53.google.com with SMTP id eg6so2615250wgb.20
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=7MafZnyDbonak8dYonkPMEwuwjPjuH7HuQ+YS0AEhWw=;
        b=nrT+CxzP/clylCwLEuoKEjOQy3UVpzuzAHvE0mKIav2QISn3eKYdamUdKpghvMxY5k
         qM8jLpqu5zYz2AN92r3uJrUQi/wel/6Md0e55MVm1bEmiclHxKaxIzKl27fjgiz715jf
         PsBGQpy0da2GTiL2cmEnoEp5CvdP3g5jtSF3F9wpLhwjKinT/Kskg93XUBG7gaYlJ0iu
         oqWKuiPgwtvAlUTYsQguLvOWq2ZkxMYEMSJhzQYoJsaI87fEIq/xMDMa1MpZ/iCeYJuZ
         y1cFMm5+LlivfdTHOqN24vweGap6biLiljw25dWpTR8S+VQWklb3Pi6rvCYVbUPl602l
         3yQg==
X-Received: by 10.180.86.1 with SMTP id l1mr6782819wiz.32.1363895619058; Thu,
 21 Mar 2013 12:53:39 -0700 (PDT)
Received: by 10.216.107.71 with HTTP; Thu, 21 Mar 2013 12:53:38 -0700 (PDT)
X-Google-Sender-Auth: wCBotoQq57tTA2r6tdmIAIZ3SLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218750>

In the warning message printed when rename or unmodified copy
detection was skipped due to too many files, change "diff.renamelimit"
to "diff.renameLimit", in order to make it consistent with git
documentation, which consistently uses "diff.renameLimit".

Signed-off-by: Max Nanasy <max.nanasy@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 156fec4..052974e 100644
--- a/diff.c
+++ b/diff.c
@@ -4662,7 +4662,7 @@ int diff_result_code(struct diff_options *opt, int status)
 {
  int result = 0;

- diff_warn_rename_limit("diff.renamelimit",
+ diff_warn_rename_limit("diff.renameLimit",
        opt->needed_rename_limit,
        opt->degraded_cc_to_c);
  if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
--
1.8.1.3
