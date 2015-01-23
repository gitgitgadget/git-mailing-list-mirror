From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 0/2] Teach "guilt graph" to ignore some files.
Date: Fri, 23 Jan 2015 15:21:05 +0100
Message-ID: <1422022867-7908-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEf7B-0000eo-A4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbbAWOVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:21:33 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:62416 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbbAWOVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:21:31 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so7763851wgh.6
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 06:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0vamp9rPk06xzoePTzTT8MAXSUPi/0ugVnRzVb9RLPs=;
        b=CjxI7jK8ImBXsxuyOQehoNAoZt1R3THy/BQlE5dI2TRTJ+he0r+r1c+pvMehbo2ojs
         D4sGJoiyVXCxV6XW7+dd4nG5eXY4Ol0UrNxWEUObvFwgAjyUTIfFJwxzatIP9wNkVH1/
         LHF1k7ZgPkUO6n1KxCelf7UJlsoP/gfxBRFvNhgGwUbmDMDdD1+DxJuSLt5LgRA+SqIS
         MglIRiy32KNl0Y5OmH/lRQWRtBs6I5ZxRouTm/cYzcsnB6ETYssHtQrMtQN6j30+AXiH
         WlhbSK9kEwDeurC6Um2je5gg0Zu9165Md3JAY8L1NMuipKG6N9lgXtma24zOFjMjpgqe
         XETQ==
X-Gm-Message-State: ALoCoQmb8d3wxE5eZriVCtEjoP8KZ7VG4kuSmLMZ68FUn47GCtCXQj5sZIVH/qjte1t4tPTuBeFc
X-Received: by 10.180.20.50 with SMTP id k18mr4282044wie.31.1422022890127;
        Fri, 23 Jan 2015 06:21:30 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id uq1sm2413134wjc.14.2015.01.23.06.21.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 06:21:28 -0800 (PST)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262929>

If you use a ChangeLog, all output from "guilt graph" will be a boring
line of commits.  By using "guilt graph -x ChangeLog" things will look
more interesting.

Also: simplify getfiles.

(This work is also available on the guilt-graph-ignore-2015-v1 branch
of the git://repo.or.cz/guilt/ceder.git repository.  (That branch is
based on the doc-dash-2015-v1 branch that contains my documentation
fixes, so if you just want these two commits you will have to
cherry-pick.))

    /ceder

Per Cederqvist (2):
  guilt graph: Simplify getfiles.
  Teach "guilt graph" the "-x exclude-pattern" option.

 Documentation/guilt-graph.txt |  5 +++++
 guilt-graph                   | 26 +++++++++++++++++++-------
 regression/t-033.out          | 12 ++++++++++++
 regression/t-033.sh           |  3 +++
 4 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.1.0
