From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 0/6] Update to janitorial work on hook templates
Date: Sun, 14 Jul 2013 18:21:13 +0200
Message-ID: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP39-0006qQ-UF
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab3GNQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:24 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:37564 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3GNQVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:23 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so4287082bkb.36
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pbTz8vYVRMtp1molgP+DvyprtJ0RpH+4D3uNwTzWFC4=;
        b=HHXdafTbrv3ruuJlwYC3xnsBr0flfUXaUduS+bPv+hHiGZj+AMgHEKxcBDDJmcEvLf
         ++p6QE5XjzGUVBw7UFwrUg/ssqItfwGhoMQS9uuLqzlOAtbZc3tMYL9c6ZsAJNt9WpcF
         VAsm1fxo/EcmOirUJMEJtsrdZjQgn181R2OINWUZa73lMjJ1t/y1IkLHNq4vvZfuAL6p
         k3IzWc5Un1xkz/ctFZ7IdNLXRXRTyoAjm8o7M4hasypOzOr3W69/s6AvnmWS0A8zZPmi
         k38DwHENehslivrAGyUynYc20QQHYoRD6x+CC9ROG33Mn9QyT9fFX64wFrUMW4zfrmrf
         mPJQ==
X-Received: by 10.205.1.198 with SMTP id nr6mr7394961bkb.168.1373818882222;
        Sun, 14 Jul 2013 09:21:22 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230370>

Dear all,

I worked Jeff's and Junio's feedback into this patch series, referencing
the old commits.

As stated earlier, you are welcome to drop 1/6, but 2/6 depends on it.
Your choice, both is fine by me.

Thanks,
Richard

Richard Hartmann (6):
  templates: Use heredoc in pre-commit hook
  templates: Reformat pre-commit hook's message
  templates: Fix spelling in pre-commit hook
  Documentation: Update manpage for pre-commit hook
  templates: Fix ASCII art in pre-rebase hook
  template: Fix comment indentation in pre-rebase hook

 Documentation/githooks.txt         |    3 ++-
 templates/hooks--pre-commit.sample |   27 +++++++++++++--------------
 templates/hooks--pre-rebase.sample |   26 +++++++++++++-------------
 3 files changed, 28 insertions(+), 28 deletions(-)

-- 
1.7.10.4
