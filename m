From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/2] bisect: cleanup formatting of git-bisect.sh
Date: Fri,  5 Aug 2011 21:31:29 +1000
Message-ID: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 13:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpId5-0004Nj-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 13:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab1HELbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 07:31:46 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37760 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1HELbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 07:31:46 -0400
Received: by iye16 with SMTP id 16so3511413iye.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WrGLnqFJONbN0XVGJzyhvzpNZONxofc+WOIlh7oqkjc=;
        b=T+kkglpsqAP8HZuHDEwJioq7iqd9DSjE3Mjor750fa6pPS0EftpMRqyeHHeWW65pq9
         mgKg9EYgTw94IKoJ2RW7U174EuoP3Sq5Bsq0veml9nOVQON2CWDtAVTNRCgaYGMrLont
         1CaprhFqHmwC+EVQjpnd1lHAYhQwR1na9HXj8=
Received: by 10.231.112.193 with SMTP id x1mr1640018ibp.59.1312543905127;
        Fri, 05 Aug 2011 04:31:45 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id es17sm757930ibb.54.2011.08.05.04.31.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 04:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.360.geebb0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178789>

This series is intended to be applied on top js/bisect-no-checkout.

The first patch ensures all leading whitespace is encoded with tabs, where possible.

The second patch replaces constructs of the form:

	if cond-statement; then
		then-statement
	fi

with:

	if cond-statement
	then
		then-statement
	fi	
	

Jon Seymour (2):
  bisect: cleanup whitespace errors in git-bisect.sh.
  bisect: replace "; then" with "\n<tab>*then"

 git-bisect.sh |  283 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 146 insertions(+), 137 deletions(-)

-- 
1.7.6.354.g7f57d
