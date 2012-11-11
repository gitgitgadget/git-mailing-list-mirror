From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] send-email: new series-cc-cmd option
Date: Sun, 11 Nov 2012 18:04:21 +0100
Message-ID: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 18:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaxj-0007Rh-UX
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab2KKREf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:04:35 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52685 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2KKREe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:04:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2084867bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xL0Pcb7YyTAixrXFI6wfzpubpMhvhCUJlPa1LpCMdHQ=;
        b=AlvA3NT8fUWP5tVPOSQ8+67sV2knMhL6WE5mehVIRtQ8dxYR1r7Y/sgS5y2uIDhJZa
         H/ulstEW76RDNvuS0eDu/3eoIUKKAeCjO8hRzQ3uQ8bO4DlxnNMhY4ybR1Ak8fD3P4sy
         BMXrTYdBZn+UKpxwlC7RGh64KpAbLQd56HVQHWrKd5kE0oHrSWlQNbGajMsZmI8EX/rd
         MAD9ZLVwp6ZRNfWlp/2ywCmXTF5kpjxKOnWl71p4uiBzaBe/azNLjPnWSJH5qwzOe6hs
         Sr4OsPoNlc1AeisNSjWiNdxRRBDNhAyQDw79YHaZIqGCz1kWHYXuPa1UxatNFVVleWjb
         AIwg==
Received: by 10.204.147.153 with SMTP id l25mr6040721bkv.109.1352653472754;
        Sun, 11 Nov 2012 09:04:32 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id 1sm1645082bks.3.2012.11.11.09.04.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:04:31 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209415>

cc-cmd is probably not that useful, what we really want is to make a list of
people to Cc on a per-patch-series basis.

This patch series allows just that.

Felipe Contreras (2):
  send-email: refactor recipients_cmd()
  send-email: add series-cc-cmd option

 Documentation/git-send-email.txt       |  7 +++++++
 contrib/completion/git-completion.bash |  2 +-
 git-send-email.perl                    | 13 ++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
1.8.0
