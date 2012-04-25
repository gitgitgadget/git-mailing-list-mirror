From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git p4: fix for submit/edit unit test
Date: Wed, 25 Apr 2012 09:16:53 +0100
Message-ID: <1335341814-1598-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 10:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMxPj-0000kB-52
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 10:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab2DYIRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 04:17:05 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32905 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab2DYIRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 04:17:02 -0400
Received: by wibhr17 with SMTP id hr17so4214083wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 01:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=vmqE1hJ5uRTwF6bQ25Bmwavi6JZrfWsI5N/5u24LRlE=;
        b=FqLJSbzMuaO4wiWtjmnBVu0+oAdpcuKBwNVJUUGnpvrwtqxRirm53qt/H8sSmd2m6O
         bp31jgpktz5FSWqa0QLvBf7kae26nIAUIeKmMhQe6xg4rW7nxPMXcBY/lkcuezCI0v6D
         uHyBTeX8SbOcyJQswzmpOcrJVJLjZG5yiQnYsecGMl93y6h1nah6xxXKhp/0PTNF657b
         P3teboNM++k3nyy1EEMCRdcuinKVGL1pAAdwoTxOte4C3JgLCZfqtWovtOpqQkPazBoc
         kWZP1t9cwP/ohgxUfOP/riOGzJR8X+L7avxtGZZnK4NsWstotCXBjbnUtKzWQdVWsTKQ
         v6fA==
Received: by 10.180.78.9 with SMTP id x9mr4193125wiw.18.1335341821056;
        Wed, 25 Apr 2012 01:17:01 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm35739849wib.3.2012.04.25.01.16.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 01:17:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.473.g0796
X-Gm-Message-State: ALoCoQnfuVqMwq6RYmL67iSUOHh4wRgl0d4khpVj248Vf5GTX/si/6mPNJjpyDFbcVPdJcGwlopz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196302>

My P4EDITOR changes broke the submit/edit "git p4" unit test.
This fixes it.

Junio - would you prefer me to resubmit the entire series?

Thanks
Luke


Luke Diamand (1):
  git p4: fix unit tests

 t/t9805-git-p4-skip-submit-edit.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.473.g0796
