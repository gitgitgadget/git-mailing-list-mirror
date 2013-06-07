From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Trivial patches
Date: Fri,  7 Jun 2013 15:32:20 -0500
Message-ID: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3MY-0006PP-UL
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab3FGUeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:34:15 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38349 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3FGUeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:34:14 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so7095916obc.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/MykBiWXaahz4iWp+8wAIZUOJg2IVd9GsMuejacNpIo=;
        b=EDFJAu2q6Hx2CuT4TKDvi8AeVhiCjvR3c5xhFS7alqZAKrLrrX8rOEVZ64bGll6bSc
         6i08E8Jw1sNQHY7n2vW/DzTvHSVT/f5mLuzfDeW5mPu0g569LBOx6XNdTz9kL23NBiEF
         82fce1KG7sJV86eOPEJi/GxxCOUv6FqQkYWTkro/q/8oPVDrckN1Ra83mbH17+S1vg9Z
         iiuIVfPj0oCzc3nKj+jOj0Xt6i7SqqoyXEfc61edz80IpJTJpf6UD+dg86exQMvtFNJa
         ruYKSYzbYomFlOhL7F78vAKG18tUMB8MhBDNq4v8bqwy9v8Hm2O3i93BlTfcnp86sqs8
         CVDg==
X-Received: by 10.60.38.197 with SMTP id i5mr271003oek.66.1370637253726;
        Fri, 07 Jun 2013 13:34:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kz3sm508467obb.6.2013.06.07.13.34.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 13:34:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226699>

Felipe Contreras (3):
  sequencer: trivial fix
  test: improve rebase -q test
  submodule: remove unnecessary check

 sequencer.c       | 7 +++++--
 submodule.c       | 5 ++---
 t/t3400-rebase.sh | 1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.3.698.g079b096
