From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 0/5] doc: less guilt-foo invocations, minor Makefile fixes
Date: Fri, 23 Jan 2015 14:24:54 +0100
Message-ID: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeEw-0003k7-PU
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbbAWNZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:25:31 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:63028 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbAWNZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:25:29 -0500
Received: by mail-we0-f172.google.com with SMTP id q59so3987128wes.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5BNswN81yVx6jgx14LXX5YanyBy0ndZmWbOm0RmH+0=;
        b=PDSp1ulQ1sq0mVJpHjFKuOmvIm3lD4SmzathLj951zpWnbgHXKfKqrWtm28EUPWEMF
         E0G8qqcFHSYVkpH3+Z163erbBNijpErJlYANUMF90K/KobX4/i1LoYflf2tAEyRwrPt4
         K7jdNRpDnaRf7Guv89aK4KHxBdw9dh2IAsjs7ZMqP/gPldcUyk2m1FbD69dfSq1PVNCe
         NyugWwuLcu0Q5A0fJ2EoJ0ozOgCA4DBQSWHyJlGCFwnUGIOBixGDbdu4S1cABmXki3UQ
         JjZ7ZtSbFVSIWpjaKd0bu/xHjURbB5by7IyGU5oGScKfL/P953+PAJ3jdYfYzByS6sOR
         Wp/Q==
X-Gm-Message-State: ALoCoQkx9uoEzkULvcTmIiVsHjQM/7xCftGFsj3ZrGvEDbu+iKNuJEP4eyuGC6JhjjwmchI0MJEl
X-Received: by 10.181.12.100 with SMTP id ep4mr3731993wid.62.1422019524684;
        Fri, 23 Jan 2015 05:25:24 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.25.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:25:23 -0800 (PST)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262921>

guilt no longer supports running commands on the "guilt-add" form.
You need to use "guilt add" instead.

This patch series updates most of the documentation to use the
supported "guilt add" form.

There is one known instance where I did not change the style: in the
NAME section in Documentation/guilt-*.txt.  The reason is that if I
change it there, xmlto will create the man pages as e.g. guilt_add.1
instead of guilt-add.1, and I don't know how to fix that.  Also, the
git man pages (as of Git 2.1.0) still have "git-add" under the NAME
heading of git-add(1), so it might be wise to follow suite.

While working on this, I also found two minor issues with
Documentation/Makefile.

    /ceder

Per Cederqvist (5):
  Fix generation of Documentation/usage-%.txt.
  doc: guilt.xml depends on cmds.txt.
  doc: don't use guilt-foo invocations in examples.
  doc: don't use guilt-foo invocations in usage messages.
  doc: git doesn't use git-foo invocations.

 Documentation/.gitignore        | 3 +++
 Documentation/Makefile          | 6 ++++--
 Documentation/guilt-add.txt     | 4 ++--
 Documentation/guilt-delete.txt  | 2 +-
 Documentation/guilt-diff.txt    | 2 +-
 Documentation/guilt-help.txt    | 4 ++--
 Documentation/guilt-new.txt     | 6 +++---
 Documentation/guilt-refresh.txt | 2 +-
 Documentation/guilt-repair.txt  | 2 +-
 Documentation/guilt-rm.txt      | 2 +-
 Documentation/guilt-select.txt  | 4 ++--
 Documentation/usage.sh          | 8 +++-----
 12 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.1.0
