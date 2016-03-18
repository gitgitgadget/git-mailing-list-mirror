From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 0/2] gitk: changes for the "Tags and heads" view
Date: Fri, 18 Mar 2016 14:51:35 -0400
Message-ID: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Mar 18 19:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzUx-0001lE-Hx
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbcCRSvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:51:42 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34178 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbcCRSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:51:42 -0400
Received: by mail-yw0-f193.google.com with SMTP id f6so10958609ywa.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XM3XyaIDoQUT6UH2Hs2lhvuYM7JJRHmBbtVIdCZTlBs=;
        b=jZ3bcTShynv/5lGwsthw0HSBACap4YKf1F6AkJcD5CCA4/Cj97PxhPEZ8XKiWPIg1c
         /jBbwb3XH3wlar4ZPXrhugmOWy4w/KE5Bs6KZNDB2ZHq3nxXCnUqgrGN7Dnvn9kOowow
         v+nh0MqFtLKVlIB8qCqXrotpin0kxbVZRlTByaJ2r0lvVHXBLyfJGNQjW2PGFrTGS5LT
         HoMfZoQLqDcsI+mrejIj5OtpKA1IhN3sQQelq6iDIh1BtgxUgGPjWeyiyYGc84PwxwM3
         7Zj8DuPzPV8uHGfjlwiSnUvJ0qW17NqanUTuegcZpek4OD/hkj17QSX27jE0j2OqsBo+
         bPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XM3XyaIDoQUT6UH2Hs2lhvuYM7JJRHmBbtVIdCZTlBs=;
        b=NIBHRWbyZWRr3K0Z1Hfrsc7ms2rCOGweijvvEyGGLWl5MuvNdFJP9wJ4Rm8P66H2UL
         ZqFfmdGAXwa8e5GTXXUGQ1wFx5v8H1KEzqfFWVAqYSDQ//QcDOHh62jXWmYh/L8RmYd8
         ubTnhzeS0aLjXoH/XqyMEs7yYk8m+x8E5eciYTJBqOMhZFX+uzf4HRJMna4bUPlU5S+H
         uAR1RPQ7YO/JYTILtapBcTAnyaVYhEV39bAPIE/N/p2UB760Ipt6E6ra2reNe35tRbWg
         PkMuYTi7MXhhZDJFsZwLtL/ehGReKbqCs7V7Y+I6HPf8g+g47pr6cDJk8kdTBcGqzuWn
         QaDw==
X-Gm-Message-State: AD7BkJIq/XZd8tW9+MoBOlfQ+yp/wN0UoXm1fqgexyWnZESy/rlUxLinJWUOJZ34IU8wlQ==
X-Received: by 10.37.66.140 with SMTP id p134mr7588864yba.28.1458327101171;
        Fri, 18 Mar 2016 11:51:41 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id t123sm9204599ywe.4.2016.03.18.11.51.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 11:51:40 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289244>

I found a small bug in the v1 of this patch[1], when a tracked upstream
branch is no longer present.  The changes are only in the first commit.

[1] http://thread.gmane.org/gmane.comp.version-control.git/288544

Michael Rappazzo (2):
  gitk: alter the ordering for the "Tags and heads" view
  gitk: add an option to enable sorting the "Tags and heads" view by ref
    type

 gitk | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

-- 
2.7.4
