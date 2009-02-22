From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [tig PATCH v2 0/2] popup menu
Date: Sun, 22 Feb 2009 15:09:36 +0100
Message-ID: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 15:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbF5V-0000yv-Lj
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 15:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZBVOJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 09:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbZBVOJp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 09:09:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:58998 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZBVOJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 09:09:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2423942fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=l6ElOx+5zLmyupQSnEh2ja9mWog6kHflgeY7owZF5i8=;
        b=vpqBD42sV7BkcQOrvam6SQVAc0I4ar3V+4nmeRqUFd5OwYFqGC1s4Pgjqqn8Jibwzj
         kp7Dd4yj3KsoD0h/ya4IHI8dLRLhVEJWdZyTyS5xtjSu8E47Lq2O/tdq5m0Wp5IbI8vt
         NAYBjTR2aS9naKI/3PjkIZg9Ohgk6Ap+g0r80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=V+Pz7AdC3+b2+5mYIbRN2d7jgPC6A+RplLS872FV18jQhbF3TmGftRXaGOVnmpKRkZ
         QzWeTrMdsSPnQK3k5ael5UjFICM/tDPYbHMQUbA5rMjxQ8Dw3klYefufUhE8jO2l/4a7
         cv615pgahd2J47U74Q+6bmzDZ2ky7eueSZFWE=
Received: by 10.86.87.13 with SMTP id k13mr780398fgb.35.1235311783435;
        Sun, 22 Feb 2009 06:09:43 -0800 (PST)
Received: from localhost (host-78-15-3-150.cust-adsl.tiscali.it [78.15.3.150])
        by mx.google.com with ESMTPS id l19sm4705785fgb.47.2009.02.22.06.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 06:09:43 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111005>

Second version, in two patches. The first one is just the same as
previous one, minus a couple of leftovers.

The second one reimplements the menu drawing routine so that it can be
called when necessary to redraw the menu entirely, e.g. after a resize
or when background loading finishes.

Giuseppe Bilotta (2):
  Popup menu
  Popup menu: redraw as needed

 tig.c |  149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 147 insertions(+), 2 deletions(-)
