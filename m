From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 13:38:40 -0400
Message-ID: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 31 19:39:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEH2-0000aJ-AD
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbbGaRjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 13:39:07 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36542 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbGaRjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 13:39:06 -0400
Received: by ioeg141 with SMTP id g141so92639447ioe.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DibKzBFX7AP4E8CQemCwhs22+uNxRVGp4VRnhkA3hGc=;
        b=G0x17yFrxdv1HR1FHKqx/mtAGebdvx4ZAMorbaACcy6JkOhqqAZf3RbV3FN+LtZSfV
         YkbFhJbOefrtz4EQRUdQi8Gi9fC3xth7A8iOvzouNckqWJFcdWUjmv98TY11L/PJLqhc
         aPVq2JeOAmURj/WRlPaOFeRHLBKhgwGvsLmlOynvehxrJ70su+sldSSj9BOKqHmuPZpa
         uWv+nahoenGOS2Nxc7x4fSwwv+RxzWWEdFVw9UsZVtshhI7vBdb4K+4merncJQvt8WDj
         Ljze/pwhWehO5PUDKkaNsfNBrJwaNcVCRbvEm3u9PlToVz7gCoJAQwlaF22ABhpf57nd
         wpDg==
X-Received: by 10.107.166.72 with SMTP id p69mr7469685ioe.65.1438364345044;
        Fri, 31 Jul 2015 10:39:05 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id ht6sm2729122igb.11.2015.07.31.10.39.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 10:39:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275057>

Not sure if it would be better to make a new variable or to reuse the existing
one. I'm reusing it currently because it makes it easier to ensure they
are mutually exclusive.

Please keep me CC'd to the list; I'm not subscribed.

Thanks,

--Ben

Ben Boeckel (1):
  ls-remote: add --get-push-url option

 Documentation/git-ls-remote.txt |  7 ++++++-
 builtin/ls-remote.c             | 15 +++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.1.0
