From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: BUG. git rebase -i  successfully continues (and also skips rewording) when pre-commit hook fails (exits with non-zero code)
Date: Mon, 28 Nov 2011 11:15:51 -0500
Message-ID: <1322496952-23819-1-git-send-email-andrew.kw.w@gmail.com>
References: <20111117125847.190e9b25@ashu.dyn.rarus.ru>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 17:16:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV3sc-0003eO-I2
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 17:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab1K1QQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 11:16:25 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62810 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1K1QQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 11:16:24 -0500
Received: by vcbfk14 with SMTP id fk14so3772961vcb.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LQ85+/Iylg60Qgl3NS4b2KuLKIrdzjpqGcQc8jSc4I8=;
        b=QOficmuBMZ31voZWpF3GLifNbrQyHaIyK0QxO0HnZ4KnWReQDRvIJ/b91bzvSYFIpU
         6+Hd0/esrvz7LDBCBSZfAhQDZ2FtWgFsJZjGA6tlymXyFbA82sJpHFB616JMFiF7LVzy
         SJmUwsHvrEgtISiM7+tYe6BweO6QEDr8SlbL4=
Received: by 10.220.247.208 with SMTP id md16mr1702688vcb.43.1322496983982;
        Mon, 28 Nov 2011 08:16:23 -0800 (PST)
Received: from nigel.sohovfx-toronto.com ([66.207.196.114])
        by mx.google.com with ESMTPS id q17sm14153192vdi.14.2011.11.28.08.16.22
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 08:16:23 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc3.32.gb2fac
In-Reply-To: <20111117125847.190e9b25@ashu.dyn.rarus.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186019>

I actually have a patch to fix this sitting in my repo for a while. Thanks for bringing this issue up again.

Andrew Wong (1):
  rebase -i: interrupt rebase when "commit --amend" failed during
    "reword"

 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.8.rc3.32.gb2fac
