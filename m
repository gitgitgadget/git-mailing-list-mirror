From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Fix minor warnings reported by icc
Date: Tue, 15 Nov 2011 22:29:35 +0530
Message-ID: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMNq-00020Q-I0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838Ab1KORBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:01:13 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55924 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:13 -0500
Received: by pzk36 with SMTP id 36so16057325pzk.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QvMPARXCbsUIxZM0SkQFSbxt09bKcksE6GjIv5RJlBU=;
        b=MedvuU5jOPM4GYMzyZWo+2/5keeN+PoZZfvlPTAqDuE+dvUlPS6UkhRQQDDM1UW0Cc
         kmSLQHz/CylNEEnl32KwkiMmwFRMsWKbnTk5WcLgbzktKI6+RiSTraOyIfdVUqq+rR3e
         bi/UOxeAnhi2DlZikh04dAX8lMd78PtWjOGBY=
Received: by 10.68.13.198 with SMTP id j6mr60194884pbc.48.1321376472606;
        Tue, 15 Nov 2011 09:01:12 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id f2sm37889376pbg.14.2011.11.15.09.01.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:01:11 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185467>

Hi,

Thomas Rast tried compiling Git with Intel's C compiler (icc) recently
and the results can be found here [1].  Most of them don't amount to
anything, are probably not worth fixing.  Here are fixes to a few that
caught my eye.

Thanks.

[1]: https://gist.github.com/1367335

-- Ram

Ramkumar Ramachandra (4):
  http: remove unused function hex()
  convert: don't mix enum with int
  ll-merge: initialize default_opts const
  sha1_file: don't mix enum with int

 convert.c   |    6 +++---
 http.c      |    8 --------
 ll-merge.c  |    2 +-
 sha1_file.c |    2 +-
 4 files changed, 5 insertions(+), 13 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
