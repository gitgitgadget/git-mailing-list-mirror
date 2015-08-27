From: larsxschneider@gmail.com
Subject: [PATCH v8] git-p4: Obey core.ignorecase when using P4 client specs
Date: Thu, 27 Aug 2015 14:52:27 +0200
Message-ID: <1440679948-28271-1-git-send-email-larsxschneider@gmail.com>
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 14:52:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUwfZ-00044E-68
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 14:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbbH0Mwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 08:52:34 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37466 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbH0Mwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 08:52:34 -0400
Received: by widdq5 with SMTP id dq5so44204802wid.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uV7fP2/1ZL8c+tbuUJCs+piNss+FuaCfn1m5LfGqLB0=;
        b=rq4f/iFEWPVsTtTMs0bc++kVLfRXn/OnXRFQXHqsauj8xLR4keqkcTZfL501cDr3IT
         hSuIgDcUL8pzGwMi/J39Mv5rlxNCy592WO/lrTwAtcYeIEasRCX1lJB8WgM0TOjwFU9J
         ZyhWNe7APKi1We798O1BfcjGPiaBRcKRbidv++1L8TSfppovAWjjUle5r5Oxj1Q5cp/x
         TA7CJ2K11WbvQX8SUbpi0zG5jKHas1iVk4QnZ7bIE3ihejDDD7ZAUs9lCFHNgWWnXMAk
         o2zmnXNQxmRNF0fptbc1GJOGwsFAgSIfLY6f9RtHDzpn/l9KNp/nRz4XIb9tNArQQ3nl
         Q02g==
X-Received: by 10.194.114.37 with SMTP id jd5mr4886429wjb.34.1440679950651;
        Thu, 27 Aug 2015 05:52:30 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w8sm3503074wiy.10.2015.08.27.05.52.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 05:52:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276671>

From: Lars Schneider <larsxschneider@gmail.com>

I realized after reading the mailing list that my v7 was signed off twice. I fixed that in v8.

Sorry for the spam,
Lars

Lars Schneider (1):
  git-p4: Obey core.ignorecase when using P4 client specs

 git-p4.py                         |   7 ++
 t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 t/t9821-git-p4-path-variations.sh

--
1.9.5 (Apple Git-50.3)
