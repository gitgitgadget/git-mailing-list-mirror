From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-helpers: fixes
Date: Sat,  7 Dec 2013 07:09:39 -0600
Message-ID: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHkz-0003Ci-N7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab3LGNRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:17:14 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:49262 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3LGNRN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:17:13 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2041533oag.7
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bSLluv8PveMaA9ZtXDnKnOUD1h8LV8AGWtjrw6ikFbI=;
        b=FxHIM3EOvrf36TSp5/n6CPg2dEF2hLE1ibvgrhcIwsPSYzS9EWKkmnqZcNuvEgdXfb
         0xnrLfSz6ciEozl36dpHJa5kDtwb0/60Io/DW9FvXgcSAAYPhWKUwQ0PAPV4ZmWSkZG4
         npMNoKesp+PedbbpYbLLQReLtvro+cp1+/ugE4vT6IRKuLmyQ26H3fpa5e7IFKdec6T3
         b5jlM9a7l1oL4diYY2dFhoCeLezB/ObavFPua9fbrDuMJ/NFHQd7XEXM8Kb1S/qNG53F
         bhdjdQQM8vnG0Gr2wvDeL1lvf5X2DTWzk5Z0qLLRJVkdSw/3WVSNpuQcYHqlgE1qmEdO
         3gfg==
X-Received: by 10.60.59.99 with SMTP id y3mr42627oeq.70.1386422232069;
        Sat, 07 Dec 2013 05:17:12 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm3949528obc.10.2013.12.07.05.17.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:17:11 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238979>

Felipe Contreras (3):
  remote-helpers: add extra safety checks
  remote-hg: fix 'shared path' path
  remote-hg: add tests for special filenames

jcb91 (1):
  remote-hg: avoid buggy strftime()

 contrib/remote-helpers/git-remote-bzr | 14 +++++---
 contrib/remote-helpers/git-remote-hg  | 19 +++++++---
 contrib/remote-helpers/test-hg.sh     | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 9 deletions(-)

-- 
1.8.4.2+fc1
