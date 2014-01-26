From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [TEST EMAIL] Testing rk/send-email-ssl-cert in pu
Date: Sun, 26 Jan 2014 12:08:40 -0500
Message-ID: <1390756120-7370-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:08:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TCL-0006FB-1a
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaAZRIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:08:35 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:55593 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbaAZRIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:08:34 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so6786501qcx.7
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=ViGYyrW4d2kC/IUuwiKWGbuu7bEd1w83OvJgcjtkhn0=;
        b=XyDazoOr1LzPsKxY1A3ks/8iweMWq85k4YN4P7Ip0X0cBo7ofoBDMARBwa7mGL8y+q
         VWI6ZtKGUJit/Ea0D7q83AkrCtPwSc0WIxzXzLfHCs2m4wtYtacUmrul0kUqrsFD+I4Y
         SNXEF3pgGUO5BVuNQygKoMg27uhxD/Tm+fu+QBQnoHWApX326rL9bYFuu/XM7QqQ5F0a
         nOKgelv8LydlFfZImATO/aE3or4areW5KBlxGtDLoSwTzmxrhrpNrms1EkLXPnGH7wa5
         wCwAo0pLThYmCL4FrNCnT8RDlDFePbr7IxsiW/4kEDqmbwGqkPr+VOgHEgcmFcqLUlr6
         L3GA==
X-Received: by 10.229.10.197 with SMTP id q5mr36436841qcq.15.1390756113861;
        Sun, 26 Jan 2014 09:08:33 -0800 (PST)
Received: from localhost.localdomain (dyn-160-39-37-27.dyn.columbia.edu. [160.39.37.27])
        by mx.google.com with ESMTPSA id k1sm18788249qat.16.2014.01.26.09.08.33
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jan 2014 09:08:33 -0800 (PST)
X-Mailer: git-send-email 1.9.rc0.1.g9d22d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241090>

Hi,

This email tests that 01645b7 (send-email: /etc/ssl/certs/ directory
may not be usable as ca_path, 2014-01-15) doesn't cause a regression.

Ram
