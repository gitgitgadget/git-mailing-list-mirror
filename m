From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/8] config.txt: remove pointer to SubmittingPatches
Date: Thu, 23 Apr 2009 02:37:55 -0700
Message-ID: <1240479482-31366-2-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvPJ-0000xq-Hb
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbZDWJiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbZDWJiL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbZDWJiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:10 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Mt9rmHckZc6D7lfRrXBpIpe3Tobe0NB1xExNMg6Wh1A=;
        b=oNlKmde9EJqB+vABvwa+m/fd/MW9JckKHM59cdJg/hGwAfp2mFhZP3oiPCbdaY2eKT
         5uOzdgnu+jRmX9LNkYd6cU5hVQNAqXAJYw1D2+Z6+w/ZHl0DwSpte+xY5TAxBLubx8R8
         AwcdsJDuiqUG/ypHzQ+aGev7ORnPk9ektl8YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DToG0CEh/LfvCkKr436h5wOqPcCkzQpzW4b1r7qIvWF54vHDNLDte6dqGHGxT4h/A5
         b/Ohx32ASNJglnfQzTRU4qzrgvrHsP+8tTFLnywrvuQFtFsIYHzgQoVpPmjEWHiIc3Ol
         sbBbKlGYl9VVJASgzbSnbmQraq9g5JRpq8YPw=
Received: by 10.141.114.15 with SMTP id r15mr265828rvm.42.1240479489827;
        Thu, 23 Apr 2009 02:38:09 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id b8sm3556985rvf.28.2009.04.23.02.38.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:09 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:06 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117316>

SubmittingPatches exists in the git source documentation for developers
of git and is not included in the man/html page distributions.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 35056e1..fb7adfa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -743,7 +743,6 @@ format.signoff::
     format-patch by default. *Note:* Adding the Signed-off-by: line to a
     patch should be a conscious act and means that you certify you have
     the rights to submit this work under the same open source license.
-    Please see the 'SubmittingPatches' document for further discussion.
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
-- 
1.6.2.3
