From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 03/10] Docs: git tag: Revise a paragraph.
Date: Mon, 28 Mar 2011 14:49:45 +0000
Message-ID: <1301327622-8595-4-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Em8-0004JB-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab1C1Pyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1C1Pyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:32 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1221676ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=N6HOmdSCqZ0x/IvqgIcPqZZ3bjWbOje9djv+QJv6d+s=;
        b=lha77GpoWwWGrunJbYsV7DHKh/nLV1Ud230tLu/3HsdvOUD7kZsSePgnnb1yUogV5U
         N/D/120YL4yUXtgdkFlvKiAq6FZXSu8gQmYi2fVghUpS8mHIFFWcNDAfGbs2stBPE8iM
         TfROoNZlsIZB6gVgmNxRVNhadFerO4I2SIJ80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=I2kulrR1jFLPF1PXKXJ3MNFRgCu7DLekSe1oGjM5k7350ehJSl78lN5PA2OLyE2qOY
         NDspsmRxchBGuB5Sy9cYtcTdd/Vadjx5Cc5PCVTf79IlpE6mfOVuQ1b5BxBl4ixxQJsL
         4ioIJiXW15VWT33P7yABgQZ6UCOqftWQ19FFI=
Received: by 10.213.13.14 with SMTP id z14mr1349921ebz.25.1301327671946;
        Mon, 28 Mar 2011 08:54:31 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170141>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e276393..68eebee 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -189,9 +189,10 @@ the toplevel but not limited to them.  Mere mortals when pulling
 from each other do not necessarily want to automatically get
 private anchor point tags from the other person.
 
-You would notice "please pull" messages on the mailing list says
-repo URL and branch name alone.  This is designed to be easily
-cut&pasted to a 'git fetch' command line:
+Often, "please pull" messages on the mailing list just provide
+two pieces of information: a repo URL and a branch name; this
+is designed to be easily cut&pasted at the end of a 'git fetch'
+command line:
 
 ------------
 Linus, please pull from
-- 
1.7.4.18.g68fe8
