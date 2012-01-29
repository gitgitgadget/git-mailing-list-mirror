From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] completion: trivial cleanups
Date: Mon, 30 Jan 2012 01:41:16 +0200
Message-ID: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreNj-00086h-1o
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab2A2Xly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:41:54 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:47347 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab2A2Xly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:41:54 -0500
Received: by werb13 with SMTP id b13so2992635wer.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 15:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1d5MgqaZcv17DRoUKQ+bhQ0lFwswlz/EBEInDGiEbGo=;
        b=slt7w7YCVL5GE+Ph/FyoU9qZpMJrrdo/H7TGBTpBdodzUuzSAVojMAFrm20V9fP6yq
         N2jiG2ujkj7ngimdSi6UTHc+NqV4CMVvLmyLkTXGw0tUxtb5maMidlLRngV9HbJ9QDYL
         jwlGKePxA9UU3AXXrowvVAvUKfwdimjA+U3HU=
Received: by 10.216.135.142 with SMTP id u14mr1563394wei.5.1327880512909;
        Sun, 29 Jan 2012 15:41:52 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id bj10sm26536861wib.9.2012.01.29.15.41.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 15:41:52 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189303>

And an improvement for zsh.

Felipe Contreras (3):
  completion: be nicer with zsh
  completion: remove old code
  completion: remove unused code

 contrib/completion/git-completion.bash |   47 +++++---------------------------
 1 files changed, 7 insertions(+), 40 deletions(-)

-- 
1.7.8.3
