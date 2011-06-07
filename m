From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2] rebase -i -p: doesn't pick certain merge commits that are children of "upstream"
Date: Tue,  7 Jun 2011 00:08:44 -0400
Message-ID: <1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>
References: <4DEB495F.9080900@kdbg.org>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 06:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTndy-0003OJ-G2
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 06:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab1FGELs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 00:11:48 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34421 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1FGELr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 00:11:47 -0400
Received: by gxk21 with SMTP id 21so1738907gxk.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FZ68HXDPJ6yAB07V/pvC7NswZ7y3rrTZl5M1+vL9a/I=;
        b=ItL+y1CQHjAzYSe+8IKj5cjcanXy/5wxvC3YPZ0smutXh6WXo78qPjTd2KAS6r4pqS
         d6pEKZik2hEUDKgNl6+OUkb5cu6XPpSICgBpP6XSzDMsvKQj46z2H9MItym0Z9x4tE+8
         ospFZRPV+Syagu/u9qG2wzxbaayC7dcRYaq4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gaS9anOWYhKE6UEiho1LIWr3CLVeD/N9u9X1c+Ce5lqzJR+bwhSOvnX5RtVEE5+V0c
         anVDVzohGM2aDoqLnKIPQsi0atzhbOyFo+0IDqETOG3I/5z7iFiUSP2OMQGmlhlvjaNw
         lO9HCA1x2NY+7jY+3qQLSbZJTsEPG+xA2UAt8=
Received: by 10.236.190.73 with SMTP id d49mr6503646yhn.528.1307419906704;
        Mon, 06 Jun 2011 21:11:46 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id g30sm79793yhn.57.2011.06.06.21.11.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 21:11:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.1.gf20d7
In-Reply-To: <4DEB495F.9080900@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175184>

This patch contains an updated commit message.  The "-p" flags, which are vital
to this issue, were completely missing from the previous message.

Andrew Wong (1):
  rebase -i -p: doesn't pick certain merge commits that are children of
    "upstream"

 git-rebase--interactive.sh               |    3 +--
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3409-rebase-preserve-merges.sh        |   28 +++++++++++++++++++++++++++-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 4 files changed, 30 insertions(+), 5 deletions(-)

-- 
1.7.6.rc0.1.gf20d7
