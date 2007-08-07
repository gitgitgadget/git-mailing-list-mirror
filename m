From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: [PATCH] git-stash documentation: stash numbering starts at zero, not one
Date: Tue, 7 Aug 2007 12:39:03 -0500
Message-ID: <588192970708071039k71c3d67fhd49b90143045c2c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 19:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIT1V-0008N9-Dx
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 19:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761573AbXHGRjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 13:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbXHGRjG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 13:39:06 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:11766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761506AbXHGRjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 13:39:05 -0400
Received: by an-out-0708.google.com with SMTP id d31so332588and
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 10:39:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pNQZQTM4K+wh+ppvJxRHUEbB1pSvuBYxJ3rVARsw3/ZwHwK9TEYff057f1oSdh0ZhfazG1pfEBxfytXzmjmlXtg70w0JVMmyng7mreKKZyaM0XRMsGbnDgAGwvF3/Y7kdALOctsgp4UAAa3SEXweq0EbIqhzxH7Atq8UggveFTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sAX04OSmcn9tnZ9vU2MCwTMMX6VU/P2bUKCY6VrG/xjUhLwRqcNRQFZ6Ua6sO9GPolT10LgZ7A+eKcgunhOGfisqohuL+Ggq77b4W08njDB7e4xoOoXH3RfKH0b4lK8wc086SPfX31V+0f+c5XFUwShXMPsmfRDzWBO3sncaTNk=
Received: by 10.100.165.9 with SMTP id n9mr4045977ane.1186508343337;
        Tue, 07 Aug 2007 10:39:03 -0700 (PDT)
Received: by 10.100.105.9 with HTTP; Tue, 7 Aug 2007 10:39:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55269>

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---
 Documentation/git-stash.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4ec61a9..05f40cf 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -29,8 +29,8 @@ you create one.

 The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
-the usual reflog syntax (e.g. `stash@\{1}` is the most recently
-created stash, `stash@\{2}` is the one before it, `stash@\{2.hours.ago}`
+the usual reflog syntax (e.g. `stash@\{0}` is the most recently
+created stash, `stash@\{1}` is the one before it, `stash@\{2.hours.ago}`
 is also possible).

 OPTIONS
@@ -61,7 +61,7 @@ show [<stash>]::
 	stashed state and its original parent. When no `<stash>` is given,
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to `git-diff` (e.g., `git-stash show
-	-p stash@\{2}` to view the second most recent stash in patch form).
+	-p stash@\{1}` to view the second most recent stash in patch form).

 apply [<stash>]::

-- 
1.5.3.rc3.141.g53d646
