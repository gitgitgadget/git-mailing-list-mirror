From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH 0/2] GSoC micro project, use skip_prefix() in fsck_commit()
Date: Thu, 13 Mar 2014 02:18:22 +0800
Message-ID: <1394648304-19159-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 19:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnk6-0001ni-4R
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaCLSS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:18:57 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46097 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaCLSS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:18:56 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so1449474pab.40
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dRXv4GUZvCujspqN+/D8c6EPzKye9sp/YtMhzJQJ+9U=;
        b=ChfAgRYb9zfbnPPD+R5d/MCIPgC2osnPx0wqhH/rNJrd7hTL7GMZBcY3gk6aDMADxw
         +A5owCElcLhRNUyorqxo5oowTPzXmRUP61GD6XLqraXNBkLpY3zPXmpXHVwflNMANhku
         yv9bAqCgaJ478K9gvtdzQYSYdRGi/SuYht4WHjwb2VSwv+OfN+AdRbYuwewNdCndYPaU
         Ax541Mr8TJZKzpsjmI5CfvkQSgiJQ0uq8NnorIcScbswtaABnC5jvdRxnFhOQxYCe4qQ
         uz0SkrcFAbWz9Mt8O47i+yX2dbwe0hYJOPIBVZeQcoGMSuNmCu0Jjrsyr1zbs0KHiZN+
         wGDw==
X-Received: by 10.66.181.70 with SMTP id du6mr6548236pac.23.1394648335824;
        Wed, 12 Mar 2014 11:18:55 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id pi1sm24592117pac.14.2014.03.12.11.18.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 11:18:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243952>


Yuxuan Shui (2):
  fsck.c: Change the type of fsck_ident()'s first argument
  fsck.c: Rewrite fsck_commit() to use skip_prefix()

 fsck.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
1.9.0
