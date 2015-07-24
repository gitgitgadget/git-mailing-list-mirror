From: Jacob Keller <jacob.keller@gmail.com>
Subject: git hooks and environment variables
Date: Thu, 23 Jul 2015 18:50:08 -0700
Message-ID: <CA+P7+xo+SYBYOrt-72mySBe=KusgD50T0QQsONYVTf7gcbHPww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 03:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIS88-0005Fu-QU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 03:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbGXBu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 21:50:29 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:32936 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbbGXBu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 21:50:28 -0400
Received: by ietj16 with SMTP id j16so8020599iet.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WP2Fk7ZFXFRJD44RNNBXRWV4ttx44lr1SXtHqyUdR5A=;
        b=a2hWQChwMoNxdE2ZbkYUYf8xT1+vy9URYVs4CvDUI4uMLgOkUjLnUDGS+tAubFB2qS
         V1j1J1xmSzTdkDZq3f8gQAl1YaIzfbisj7lOukPxuWZFxRz64RhE2ID8YVRGQN90+wyF
         4TnrjhB3rA1gXqDAwZ5LFuJZY8gR1kH3GIpszURCIChg1qQBQ6cBrBBL00Zwf5eiRxy/
         OJY9ej9cEBopvLmo+dLEpqTXud6vNePSKtKW6NjgDRTfBiQQsmf7kvxL86Nr/EPphqhH
         g/UzWTRdUDrUdc9tSl4VkVg9rNi5uGKAF/RItvJ73p2rESGZ2EF+InMlsaBbfIdN7FKL
         /HIA==
X-Received: by 10.50.23.98 with SMTP id l2mr1265794igf.25.1437702627809; Thu,
 23 Jul 2015 18:50:27 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 18:50:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274536>

I've noticed that not all hooks have all of the environment variables
set when they are run, and it is not clear from the manual pages which
hooks have which variables set on the command line. Specifically, they
don't all have GIT_DIR set, I haven't taken the time to verify exactly
which variables are set and which are not yet, but..

Which would be preferred? documentation of the current behaviors, or a
fixup that ensures that all the relevant variables get set?

I intend to have complete details as to which hooks get one settings,
but I had this at work and don't have it here, so I can update this
thread with the information later.

Regards,
Jake
