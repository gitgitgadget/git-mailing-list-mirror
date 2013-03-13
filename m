From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 0/4] contrib/subtree: general updates
Date: Wed, 13 Mar 2013 22:32:39 +0000
Message-ID: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuF3-00050i-3y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934329Ab3CMWdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:33:21 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:60762 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab3CMWdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:33:20 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so1491209wea.38
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=S/q7HOtUc+iXG9YkBG8IhkmO3NIor1Tst5jowkLHFEs=;
        b=QSsK/djY5tmkEiFs93pQnR7+2cPmAEK9IMD6vLCe+ulUgTIlu0lv7BGu6NH1UpXYqc
         ncIswsagR+f+B5rsLLfdRWpcJBcbJNQGh6p1jQRrNoiu/Hw7wtJqelHCSQ0xmOB1mhYy
         WRZdnTI2mtOpK9spoIztZX3ky5yqSa1oVgsx3f8E176PfHDI6bhuIxyoWEoW7HHjqJAA
         SJeegCCmtnai5mR+busq/GNUAIqFKHDngG+C02a5dZg4HraaexBFOUjB2PDZ4Wmby7om
         O3U4bFMkdiE1SlXYLH2aElbBnDmiMog9z7EDzQVIuBPXXTCLvaGI8A/G7r/vsaDJLLNv
         GjgA==
X-Received: by 10.180.103.65 with SMTP id fu1mr188054wib.4.1363213998976;
        Wed, 13 Mar 2013 15:33:18 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id c15sm330641wiw.3.2013.03.13.15.33.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:33:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
X-Gm-Message-State: ALoCoQmlNrcF8eR0/qOhkAjsjTnvatJt/pnBY6Pu0fzcImn6Gtyn+Vvfzl79H9cWje09rQU/GcLK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218097>

Less ambitious patch series this time.

James and Michael's patches add if clauses that use the
bashism 'if []' rather than 'if test'. I've left them as
they are to match the other if clauses within the
git-subtree.sh file. I remember reading a comment on the
list about matching the local style being more important
than the overall project's style. I'm happy to change them
otherwise.

James Roper (1):
  contrib/subtree: Teach push to use --force option

Matt Hoffman (1):
  contrib/subtree: Replace invisible carriage return with a visible \r

Michael Hart (1):
  contrib/subtree: Teach push to abort if split fails

Paul Cartwright (1):
  contrib/subtree: Fix typo (s/incldued/included/)

 contrib/subtree/git-subtree.sh  | 16 ++++++++++++++--
 contrib/subtree/git-subtree.txt |  7 ++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.2
