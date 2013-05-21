From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Fix invalid revision error messages for 1.8.3
Date: Tue, 21 May 2013 16:11:53 +0530
Message-ID: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 12:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uejzh-0008DL-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 12:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab3EUKkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 06:40:15 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:49846 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3EUKkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 06:40:14 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so337185dae.2
        for <git@vger.kernel.org>; Tue, 21 May 2013 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JF7zywV7LmW6m7tKs+UrMjs84xXIEGj7jrA8I1MWWpY=;
        b=Bz3p0EJSMrBs1CKI9NbQiU33MIHqaH3M06Q7ewnUhh7kIySk/qNlGTM0UNR3Sq7uLx
         QAGNZY4C1LcmwJnmrwNqJOVmSveC+uFgw+/qBbC4xZZdf7tO9VcBGBDMA6rGFImPaYEj
         Yn0jJMV4SuZ0PM0XB3sC1t++HsEOY81E9Y1whOcfy700nM0bPaF2VR/dtE64rf34VN/x
         Ky7GcPxUyyBzq2jmcCeqxarepLuFzZLsZw/VhKF+WkC/N0kr5Paousx3D41x6daRryGi
         8RLU+bhGVnaloVQtLEq/bZf+vhCExHPogLHDhfgXhuXO4Kfg464Ho0r+QiWdwvkOF0L/
         8M1Q==
X-Received: by 10.66.250.131 with SMTP id zc3mr2472335pac.157.1369132813539;
        Tue, 21 May 2013 03:40:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm2198426pbc.42.2013.05.21.03.40.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 03:40:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.6.ga9126d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225026>

Hi,

Seeing other patches on the list, I decided that I should do something
for 1.8.3 as well (as opposed to constantly writing new features).  So
here's my contribution.

The first error message has annoyed me endlessly, and I took this
opportunity to fix it.  Interested people can sprinkle in some advice
later.  The second one is a low-hanging "while we're there".

Thanks.

Ramkumar Ramachandra (2):
  sha1_name: fix error message for @{u}
  sha1_name: fix error message for @{<N>}, @{<date>}

 sha1_name.c                   | 17 +++++++++++------
 t/t1507-rev-parse-upstream.sh | 15 +++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.8.3.rc3.6.ga9126d5.dirty
