From: Olivier Delalleau <shish@keba.be>
Subject: Suggestion: add option in git-p4 to preserve user in Git repository
Date: Thu, 10 Jan 2013 22:38:08 -0500
Message-ID: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 04:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtVRv-00085E-3z
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3AKDiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 22:38:10 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42987 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3AKDiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:38:09 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so1353245obc.29
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 19:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=3MBl3mwcltO8uDScriHURwpBDV7ynovjVIMOsUtu4kQ=;
        b=UX6ZBzt4u3xw/LcQhRhWUACPDuSaTcwHiCjSJi6TWSYsWnKx4dgBhaIEqTDHvCeVnX
         Ny7uTO+7DmKYnULntuCE5nxpOAEkqC2KfJjvnvEY2QPw5g/rjPqwnYOSStG7pqblbQgu
         XO5As9k+4W9s12fgPI88GeQTGILE3A8RpOmcur/aJldNgTT5uEHqdF5fjdQy+v+n0IVF
         ieJD5KEScNAYOZ1Iu8otAvNebeppK/AGhe1b8Zyt92BjngJJgrbzwkFoip9PZXSv3FYN
         19Bho+VPU6AbqKajnhj9dq0p365J7vJ/Sn52olUW8hSJ5FRfueuJQ9dDY6br43vLot2G
         MCIQ==
Received: by 10.182.40.3 with SMTP id t3mr17308954obk.56.1357875488564; Thu,
 10 Jan 2013 19:38:08 -0800 (PST)
Received: by 10.76.28.69 with HTTP; Thu, 10 Jan 2013 19:38:08 -0800 (PST)
X-Google-Sender-Auth: 23FdXA3hJhSrDEvuKdaYgyjS0j0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213171>

Hi,

I'm in a situation where I don't have P4 admin rights to use the
--preserve-user option of git-p4. However, I would like to keep user
information in the associated Git branch.

Would it be possible to add an option for this?

Thanks,

-=- Olivier
