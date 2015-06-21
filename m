From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 00/11] add options to for-each-ref
Date: Mon, 22 Jun 2015 02:15:52 +0530
Message-ID: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 22:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6m8J-0003xB-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbbFUUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:46:23 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35836 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbFUUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:46:22 -0400
Received: by obbop1 with SMTP id op1so8714229obb.2
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=QzdkH/xMV1P4XyakpYqQyy0mErnO4L7KD1OYWOaqQWo=;
        b=zQBeSPZ4M3d2MGLuAW679JeMIJ730qXAhqzFLgzEXQAfVyXMz5Slc8QK+95nhlF2c5
         lIwl3pQttyGcVE6jSGNdfRuMTRpcCXN8KT9sPgQUaQ4wMoK9LG5YRZ3ek4gJ+xvwoYJU
         1DOH0+QKC1X37EX6UZmcIu3CKSvOct7G4v35Kko9J26Sa2PJdCbZVGvdXyKabR+8y98g
         2CgkQ4pn/3Rh0+1mgv8fcfoFEglU58n4VdK4UykNRq1ma5M2mGR9tQg90/92f0Tegmis
         bIPYrDP52dRMkV5vmfXdQIgGxKo+iyOlvBjxoJh96M2327kaF5AjyMsrEw37VKgQPFFU
         qYaQ==
X-Received: by 10.202.92.68 with SMTP id q65mr9482110oib.11.1434919581711;
 Sun, 21 Jun 2015 13:46:21 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Sun, 21 Jun 2015 13:45:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272285>

The previous version of the patch series can be found here :
thread.gmane.org/gmane.comp.version-control.git/271754

Changes in this version :
*   01/11: Remove unnecessary tests and add signed tag.
*   04/11: Grammatical change.
*   06/11: Introduce a comment to explain code.
*   11/11: Grammatical change.

Thanks to Matthieu for suggestions on the previous version
-- 
Regards,
Karthik Nayak
