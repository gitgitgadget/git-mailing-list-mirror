From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 0/4] Janitorial work on hook templates
Date: Mon, 10 Jun 2013 20:35:59 +0200
Message-ID: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6x0-00053u-T3
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab3FJSgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:14 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60559 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3FJSgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:13 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so2091786eek.5
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HKMZ9r1BmJm9k86h8qvoaq7BXSNeRsbqKjNAuTO4TcQ=;
        b=cMNPbV3G/ksXLLBU7l0yC4iONFCNpddJLXuk3WRrlZug5aqiOUVwpmjdt158Eb6Bcn
         qEQ28Gnd43JflzW+GMaz1Q1nun0HEy2pL0vVcOdrV3eainb85tb5US2ZY9Rf1eIhDfvN
         PdzK6VDN1VxHaF1/jINB4tQnMSCebCe0goxKxdBvHi3AXCQZsOG7dQPimt2KrsGU2Ziw
         WAjSkq/ALhk6adtKYzr4K7C7VZW1VWvh9zOLjLXiRY5TjsfpKMu0oh1bRNkvTEFMYX8a
         a7V0JHPj++9kcGmlY3CxPjzNXRsX5cF6gZAWKJUGXotxKuQ1PeWAU17N4vjFH6BG7oBu
         rrOA==
X-Received: by 10.15.65.8 with SMTP id p8mr4055677eex.55.1370889372227;
        Mon, 10 Jun 2013 11:36:12 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227347>

Dear all,

attached, you will find a series of small, obvious, and hopefully
uncontroversial patches for the hook templates and the manpage.
They are all tiny, but I still decided to submit distinct patches
to make modification/discussion easier.

Richard Hartmann (6):
  templates: Fewer subprocesses in pre-commit hook
  templates: Reformat pre-commit hook's message
  templates: Fix spelling in pre-commit hook
  Documentation: Update manpage for pre-commit hook
  templates: Fix ASCII art in pre-rebase hook
  template: Fix comment indentation in pre-rebase hook

 Documentation/githooks.txt         |    3 ++-
 templates/hooks--pre-commit.sample |   26 ++++++++++++--------------
 templates/hooks--pre-rebase.sample |   26 +++++++++++++-------------
 3 files changed, 27 insertions(+), 28 deletions(-)

-- 
1.7.10.4
