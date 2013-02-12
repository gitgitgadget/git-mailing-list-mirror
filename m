From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH 0/2] Add bash.showUntrackedFiles config option
Date: Tue, 12 Feb 2013 21:12:14 +0100
Message-ID: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
Cc: trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:13:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MEH-0007NQ-4o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab3BLUNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:13:00 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58833 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3BLUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:12:59 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so409866lbo.19
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=xdJ/1hWAyL01h4MqrMAYMsUXT9ydQ788r073ai8ha7A=;
        b=fZ+kIeMysmjMdh4pEafW1rCWl52ckimW0FkIUPn0Rw3gAFDiXfGU/yDmdbCtZpCT00
         udrBEizSrDxw56nRGmeerdom8oqTk0aEUmVtw4O6W/Egn73GFai7zZIP3vumHkaefMgA
         bcJV8yxZXaVSE9wD666pIEF+mjbOxpu23z6FAkS6DnirNZgXOKWhO5lip0qPzotioHQG
         grt2dA4r2Ka9ofhoWa4/jLLkpc55SRQ7z1ac6MPbnJN708c55HjnyyHPDwWBJ1bj9uYz
         s2Az/NQpU2LvXypJavHO2hVQdf/1rYTVEoIQiYOeaaw+H3FQAXHVlH6NqhNw7YDKHe2K
         po/g==
X-Received: by 10.152.134.164 with SMTP id pl4mr8424366lab.54.1360699978150;
        Tue, 12 Feb 2013 12:12:58 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id xw14sm8927784lab.6.2013.02.12.12.12.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 12:12:56 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5MDk-0007UV-Kb; Tue, 12 Feb 2013 21:12:52 +0100
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216183>

Hi,

Here is a patch adding a config option for showing untracked files in
the shell prompt, I've noticed having it enabled tends to make the
prompt act very sluggish in some cases (large repos / unfriendly
filesystems). So it would be nice to have a more fine-grained control
over it, similar to what exists for bash.showDirtyState.

Martin Erik Werner (2):
  bash completion: add bash.showUntrackedFiles option
  t9903: add test case for bash.showUntrackedFiles

 contrib/completion/git-prompt.sh |   11 ++++++++---
 t/t9903-bash-prompt.sh           |   11 +++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.7.10.4
