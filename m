From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/6] minor documentation improvements
Date: Fri, 24 Jul 2015 00:00:51 -0400
Message-ID: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB0-0004GR-VA
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbbGXEBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:33 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36764 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbGXEBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:32 -0400
Received: by igbij6 with SMTP id ij6so7217945igb.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wBOEtxCSRixg0JmAZimoAZsmz6IavX+abkrOATT0lA0=;
        b=ETnuQexwd0+h0wvzFYYgts0L2uEBj4eXFI+uWacGe5WllFsQQQFH2Ym5fNBZ2N4UYs
         UBUB3pPtwAXSJcn/+3b+2mM6C4Ue7YjvjvFOe8oC7c9nr2nwuzLJmDTeSyXp2nbC3Y+D
         6iY+8yieAqjJN8J5k2uwFHoSsMV1Zw0QPQwSboi5Kw8N0YAERXi/R716HaROJ4Q5lOn0
         XrNbYbSYfwFc6qyAuOGYzYfYwkeR6BpELv67L7H1hzeloIAGP2EdtDicgCtss9sb6neN
         AdfKXANlI/49LkbGh3kCzy2CnczKkGBELcncx2ZA3tUBZpG31n4QbKL5UhxiFV8xXent
         Bw/g==
X-Received: by 10.107.34.147 with SMTP id i141mr18175557ioi.59.1437710491809;
        Thu, 23 Jul 2015 21:01:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274537>

This is a set of minor documentation improvements, prompted by
suggestions from Junio and Michael Haggerty, plus a few things I
discovered in the process. It is built atop 'es/worktree-add' in
'next' in order to avoid conflicts with changes in that series (but
is otherwise not related to those patches).

Eric Sunshine (6):
  Documentation/git-worktree: fix broken 'linkgit' invocation
  Documentation/config: mention "now" and "never" for 'expire' settings
  Documentation/git: drop outdated Cogito reference
  Documentation/git-tools: improve discoverability of Git wiki
  Documentation/git-tools: fix item text formatting
  Documentation/git-tools: drop references to defunct tools

 Documentation/config.txt       |  13 +++--
 Documentation/git-tools.txt    | 124 +++++++++++++++--------------------------
 Documentation/git-worktree.txt |   2 +-
 Documentation/git.txt          |   2 +-
 4 files changed, 55 insertions(+), 86 deletions(-)

-- 
2.5.0.rc3.407.g68aafd0
