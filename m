From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Fix am with stray $dotest directory
Date: Fri, 14 Jun 2013 13:17:36 +0530
Message-ID: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 09:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnOhi-0004HO-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 09:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab3FNHpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 03:45:47 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62177 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FNHpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 03:45:46 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so316558pde.23
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ANR12TXZaJsaQ2QI687ieJhpDgaTOaC7wJOtJeLvaxc=;
        b=FJSKyXZkdqAlT5KzG0q+FgwL1Oc+Q0UIVhFiw3JBOmG476sq4u/o212saMiG29oFt9
         SkMoOKehUcMmmbvESyp4+vsZdDSTb5w0d9wZhcY1awzPhObcxwO+h9T7gEDmz1AuIJW/
         +oWvh2QiWNoKndIYXx/UCM4JW4T3PVngNZacsAVvROUJ7YWaaU1GjKGcabayEw3+Xjpz
         Hq1s2fhuG6THcIHnjD92VnvzwWIng6PZX/FMoj3vvlcARGDubo2dJI9pFOhkeYDwb/FK
         hCZddQhjxWiWhiw+infDrhkEb5Q6DepxdOWPUqMqSFnZiLeFKN1GOpZjSpUy51AKLB9j
         ZI7w==
X-Received: by 10.68.254.225 with SMTP id al1mr1353783pbd.69.1371195945990;
        Fri, 14 Jun 2013 00:45:45 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fn9sm1413129pab.2.2013.06.14.00.45.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 00:45:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.380.g67e7d64.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227791>

[1/2] is now equipped to handle any am invocation in the presence of a
stray $dotest directory.

[2/2] is a "while we're there".

Thanks.

Ramkumar Ramachandra (2):
  am: handle stray $dotest directory
  t/am: use test_path_is_missing() where appropriate

 git-am.sh     | 14 ++++++++++++++
 t/t4150-am.sh | 40 +++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 17 deletions(-)

-- 
1.8.3.1.380.g67e7d64.dirty
