From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH v5] use starts_with() instead of !memcmp()
Date: Tue, 18 Mar 2014 21:18:02 -0400
Message-ID: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 02:18:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ594-0008Qn-UI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 02:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbaCSBSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 21:18:10 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:58967 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758493AbaCSBSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 21:18:09 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so23689574qgf.5
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ABvpKWmwNA8IYI6xI8P6rc3JA5sAICBAc5XwbTfo9DQ=;
        b=jmeyys83Wtt5mRPyUq1LfKPd7CpH53Meg3yydMjgWuw5d9eTe6uAc/7As1Wv5Izdgy
         +Xt5ko6it0rLM9fLqHLdmA3MddY20Tc3pLkDNCNpI5jTt++oYw55AiT8loTYO7YxT5va
         RAQxRYZKK7jIxnuAYL/wlAIQN+pzIB2o66TG2QBqEBarCgk2RBTJDZVSaBPbA1OWyBsX
         XVAOFZFnBarurB5F2Y6298Oi5WVc1/1lrpSRn+nl63XLii1am/VFYrmvBC9HT9/nQpcn
         lTnABxgeGHHk7n5sQN9a8giKakar2WOKQEx5rqnIZ0w4L2VIladPvhu1FcM1fOOoxo/E
         oC3w==
X-Received: by 10.224.131.193 with SMTP id y1mr14078094qas.86.1395191888361;
        Tue, 18 Mar 2014 18:18:08 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id r31sm28701190qgr.12.2014.03.18.18.18.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 18:18:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244402>

Another version, this time very in line with the review and commentary of
Junio, Eric, and Michael.  This version boasts a revamped commit message and
fewer but surer hunks changed.

Thanks again for the guidance.

Quint Guvernator (1):
  use starts_with() instead of !memcmp()

 builtin/apply.c        |  4 ++--
 builtin/for-each-ref.c |  2 +-
 builtin/mktag.c        |  2 +-
 builtin/patch-id.c     | 10 +++++-----
 connect.c              |  4 ++--
 imap-send.c            |  6 +++---
 remote.c               |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.9.0
