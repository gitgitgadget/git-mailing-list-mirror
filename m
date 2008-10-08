From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 0/7] gitk: UI enhancements
Date: Wed,  8 Oct 2008 11:05:33 +0400
Message-ID: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnT9u-00067l-Fm
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYJHHHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYJHHHW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYJHHHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2606173fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5ODOc5RFXawfcaQGWChHpcf1ZBSE23VDSQH3jPHeBTU=;
        b=XVwzJs8Xc/aXmZeSDE2F0ZZc/Fmv5i4uj7hODrtWSjVtxoDkaeWD70iqJgxuljlOaU
         i1ucwg3iIdCNNYTVct34MaZRT4VV0pLiWae6W+Vk5PU0CrF0we06w6/E5wMEdjnqRckN
         h3/HxrfxVJ8gti3u+dtMJOa4algku6wkYAAoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XyJYHxpGasHZ1wCRFFQRmxHQmwUyVbTNtNruYNFRSkAdSC/JqGXPq1HOLSR2XSceLz
         GwEBtiN/AWDiwKLKffbbVcyGi9RH7NEKL6VUITWjAMv228C92pOF13yJ6EjiiwxSXa/I
         uq9pcZYmlZ3F+XdiIhW2pgEUXDByDdLYOd8a4=
Received: by 10.180.236.14 with SMTP id j14mr5868124bkh.4.1223449639916;
        Wed, 08 Oct 2008 00:07:19 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97773>

This is a set of patches that enhance the UI in various ways.
They should be applied in order, and after the previous 4 patches
that deal with encodings. The previous set of patches is
apparently not applied yet, but I feel that I should not hold
these back any longer.

If Robin Rosenberg's series gets accepted first, I'll rebase
and resend the patches.


Alexander Gavrilov (7):
      gitk: Enhance UI popup and accelerator handling.
      gitk: Allow forcing branch creation if it already exists.
      gitk: Allow starting gui blame for a specific line.
      gitk: Fix file list context menu for merge commits.
      gitk: Make cherry-pick call git-citool on conflicts.
      gitk: Implement a user-friendly Edit View dialog.
      gitk: Explicitly position popup windows.

 gitk |  550 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 471 insertions(+), 79 deletions(-)
