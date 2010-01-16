From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation: Update git core tutorial clarifying reference 
	to scripts
Date: Sat, 16 Jan 2010 23:35:38 +0530
Message-ID: <f3271551001161005s2d758dfbk7b42bb3d0d92e072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 19:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWD2J-0001FE-7G
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab0APSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 13:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305Ab0APSGB
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:06:01 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:47500 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab0APSGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:06:00 -0500
Received: by ywh6 with SMTP id 6so1400094ywh.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=GuEcQ1C2XdUM4JxJ4o7DuFpy2Fm6cGx5byittP+088g=;
        b=Zq8+vkmYjt2JqJWLC8qvywG0a8RHKHLwV6DX7avMsRUjEimsTC9jKVU+bpPZNml5Jk
         HfiJunOjEZJ2zzO+Zc/dbXWh/EpDiI8YjhoR7/HKDvq6mgSsmCn/uqeDYtUBdDp7bLJT
         IVcn+HA96tQPvV7+ZQFx08JBXSvWhqhd3yLjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=X44zPr7B7WxvOA4Pir/Ts3jujaAKe4504xSqVRtdwq0T2zSYVTbWQxnBNRsqnLxE72
         CqBeYo57q4/doqapzT00LINZEam+sr3NRkivMfYnKjSDBkCgjYWl2pkGiSz6ufh1a34c
         tzXOfNb790++Apr4bmOvY6d1U31Z3LGMwaIXg=
Received: by 10.91.153.1 with SMTP id f1mr3889288ago.21.1263665159021; Sat, 16 
	Jan 2010 10:05:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137242>

Back when the git core tutorial was written, porcelain commands were
shell scripts. This patch adds a paragraph explaining this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/gitcore-tutorial.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt
b/Documentation/gitcore-tutorial.txt
index f762dca..cfc26c6 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -27,6 +27,14 @@ interfaces on top of it called "porcelain". You may
not want to use the
 plumbing directly very often, but it can be good to know what the
 plumbing does for when the porcelain isn't flushing.

+Back when this document was originally written, many porcelain
+commands were shell scripts. For simplicity, it still uses them as
+examples to illustrate how plumbing is fit together to form the
+porcelain commands. The source tree includes some of these scripts in
+contrib/examples/ for reference. Although these are not implemented as
+shell scripts anymore, the description of what the plumbing layer
+commands do is still valid.
+
 [NOTE]
 Deeper technical details are often marked as Notes, which you can
 skip on your first reading.
-- 
1.6.5
