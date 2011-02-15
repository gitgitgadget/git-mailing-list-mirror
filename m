From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 0/2] git-p4: Improvements to rename and copy detection
Date: Tue, 15 Feb 2011 23:49:47 +0000
Message-ID: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 00:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUex-0006FG-Qk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab1BOXuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:50:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58447 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1BOXuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 18:50:13 -0500
Received: by fxm20 with SMTP id 20so773563fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=x5jhEKx5cxDs4vMAIOIgBghXwFc2LyfNN+NBLsNCL1k=;
        b=RUb7yGOBsSebh9OrSqO0PDCwWoCNWYaUJI1mtaBwUGCMao2y4nQVQqPD25af05/eOb
         1TkX45+/5tyE30BMJdm/VfZGm6YECj2veuxRDGBHDCw5jR46GcLbJfERS9htzqVwh0UI
         yBlp+wH2gR2pXgRIlUfCwN2tqnJX9hlw9nbEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MPyjAhF4viI7mkNlmEzVjHuVlV/j2S5ixrqPSkqJQB9wdCMFmMGaBK20xHQaxxS90T
         zzIEdnhgZaklfpbyhLRB23uIZHMNluFerxUH54sImWUE+iiJ61FIG9x+U0mg7IXaOiAB
         1L8uPlc6EKphSc5YMwOgRpW0bHIKMm3MOq9xg=
Received: by 10.223.107.147 with SMTP id b19mr6960111fap.118.1297813812542;
        Tue, 15 Feb 2011 15:50:12 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id f24sm1985515fak.0.2011.02.15.15.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:50:11 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166902>

The new version of these patches should, hopefully, contain all the corrections
that were discussing previously. Please check them and confirm everything.

In the meanwhile, I would kindly ask you to review the third patch I sent with
the subject "git-p4: Improve branch support". Regarding the specific point of
branches, I've had a discussion about branch origin detection in the thread
"git-p4: Corrected typo" to which I would like to have your opinion.

Thanks in advance for your time.

Vitor Antunes (2):
  git-p4: Add copy detection support
  git-p4: Improve branch support

 contrib/fast-import/git-p4 |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

-- 
1.7.2.3
