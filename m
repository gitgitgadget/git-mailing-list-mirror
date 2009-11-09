From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/24] Show usage string for 'git mailsplit -h'
Date: Mon,  9 Nov 2009 09:04:52 -0600
Message-ID: <1257779104-23884-12-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfA-0002nn-P3
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678AbZKIOzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbZKIOz3
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:29 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61909 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZKIOz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:27 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3533124bwz.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WcCbnCbu5eWK7i/84B+6rWKXrwof6WlrShMdKEFbUss=;
        b=eJcHW5AiIb26Zw3fILQMq/vQ1uBR1xjbi7W5jxqRVVjnwTgaPM6Zak0NKfS0g2kkmh
         Ht2toL576jhGT3GBNECM9xJaF0rfnyIjkydGboWHFrMIEz+OrAiFBMl53gHPslU3u++V
         yPq2+LOxkfvDUijukGHKT+icJWG2RHu7cxtCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D1NxZD6H5ujrDNIqAxz5kjvNxhzh/mL8nxmzZe78NQHffoOBp3gbrXQ1dP1XFogsQA
         hV7wBnbKS4Ks03KWv5Et+adlLatBzZKVhgTnUHFHmBBvEI1zifnrulHFIn+3yTCPJgJB
         z6t83AwJQKYAlkKuwwrtB9mqlhJlvtb0ShAss=
Received: by 10.216.85.69 with SMTP id t47mr2572555wee.107.1257778532138;
        Mon, 09 Nov 2009 06:55:32 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:31 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132473>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-mailsplit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index dfe5b15..207e358 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -231,6 +231,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			continue;
 		} else if ( arg[1] == 'f' ) {
 			nr = strtol(arg+2, NULL, 10);
+		} else if ( arg[1] == 'h' ) {
+			usage(git_mailsplit_usage);
 		} else if ( arg[1] == 'b' && !arg[2] ) {
 			allow_bare = 1;
 		} else if (!strcmp(arg, "--keep-cr")) {
-- 
1.6.5.2
