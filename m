From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] Fixup test-lint error in git-p4 t9814 test
Date: Tue, 28 Apr 2015 08:21:21 +0100
Message-ID: <1430205682-4309-1-git-send-email-luke@diamand.org>
References: <1430202609-31841-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 09:22:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmzqE-0004gR-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbbD1HV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:21:58 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33915 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbbD1HV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:21:57 -0400
Received: by wgso17 with SMTP id o17so140953671wgs.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zb0CA8LdmXMTV3FPQ6h1Qu85GRlN43tv6IzEszuqGnI=;
        b=alNrBumFsQnYk48msEtTk3kjME1Y7oBgZh7OO78b3dndvtEdFUrBgHIK+8q6OznxbB
         0xwVHWb0KgA9UjUgbQtEzkeoBXN5V3OsMWTo5j5Ean37mrpwF+Q1kP2LABTuEbyGrpn7
         w27WvWE9vPD+AJ15NcoAY9efEmhivEQQn+wLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zb0CA8LdmXMTV3FPQ6h1Qu85GRlN43tv6IzEszuqGnI=;
        b=Lcqi/2exNcH8Bokx63blQnwJCV+iVE0welDep+sVd1KcB+eOziE/2UkINQevYjFVQY
         E0fAqmTHDsNh1EIrzgjotugm7hnIoxC2KslkuC2r8+x+bc6j8SaHlo4QoHDMoAA9MDMr
         bcic9iuvxehmzkq/gSAro6ykC94rGVV1peACHdkZP8l2JndqE8k4H6RShQcr8CnRcpZ7
         NVh+5qJWHJHTIaB9K4xgLdAB/azbbOrJM3Om2GxXAKigh2Zl7TbsCy1sPo4ZWigIt+7Q
         8M5f+u/2sEXgYQau0PCHtLxnrBOqnyT9qMgBaqzt4NkIcTqLxDg39aQDuSNhVcNX2C+J
         O/KA==
X-Gm-Message-State: ALoCoQlUQ7IYFtb36qZO6ad1QTKygMZwJethvYEp/Yv8Eur2agrH7WZYjTmjgCGN6ojPT0VpvQXs
X-Received: by 10.194.3.77 with SMTP id a13mr29817811wja.104.1430205716035;
        Tue, 28 Apr 2015 00:21:56 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id gj7sm14954864wib.4.2015.04.28.00.21.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 00:21:55 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1430202609-31841-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267909>

Using Jeff's suggestion of converting the t9814 test to use
test_lazy_prereq makes the test a lot clearer, and as a bonus,
also fixes the --chain-lint error.

Version 3 of the patch corrects a small typo in the commit message
of version 2.

Luke Diamand (1):
  git-p4: t9814: prevent --chain-lint failure

 t/t9814-git-p4-rename.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.3.4.48.g223ab37
