From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Building git with NO_PERL=1 will install git-submodule, which
 depends on perl
Date: Sun, 24 Feb 2013 22:12:19 +0000
Message-ID: <1361743939-ner-9747@calvin>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 23:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9joR-0001Ut-RO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316Ab3BXWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:12:27 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:36601 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758023Ab3BXWM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:12:26 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so1946235wey.32
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:cc:mime-version:date:message-id
         :content-type;
        bh=6JlHsV5eMEVv2h7UZcY/BXpJyrU4Oh3Qs+dUz8acYBM=;
        b=TOH3FV1vo9SSEKqEA4snoqM9vVKD1OK+9Ls/+weVsPw4FNaqycmpip/qgnTZmxEw0y
         J92IVleRODBy2JCIiTjshtohfI+VwjRStTBLRj9CYgynaDpN7KfI+5v1llgkxz/FiLlL
         cY2n2lj4sInEIm23BAxP7JTD72dXNP3QOY7AFH4WW7zbl7l4YJVJN1zzPE1b5XPw189S
         mJwxGkBeJMkjCBzEn0Wknuefv+ZX/1eEhSvZWkfebGMaimxMeC668au8jcDar1cCn73P
         srSpZtv67lODtn8WEzinrmFSyuFdZs/gB9ve+cKkSXmSiPwxeZWKmrhJQw47HoCURrV1
         3Bvg==
X-Received: by 10.180.82.231 with SMTP id l7mr8355229wiy.15.1361743945204;
        Sun, 24 Feb 2013 14:12:25 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id dw1sm12805542wib.5.2013.02.24.14.12.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 14:12:21 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 62484EB7B4; Sun, 24 Feb 2013 22:12:19 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217008>

Compare with git-instaweb which is replaced by as a small shell script which
informs the user that the functionality is not implemented.

I've only checked git-submodule, other commands may also have an undocumented
dependency on perl.
