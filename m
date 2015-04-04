From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 0/3] git-p4: updated locked file handling patch series
Date: Sat,  4 Apr 2015 09:46:00 +0100
Message-ID: <1428137163-13219-1-git-send-email-luke@diamand.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 10:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJjC-0008Fu-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbbDDIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 04:46:43 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35553 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbDDIql (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:46:41 -0400
Received: by widdi4 with SMTP id di4so125562547wid.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rQe6XDiYVfJDQfHJn63Gvxp7YIaiC4U5VPPC3+Wog5M=;
        b=HVMYiLGEcBJyePBQUzCmA+OzzmLrYc+mWpEKtfrn1S7GvVF2hc648WaonRd/HuvRyA
         5HHLDD74F//xS+l+D61A70ucB3B2qmb3it7Bkp1HhutPo+gZ5tvxA7wfycQ30yY3ZTbU
         kSSmtAxWWTYFTadjJBF+hFAU91Fii84WnseAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQe6XDiYVfJDQfHJn63Gvxp7YIaiC4U5VPPC3+Wog5M=;
        b=V/NpCfC6zrd9WFIvVvIW7GGPQdr036q3eolY2bN2eJqFYD193oe6OLqtSw3GSnNiHA
         NwZDgZt78AjPYBEWFXr6eS8jD13iQfFAq4A1vS9IkGGspzFk/3/OmgbIAnrsCRInxwdc
         s3ox34q5a20t7qNlp4gMTU/U+BJ9V1fKSIky4s/E6NLXDOOVbT+NVWS1l5cmrDWyCQjD
         9P/Vi3EQ+GUBKqLBecYI0I6o5HH+TBCGmU2B6H9sHjLboWbLeEWV4tYCCPlywgzWsXGG
         KXR8tS4qNNh/fofzbDvpTq+LTg9mFLW5KSX66IaUgtRlhTnkMdbJhL8/8QHhjyuNoZDV
         R7LQ==
X-Gm-Message-State: ALoCoQmZEkM3ICR5X/MbRYJ5TYcPrvQ4Dnrlx4Ye4/JGRZ2N6XvA/nB5POodVdrG5TicNJKQBn7l
X-Received: by 10.181.13.36 with SMTP id ev4mr12783232wid.6.1428137200233;
        Sat, 04 Apr 2015 01:46:40 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id s7sm2455742wjy.2.2015.04.04.01.46.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 01:46:39 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266771>

Updated patch series for fixing git-p4 filetype detection when one or more
files have been locked automatically by p4 (fix provided by Blair),
incorporating comments from Eric:

 - squashes the actual fix and the test case change together
 - fixes typo

Luke

Holloway, Blair (1):
  git-p4: fix filetype detection on files opened exclusively

Luke Diamand (2):
  git-p4: fix small bug in locked test scripts
  git-p4: small fix for locked-file-move-test

 git-p4.py                |  2 +-
 t/t9816-git-p4-locked.sh | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.3.4.48.g223ab37
