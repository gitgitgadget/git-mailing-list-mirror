From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/2] New @ shortcut for HEAD
Date: Tue,  7 May 2013 17:04:29 -0500
Message-ID: <1367964271-11422-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 00:06:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq1J-0007pR-U2
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab3EGWF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:05:58 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:38499 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3EGWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:05:57 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so277390yho.29
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=swc/f7In1d/BVpZ1ssAWdAmFyFlszS+clAnmsk5yz3Q=;
        b=TkvpqtlA7/mCPJWWNC6DZiKJtHDqFPNsbmnFtRa70BjNIFnBzOzd8ayW2tkHhzKrXe
         Lr27fl3vwZNXDwA8mCD6e+T+SoATOCF9sl6B0N3DBrVme4NO6xP9mcWThtcCfg+J61Uc
         5cEQN8fVLNgeKRzVQeB1sN9T8X3Zyn3gUvWr7PDI3jfC1Yfc8sp9klFhXVtGG7Gk4pEj
         zTnKp95iExZKPXlkCY2fUBR9MTPhU9v4CD3uHXFuz1klrRVPHKIc0Pj/6zAnTuCVYh78
         Kk+WaaU5kKT61J5bK0bU7qM0l4OY3fWQUhufH12n1G4xt03+gXzOMPTvL1qfszb2kmWo
         50YA==
X-Received: by 10.236.194.38 with SMTP id l26mr3907798yhn.26.1367964356726;
        Tue, 07 May 2013 15:05:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i21sm58447730yhl.15.2013.05.07.15.05.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 15:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223618>

Hi,

Same patches as before, except that the cleanup ones are in a different series,
and this one doesn't depend on the other one.

Felipe Contreras (2):
  sha1_name: refactor reinterpret()
  Add new @ shortcut for HEAD

 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  3 ++
 refs.c                                 |  4 +++
 sha1_name.c                            | 59 +++++++++++++++++++++++-----------
 t/t1508-at-combinations.sh             |  2 ++
 5 files changed, 51 insertions(+), 19 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
