From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Minor f-e-r enhacements
Date: Wed, 13 Nov 2013 15:06:43 +0530
Message-ID: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 13 10:45:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgX1F-0000RZ-0s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 10:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114Ab3KMJps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 04:45:48 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34706 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791Ab3KMJpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 04:45:45 -0500
Received: by mail-pd0-f172.google.com with SMTP id q10so174986pdj.3
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pADNgv0E18IgJfn7ZTzNUQ5nGZ1zwR+cUTmwYbPC5kQ=;
        b=Ils66PaiPXp2Qg8FCCHk1MO6Wkcvf+LjpuTR6r8p6CU3iB9Q9uP/n8kiFTClW3zm4Z
         UdOtqYN+ggNM9mOxchRLXm0MZWhq+hlPxZS3TrZTucwNQwVtr/xTVlKwJOnNiCATFA6s
         bGYcraXtZ2hXYH0urEmb9bJ+56hILVeglcswE/9/YxGZbbXnSbh3t9mhL6mMsPEdBCS7
         pKz2HU1Fie3fzIqaGe5oSbeNB+14Vy8tmgFXBlBGDU83neHmr7EarKj33RE8Ym/NNZGJ
         GKzMrphQLtN7T747jeDvn+7UwwgWtbawctIYKWjHPEkCW3v3fdY3oZ9PaC3Scr5kXatD
         Peiw==
X-Received: by 10.68.7.73 with SMTP id h9mr5055560pba.30.1384335944760;
        Wed, 13 Nov 2013 01:45:44 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id ed3sm43211477pbc.6.2013.11.13.01.45.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2013 01:45:44 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.3.g914176d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237782>

Hi,

v2 uses the more sane %(color:...) as opposed to %C(...) for changing
the color of the output, as suggested by Junio. Everything else is the
same.

Thanks.

Ramkumar Ramachandra (3):
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])
  for-each-ref: introduce %(color:...) for color

 Documentation/git-for-each-ref.txt | 14 +++++++-
 builtin/for-each-ref.c             | 66 ++++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
1.8.5.rc0.3.g914176d.dirty
