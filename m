From: Petr Bena <benapetr@gmail.com>
Subject: BUG I can't start git on Windows 7
Date: Mon, 8 Sep 2014 11:15:44 +0200
Message-ID: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 11:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQv3A-00010X-7R
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 11:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbaIHJPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 05:15:46 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:38359 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbaIHJPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 05:15:45 -0400
Received: by mail-vc0-f177.google.com with SMTP id hq11so14985427vcb.36
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gHrpdloCnhGmXuap2ZtWJx/NQ8tOjVe5wvEE4++/84g=;
        b=TeEZy0ZgSUmNPTob646BqRd5WjONcY9OLUhYZb5YMRP+iPuSHDmYVZ4jIxfrGTjTEa
         ZGXmqEPh7ZaLGkcoQX2lLc8wyd/1bWfeAgCyKKM6G9rqBXAU2AVenHMrMRsboa2XqX27
         2Ha8M/Y9AcFLJRBa5gv90/TtX9ODE0hOQL/MAwvy/zJk6LCOdU8dDKFgKQtaRmIjRWwo
         0SAA+PERZ2UX9Ofvo9jnKrl85IFq3ExNEHBV0RTOiRX3XK+0sfhbmy6Nhw3XzaBhXxCF
         qhPAONHjmarr54myJwQ4VixQnjvXNM0IvMNDBYfperKPhRyNxd+MI4J/HzfZezA5pNi7
         8UNg==
X-Received: by 10.221.21.201 with SMTP id qt9mr956213vcb.39.1410167744237;
 Mon, 08 Sep 2014 02:15:44 -0700 (PDT)
Received: by 10.221.10.69 with HTTP; Mon, 8 Sep 2014 02:15:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256636>

I installed git on my system using official package from git-scm.com
but I can't launch it, I am always getting this error:

C:\Users\petr.bena>"C:\Program Files (x86)\Git\bin\sh.exe" --login -i
      0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x40000, State 0x10000
C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
cygwin's heap, Win32 error 0


At some point this could be an issue with cygwin, but I am not sure.
Did anyone had similar issue?
