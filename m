From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 5/5] Add --patch option for diff-*
Date: Sat, 24 Jun 2006 01:01:56 +0300
Message-ID: <20060624010156.d357164d.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fttxd-0004P0-3d
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbWFWWRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWFWWRF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:17:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:61685 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752123AbWFWWRD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:17:03 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277759nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:17:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PNThdH4op5aPOOYs1ng6XseM29gvS8uQtu1MWlGWRHGkdpRlNcp3ujFdcJ+6dMmk+8XDqLjAEpjCg/V4jipuAVod/vCur3iYysL3J57Y4zIGEu4gtJliEo8dhSo2Ga/VvVj5TIOSi1NSXXPKKNKJpH+ArnsPyxfOSiBqkzKIHhg=
Received: by 10.49.49.6 with SMTP id b6mr2872872nfk;
        Fri, 23 Jun 2006 15:17:02 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id b1sm3374052nfe.2006.06.23.15.17.01;
        Fri, 23 Jun 2006 15:17:02 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624003315.804a1796.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22447>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index ab8aed7..596a877 100644
--- a/diff.c
+++ b/diff.c
@@ -1460,7 +1460,7 @@ static int opt_arg(const char *arg, int 
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
 		options->output_fmt |= OUTPUT_FMT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_fmt |= OUTPUT_FMT_PATCH;
-- 
1.4.1.rc1.gf603-dirty
