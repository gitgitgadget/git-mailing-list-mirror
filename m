From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] Fix a bunch of pointer declarations (codestyle)
Date: Sun, 11 Oct 2009 23:46:11 +0300
Message-ID: <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Lz-0001qp-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZJKUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbZJKUsG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:48:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:45183 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZJKUsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:48:06 -0400
Received: by fg-out-1718.google.com with SMTP id 16so285611fgg.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=soHrn2dagugExOiH6Cp3/0fJkUjzhMC+cjJTq568iG0=;
        b=rDnlPMe3AdwkDQyvlxej65XcMZVFbfpFOHB/m4TYbjlLxQMRSh/WmWp7MvTXT5e0C6
         n9rnuBaz/VmPqCzNg60XQ1QVOBpIJ7Kbax/8j2mpp+DZ74zSa/qfW12w45SZAOd5iH1J
         ZoRi4OHIk3lnVT5StsyB7qa1JMohWazIDH0ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MG8KP+a/JqusMiPiyAzgmPNOmMLNkgxqIRNaxVwNUXJJ1n15i5sJboYi6iJo6UxvYW
         xjuQhE32mz0yXKpHYMycrl2KwaAfcmCuAeNIPnzmvwpPYLYqdYbAylyrGgrqDoZikBwe
         uMztjmCC4fh728fl5jOJrsDHY42Hnp8sriKSI=
Received: by 10.86.163.5 with SMTP id l5mr4587414fge.3.1255293977553;
        Sun, 11 Oct 2009 13:46:17 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l19sm2464379fgb.22.2009.10.11.13.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
In-Reply-To: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129955>

Essentially; s/type* /type */ as per the coding guidelines.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index e1be189..b39c1b6 100644
--- a/diff.c
+++ b/diff.c
@@ -999,7 +999,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	       total_files, adds, dels);
 }
 
-static void show_shortstats(struct diffstat_t* data, struct diff_options *options)
+static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, adds = 0, dels = 0, total_files = data->nr;
 
-- 
1.6.5.4.g31fc3
