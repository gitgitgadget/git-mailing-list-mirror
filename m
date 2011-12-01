From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH/RFC 2/2] merge, pull: Document the --no-ff-only merge option
Date: Wed, 30 Nov 2011 20:38:57 -0500
Message-ID: <1322703537-3914-2-git-send-email-naesten@gmail.com>
References: <1322703537-3914-1-git-send-email-naesten@gmail.com>
Cc: Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 02:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVvdV-0002Bq-KR
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 02:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1LABkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 20:40:21 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:52706 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1LABkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 20:40:20 -0500
Received: by mail-qw0-f53.google.com with SMTP id 25so986666qao.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 17:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nTqS/4OP6I0J3zmSn+5cmtY3hCfi9bGchsjrjZ54kSA=;
        b=qIjc0ye1PH1/OZqwfkgioMpVSAM8zRIfTT/q48jpr7rnnVcaZV0kjplAzu+0gOYyww
         /OfFdrNajejB57mQduR16Uq0N6KlTAwZomm/W1tYDgcsin6DGHwpGg3ozBWRn8xFOAgM
         bypMi9Fq0+HVz9YIlHo4Da+089l71Yt+CfYHQ=
Received: by 10.229.63.199 with SMTP id c7mr780409qci.140.1322703619828;
        Wed, 30 Nov 2011 17:40:19 -0800 (PST)
Received: from hydrogen (207-172-114-83.c3-0.upd-ubr1.trpr-upd.pa.cable.rcn.com. [207.172.114.83])
        by mx.google.com with ESMTPS id dk1sm3921058qab.22.2011.11.30.17.40.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 17:40:19 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.76)
	(envelope-from <naesten@gmail.com>)
	id 1RVvdI-00016J-Lr; Wed, 30 Nov 2011 20:40:16 -0500
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1322703537-3914-1-git-send-email-naesten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186157>

Now that --no-ff-only will work with pull and not just with merge, we
should probably tell the users about it.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/merge-options.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 6bd0b04..2adc4f5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -56,9 +56,13 @@ With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 
 --ff-only::
+--no-ff-only::
 	Refuse to merge and exit with a non-zero status unless the
 	current `HEAD` is already up-to-date or the merge can be
 	resolved as a fast-forward.
++
+With --no-ff-only, don't refuse. This is can be used to override
+--ff-only, or the "`only`" value for the `merge.ff` configuration option.
 
 -s <strategy>::
 --strategy=<strategy>::
-- 
1.7.7.3
