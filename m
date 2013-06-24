From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH (!) 0/2] Fix serious regressions in latest master
Date: Mon, 24 Jun 2013 18:15:10 +0530
Message-ID: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 14:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur6CJ-0004MQ-RI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 14:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab3FXMsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 08:48:39 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56541 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3FXMsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 08:48:39 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so10981724pab.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SJZymr3RkqBHF2RyIrMjIv6KqxlS96O5Iv1TtzqfdN4=;
        b=I6MMfNClVpFmk3ZJUIh+aprL4D1EOleXL5+9or5crMrkizYcETu/1vtUf9Iva+ZE10
         hmh294/gzJXNQod0197QPi6rUGM7giuAhsginoUbnDhcACD1mrVxhtC5gdyW1EdogiwH
         N2F0zLk2JK7knrxRW2kcWXWafAGUFq+63HxKp4dAuymGPt6Kml05xIcQcuUYawXOWHSy
         MBNaeL3AxyMUCaDgLa68XXLVnvMvYv1ifPLnKYb5hNmNR1A1XRWFeiF65VPd1J3O2dU9
         SIyVjjIuKH4D6JBeYwGCXx7iQlJzf9cD1DJ51yNzwgsFAX6oHEVqZM2JARKq/NhHU+29
         miFg==
X-Received: by 10.68.231.65 with SMTP id te1mr23220750pbc.98.1372078118488;
        Mon, 24 Jun 2013 05:48:38 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id yj2sm18024267pbb.40.2013.06.24.05.48.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 05:48:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.550.gd96f26e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228808>

Hi,

It turns out that status.short and status.branch introduce two very
serious regressions.  This series fixes them.

Thanks.

Ramkumar Ramachandra (2):
  status: really ignore config with --porcelain
  commit: make it work with status.short

 builtin/commit.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
1.8.3.1.550.gd96f26e.dirty
