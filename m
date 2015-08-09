From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2] worktree:  list operation
Date: Sat,  8 Aug 2015 20:19:58 -0400
Message-ID: <1439079599-87904-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sun Aug 09 02:20:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOELs-0004Ge-VF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 02:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992802AbbHIAUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 20:20:09 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33914 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992728AbbHIAUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 20:20:08 -0400
Received: by qgeg42 with SMTP id g42so60697819qge.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 17:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nlE/MhvxMkvpKk8ZByd7IQ1Z1Bf8oaYUfCF/Ac8nrtk=;
        b=zrNKzvCqP4b99EL1NlxupEglID9tP+ZkZxffxswOprZmXIpS0cFXpj8+8ZSh8jwQjq
         H3DSEyfyxPgxFELHQyiKc8eBagHbP+f/jJvRikpP/XGk5ratzl4NR+2QL6zEKcV41Xwt
         vhdjpwYbck4SeRipx6V92MYyb0Uvx/L7OSWe0nlXnJ5oyVzkoM+4TJhnpM9/3o613Xzw
         484bvyhxCquMmbkxtXRNx8bYkclDNDNFZCQt0En4Zxe+7zc8kQXhijszz9wF9gvZS6pj
         L3vzzdLQmbX1dmFLXM7S+lbkjWjVByuex8fkWZUs+06aQdbC6jyvYefRbJWW+sQkhpQT
         ilaw==
X-Received: by 10.140.238.212 with SMTP id j203mr28041643qhc.32.1439079606598;
        Sat, 08 Aug 2015 17:20:06 -0700 (PDT)
Received: from MRappazzo.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id 36sm7380325qgp.8.2015.08.08.17.20.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Aug 2015 17:20:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275521>

I am attempting to add the 'git worktree list' command.  

I don't have a lot of c experience, so please double check that I am 
not missing something important.

Sorry about publishing the first version too soon.

Michael Rappazzo (1):
  worktree:  list operation

 Documentation/git-worktree.txt |  9 ++++-
 builtin/worktree.c             | 80 ++++++++++++++++++++++++++++++++++++++----
 t/t2027-worktree-list.sh       | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 7 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
