From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] diff-tree: Use ---\n as a message separator
Date: Tue, 27 Jun 2006 15:39:29 +0300
Message-ID: <20060627153929.adfd6452.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 14:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvCqu-00041N-3q
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 14:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWF0Mje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 08:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWF0Mjd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 08:39:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7530 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932209AbWF0Mjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 08:39:32 -0400
Received: by nf-out-0910.google.com with SMTP id m19so721581nfc
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 05:39:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=P8KENGU2i6MY3kB6XIjtE0Bo63A8JMirbRmTN+W2JDmle9Z9Viyj2VeIPXVsM6epeLytzPGnr4tTAQbNDYzDFfn4++dUrUkH3j0mjC/adfp4VZe9Y78T0yjzgTifeyaTsvLRwiP+shyAgnmIzcegFoBtUuT1XzPwIlfg1H8CyUc=
Received: by 10.49.64.2 with SMTP id r2mr5586419nfk;
        Tue, 27 Jun 2006 05:39:31 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l21sm6752644nfc.2006.06.27.05.39.30;
        Tue, 27 Jun 2006 05:39:31 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22736>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff-tree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index ae1cde9..1e66fca 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -72,6 +72,7 @@ int cmd_diff_tree(int argc, const char *
 	init_revisions(opt);
 	opt->abbrev = 0;
 	opt->diff = 1;
+	opt->diffopt.msg_sep = "---\n";
 	argc = setup_revisions(argc, argv, opt, NULL);
 
 	while (--argc > 0) {
-- 
1.4.1.rc1.g5576-dirty
