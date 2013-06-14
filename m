From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Rebasing pull with autostash
Date: Fri, 14 Jun 2013 14:26:16 +0530
Message-ID: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 10:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnPmD-0001CM-A6
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 10:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab3FNIy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 04:54:27 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63104 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNIyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 04:54:25 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so370520pbc.31
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=owrMuKfLghd78ajUzbgGIe4/KeFGOfCB5eiGmbfM6zA=;
        b=NOCBFEF7swDg8zKmdabGwb7J3QYRA2fB/fd/uA+z+GDg2dQFBU3ZOB3dk1h6R4Ma4w
         Av4G+yIaQLPjLgkRZrDfjkxUlrLzywA0IIZECnv/MFwwL/1WKokpupwLIEB3icEek9NG
         F1aRQOFb9+1F9Hrefvtcsklo2NVjWIiUKj+48qM4i2adNDT+/dSajLVNU9AUTOiJ8IcO
         uvj/B+ef8sUk0vaWAYENKeh2cboUhWomNqlMj/cyOm3VQvVWUC389PIobFRs87AKSBnI
         Rs0omOWm0Y3YTi/DdSr4AEsRJ05lEqimWy5wKkW1UVuPO18+i931/M8AnK9axyINiWfu
         ox/w==
X-Received: by 10.68.245.170 with SMTP id xp10mr1575819pbc.41.1371200064844;
        Fri, 14 Jun 2013 01:54:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fr1sm1506848pbb.26.2013.06.14.01.54.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 01:54:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.gb74074e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227796>

It's trivial to support the feature :)

Ramkumar Ramachandra (2):
  pull: respect rebase.autostash
  pull: clarify the large && { ... } form

 git-pull.sh     |  7 +++++--
 t/t5520-pull.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
1.8.3.1.379.gb74074e.dirty
