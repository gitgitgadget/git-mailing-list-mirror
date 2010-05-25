From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/6 rebase-version] Make git log --graph looks better with -p and other diff options
Date: Tue, 25 May 2010 17:02:28 +0800
Message-ID: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:02:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq2H-0006OR-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab0EYJCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:02:48 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:47570 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab0EYJCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:02:47 -0400
Received: by pzk15 with SMTP id 15so2712803pzk.15
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZBV4b24sKOTd0ET4GQkxCIOoTuwYhIVOiJ7tapYqd8o=;
        b=Z/sX1tioDqXm5+Eix5Mu1J8sjuQcYfdMNPDM+4p+vcpeoW+i8tCsMUoBQhwmmAllci
         MHaY5jWH5KIMO0DFCuas5zB1Tl7ZNhx3tubBTzuhdACvyIh7m+BcGoeKUAHr66dYW5u/
         t68tdLZ9ALT9kbO66or9W2uQzoWV2WPWyHagU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=axxSLbp+BzESCDWLJL1v9isOtMmsG2WdHUyLzEqbxcxHqME8kCIyXejumank7+uP0R
         hYbm5s+qAYPZLrc+cDAPYHCDKqKT+Vl88wkXEUXkDm68vaQrNB6YNbnkNE2uk43fuL/R
         U4jwM3tc17+hNwDKnGybj75chFSxKj5UCHC00=
Received: by 10.114.188.31 with SMTP id l31mr5921480waf.32.1274778166203;
        Tue, 25 May 2010 02:02:46 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id d16sm46058650wam.0.2010.05.25.02.02.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:02:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147688>

From: byang <byang@byang-laptop.(none)>

Rebase for a new master...

Bo Yang (6):
  Add a prefix output callback to diff output.
  Output the graph columns at the end of the commit message.
  diff.c: Output the text graph padding before each diff line.
  Emit a whole line once a time.
  Register a callback for graph output.
  Make --color-words work well with --graph.

 diff.c     |  393 +++++++++++++++++++++++++++++++++++++++++++++---------------
 diff.h     |    5 +
 graph.c    |   19 +++
 log-tree.c |    6 +
 4 files changed, 326 insertions(+), 97 deletions(-)
