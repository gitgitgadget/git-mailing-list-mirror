From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: avoid tracking intermediate build products
Date: Sun, 8 Nov 2009 05:20:09 -0600
Message-ID: <20091108112009.GA23790@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 12:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N75fJ-0005of-Pt
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 12:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbZKHLKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbZKHLKU
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 06:10:20 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39632 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZKHLKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 06:10:19 -0500
Received: by yxe17 with SMTP id 17so1929753yxe.33
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=iCaIqpK3iYxNqDyT9zYpj+N8cYHXUWXmgSD2wi2VNRo=;
        b=DcpLUEPtx6p8BYgo94U2hYXJ9/TCJ/Uar1K/x2OpzdirVyDK7SHaaGtzSYj1VHQqy6
         5zrQRmr2R+sgGhx7OE8G+MHtakPycvQ/JPzKn06e5zdRYEIR5B88RemEPY3vkR2brc/D
         sv9+fI+TdCBjkKP5M8oZHdvoG5iZd7vHBZADo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=N2XKpPoO7j3TaC3bFpNzsX+6s2yB5MUV1laO6leDVIwDP5I8DJFbRb+hER9c5Ra+W9
         uaMsqhYeq+O/gLgdVe1mX6BWLBv4V0TnHFfdBPvIgFYqWzYhvMyUdkUcouXFHrTdEG6v
         gZ8wYdSnmNIktbNjUjnFYgmOmtR6jttAK3F9Q=
Received: by 10.150.233.3 with SMTP id f3mr11139473ybh.148.1257678623863;
        Sun, 08 Nov 2009 03:10:23 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm915983gxk.10.2009.11.08.03.10.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 03:10:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132392>

Add *.xml+, *.html+, *.texi+, and *.texi++ to .gitignore.

Cc: Chris Johnsen <chris_johnsen@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Some of these files appeared in the "git status" output after an
interrupted build.  I hope I caught them all.

Good night,
Jonathan

 Documentation/.gitignore |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d8edd90..22dbc0b 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,8 +1,12 @@
 *.xml
+*.xml+
 *.html
+*.html+
 *.[1-8]
 *.made
 *.texi
+*.texi+
+*.texi++
 git.info
 gitman.info
 howto-index.txt
-- 
1.6.5.2
