From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 0/3] git-p4: Improve branch support
Date: Sat, 26 Feb 2011 23:46:08 +0000
Message-ID: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 00:46:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtTqN-0000JL-Br
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 00:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1BZXq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 18:46:29 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab1BZXq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 18:46:28 -0500
Received: by wwb22 with SMTP id 22so1746968wwb.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 15:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=wxXILrAIPqAElIs6UhVaLEmoqMi15s35KlzUl1Jvy9M=;
        b=xBrd0ImSjTKrmEKVO3crwSXitZc7ZJgy8hAk1JkfVxEFnwfyYaeFUpSc6XVvUhz7zT
         11WYx9pe/DwKygokAN3gKBhklJFapmRkXY5Xo1azztpn9nYm9MBhpAiACwott+anJ9mj
         /TgD8hnH9n6VDoLdy3ckvQeu0R30qjE8TyHLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KqG0vdp3jGWKLXx0TRMyxPYedwwVumKE3grVg++04xe42TIwM3YdJPRBL25vY+lphj
         rU4FbkXWzN3ZG1fdCbnw9PuPlfSJsfmWiUBYVha79+ZmopejORwahv3tPkmXlkZOBzl4
         ZbFUxTCSsAecNW+h6Ad6RipHXpkEFHpHKjgYw=
Received: by 10.216.87.131 with SMTP id y3mr922318wee.3.1298763987318;
        Sat, 26 Feb 2011 15:46:27 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id n78sm1121697weq.27.2011.02.26.15.46.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 15:46:26 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167998>

In this second submission I've split the patch into 3 different commits, one for
each individual update. I also added a description of the newly added config
options to git-p4.txt.

Vitor Antunes (3):
  git-p4: Correct branch base depot path detection
  git-p4: Allow filtering Perforce branches by user
  git-p4: Allow branch definition with git config

 contrib/fast-import/git-p4     |   40 ++++++++++++++++++++++++++++++++++++----
 contrib/fast-import/git-p4.txt |   13 +++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
1.7.4.1
