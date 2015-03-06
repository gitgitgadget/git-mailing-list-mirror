From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 0/2] [git-gui] "Open existing repository" with submodules
Date: Fri,  6 Mar 2015 11:21:51 -0500
Message-ID: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Cc: Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Mar 06 17:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTv14-00075s-K1
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbCFQWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:22:15 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36441 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbCFQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:22:14 -0500
Received: by qgdz107 with SMTP id z107so13704676qgd.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CwQaaAtSm8a2N1S6LCjUh+Jk9/91+gXQlTeBvkomZFw=;
        b=wP+j53AK6lcdQbYLtmyqcmZpIS5oWjoaQgIEZ4sOPhizJQ8cyvVUlTM7MKMUFMZCvS
         zQ8qan7wDTGIcopOOC7DlQES8n+87opKXn7KJNtHnKiQJXgNl6O+TXCemYbH7D4edIDQ
         S200zdrWjkgWkXyfCqr/w/MFfKixCt9Qjqp2C+FhFnL/sBDTUbRZmxgnqhfqKzPawS0M
         SyY3rVIySgvYxbb0yT7f8CJEGy3OaBHbRzbu0e65UmCyHVuu+HekHI6gzqc8mmCPvJfU
         Re6rgzfbRCPiGU0yDJoJWXjlY7Kt5qj+d2hNfwTnQKS81G+SIW2uGuLoBTxOTF+mH+aq
         OKrg==
X-Received: by 10.55.15.133 with SMTP id 5mr30446379qkp.85.1425658933685;
        Fri, 06 Mar 2015 08:22:13 -0800 (PST)
Received: from debian-78-amd64.poly.edu (remram.poly.edu. [128.238.102.127])
        by mx.google.com with ESMTPSA id h85sm6037518qhc.6.2015.03.06.08.22.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 08:22:13 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264940>

I'm resubmitting this patch series, hopefully someone takes notice
this time.

The GUI cannot currently open a submodule because it fails to recognize
the git link file (regular .git file with content "gitdir: ...").

Previous thread:
http://thread.gmane.org/gmane.comp.version-control.git/263199

I'm really not sure if/how git-gui is maintained but I do hope somebody
cares about this component, that is still AFAIK distributed with Git.

Remi Rampin (2):
  Fixes chooser not accepting gitfiles
  Makes chooser set 'gitdir' to the resolved path

 lib/choose_repository.tcl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
1.9.5.msysgit.0
