From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Eliminate cryptic "needs update" error message
Date: Fri,  1 Oct 2010 01:33:35 +0530
Message-ID: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1PNF-0005vu-PF
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0I3UE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 16:04:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57783 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab0I3UEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 16:04:55 -0400
Received: by pvg2 with SMTP id 2so600027pvg.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JgpezF6YeGXOCb8pNsbT5snHikyqscHh5hlWb8XkWGg=;
        b=ELiktnLAQFDd30k10lOFyC0+CU3h1Wnf2HX8W16rMm37PJZtT2Aegu9GCT/KLMFQ85
         Vvm1hr7B3hfZyFszDuUt0Rh2pos8zSWs0stz55aXZRHH0twdADuPpx/j7greBnXQ1+EU
         p7phBRP1AhBIhmcOv7NmoU4+51KKK78gOk83E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=irySYbtPRBe/S0qfi+W2vI0fC58rGUXxVEGHrUQfPzHUdXyvVP0RtNOI4ypRvlOjne
         B326ARmRHzBz8fNssaTM4MACEVS1I3rc8ikXlEayRXM07IMLcrnA+9PzjzCMesTNeNoe
         OovEkg8q3X8qoIDR0lQI+X+RZ7adf6TsiFFO4=
Received: by 10.114.61.13 with SMTP id j13mr5068572waa.68.1285877095409;
        Thu, 30 Sep 2010 13:04:55 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm362759wam.19.2010.09.30.13.04.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 13:04:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157707>

Thanks to Matthieu for reviewing round 1: all the changes he suggested
are incorporated in this round.

Ramkumar Ramachandra (2):
  sh-setup: Write a new require_clean_work_tree function
  Porcelain scripts: Rewrite cryptic "needs update" error message

 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   21 +++++----------------
 git-rebase.sh              |   14 +-------------
 git-sh-setup.sh            |   28 ++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 33 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
