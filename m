From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 0/2] Improvements to rename and copy detection
Date: Sun, 20 Feb 2011 01:18:23 +0000
Message-ID: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 02:19:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqxx5-0005np-Df
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 02:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab1BTBTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 20:19:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1BTBS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 20:18:59 -0500
Received: by wwa36 with SMTP id 36so5016609wwa.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=QsRoimA/cmVyPZPsDTleHsbuSYDtSTtTaLWv92sHc3g=;
        b=naN+cu3ZRk6HJsQNok/gwQxMyGLBeI/xuavthpJAFLLbfxIZg+RBXfENzi78TJ5L8Y
         FTlGG+KRjmTJzMcZ6yHaIgIl/stIY3BG0Ips3JZfYsZSxurTY6/ifWcTmOSzoeOk2ZTd
         BSgDzmNDUhE4HDjS3aHaRukMH7Xmw6W/mwil4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=um6Ol1yrPd6qTH/OxbdjN5z+xSr+3DQrCLPKLZtjB7x4FtSDIZkYbHT4TGGuVDJGp2
         Lw6t4jCXNeLGJPfrENnmIvlzIAPNN5y8lBj4CqTliwZ0fmkkWldyr1PgBdMRhaIjAzyn
         XBO9k8Jr6fHKnWfToX0VqwquboDhmDmxbZyQw=
Received: by 10.227.156.79 with SMTP id v15mr2047402wbw.132.1298164738584;
        Sat, 19 Feb 2011 17:18:58 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u9sm2909192wbg.12.2011.02.19.17.18.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 17:18:57 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167387>

I'm resending this set of patches because the last set I prepared did not
contain the correct patches. This new set should make everything clearer.
Included are the changes proposed by Pete and Tor, as well as Pete's
acknowledge of both patches.

Vitor Antunes (2):
  git-p4: Improve rename detection support
  git-p4: Add copy detection support

 contrib/fast-import/git-p4 |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.4.1
