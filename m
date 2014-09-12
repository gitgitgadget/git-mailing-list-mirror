From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 0/2] describe: support the syntax "--abbrev=+"
Date: Fri, 12 Sep 2014 11:26:42 -0300
Message-ID: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonh Wendell <jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 16:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSRoj-0005ae-TG
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 16:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbaILO1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 10:27:13 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:42752 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaILO1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 10:27:13 -0400
Received: by mail-qa0-f48.google.com with SMTP id v10so788356qac.35
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z9x/rQIqxpVRybr/chTp/iem4gWGskVSs0+yj2vPu4k=;
        b=DTlw3y90fHuAaXSbbudMnn/jMhTPWFhp0iZl7NNe5fpL/Of2w8OkByVIF7VUDBdv1e
         kKMyAA/jV+bo4MhGw9soXDhY9DoMn1saqBW0eA24NuennquJljypHNXQNey2gkAN9kNO
         l+lLBa+vqvt6bhZdsTVjwk1qi53IjXBCdNwE7wPU1hj6Me0nq5aZBacKBQ8rIMiVMVdV
         JcTjXMNI2fzMaq13efparKZ/mOyxMOqZ3ZykMAoBdq+ZfRZORB+raLZwF85uDbTDqxBG
         Rx/DSOPH+BfXIdvEXBTwhsURjq7kKODhoHpgmLvISUk4VFUzHXCz865HXmEo2E5TSyJI
         lH2Q==
X-Received: by 10.224.30.14 with SMTP id s14mr12708796qac.70.1410532032007;
        Fri, 12 Sep 2014 07:27:12 -0700 (PDT)
Received: from wendell-laptop.spo.virtua.com.br ([189.102.225.80])
        by mx.google.com with ESMTPSA id y10sm3088066qar.29.2014.09.12.07.27.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Sep 2014 07:27:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256923>

Sometimes it's interesting to have a simple output that answers the question:
Are there commits after the latest tag?

One possible solution is to just print a "+" (plus) signal after the tag. Example:

> git describe --abbrev=1 5261ec5d5
v2.1.0-rc1-2-g5261ec

> git describe --abbrev=+ 5261ec5d5
v2.1.0-rc1+

First patch was sent in Aug 23, re-sending with Signed-off-by and
CC'ing Junio.

Jonh Wendell (2):
  describe: support the syntax "--abbrev=+"
  describe: Add documentation for "--abbrev=+"

 Documentation/git-describe.txt |  6 ++++++
 builtin/describe.c             | 26 +++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
1.9.3
