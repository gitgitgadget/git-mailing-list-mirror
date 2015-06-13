From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v5] git-rebase--interactive.sh: add config option for custom instruction format
Date: Sat, 13 Jun 2015 12:26:57 -0400
Message-ID: <1434212818-94682-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jun 13 18:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3oHD-0003dH-El
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 18:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbFMQ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 12:27:17 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34652 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbFMQ1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 12:27:16 -0400
Received: by qkdm188 with SMTP id m188so10569572qkd.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J/hae1LNZt79r4Ogc1UPmMwNeVBbcjWYyee6y308+KE=;
        b=UjncQd0mxCu2rvkaNNwsbfwzOHEXEonuMgaRM8eOyvF53udN1j50OyTrhuDWiAf57V
         j2ZWrTBBuKc90ti0eigX8MRZ80ABoaULLXZuLFz2fgKSktx9ZsQGsmm/rp9URrQcKtK6
         mAY0NLfxP0Op/02v4UKEb8CfldQBKeVmezXOv/7o8FfKY/FsUZgfCPFdw4Fnmckupbqw
         Y2iRXfReo870f/oc4MU4b0BeMXPTI2ESkQMOaFpKGpVuvQmwqul2/R+UDXYC1ZPabcHF
         i3oScMv+xolcE2Gz85impfWe3vUulv3KeHEAPTByernWWDIunTE8ZfP01KifhLEgBCV1
         B7gQ==
X-Received: by 10.140.135.6 with SMTP id 6mr27065598qhh.101.1434212835542;
        Sat, 13 Jun 2015 09:27:15 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id 197sm3366478qhq.23.2015.06.13.09.27.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 09:27:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271560>

Difference between v4 and v5 of this patch:

  - added documention in Documentation/config.txt
  - renamed the new auto-rebase w/ config test to be less inaccurate

Apologies for this, I should have caught these before.


Michael Rappazzo (1):
  git-rebase--interactive.sh: add config option for custom instruction
    format

 Documentation/config.txt     |  5 +++++
 Documentation/git-rebase.txt |  7 +++++++
 git-rebase--interactive.sh   | 20 +++++++++++++++++---
 t/t3415-rebase-autosquash.sh | 21 +++++++++++++++++++++
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.4.2
