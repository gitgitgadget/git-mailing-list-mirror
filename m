From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: [PATCH] Docs gitk: Explicitly mention the files that gitk uses (~/.gitk)
Date: Sat, 12 Apr 2008 18:50:20 +0900
Message-ID: <1f748ec60804120250x72bce8a1y9d240e03590fe1c1@mail.gmail.com>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 12 11:51:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcOJ-00035x-1w
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 11:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134AbYDLJuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 05:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757857AbYDLJuX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 05:50:23 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:52853 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656AbYDLJuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 05:50:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so200684and.103
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=EJpUE6vRMnUxgZ3Pa3O7ZvcdDTYsWbgbgLb/GVBmZ+g=;
        b=X8ImxVoODMYFUYKkwx5sOlbL85XnSfQDFr+HPNx95AWCFTABZ6oHxdK8JoSZTB3Vu+B+Zy33Wu4T/QACeGdUHjguOxPrioLTHIam8KWSQZDcIk4GrQ2UxGwFkm5O6S1gTlF1F9BJex9ZJA4SXdX1lltZ5oj4JUbAsNX2CVA/toc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=K7LxpidJlTjUgvu5EmBne6qUiXMVfV8CuDbuFelBxjyc7VfM1PsN2HMZ7jH9fgMB8SmXv2zaVQqgpcqaBQHBH7DpLRF+g3rXg2soZHrmMvuOHHOJvZQnDk6R53StsqxhPzXVaQwraGJt/PtKZfmQmBilWTuHYFf611zxRL4VsUs=
Received: by 10.100.255.17 with SMTP id c17mr7390050ani.37.1207993820657;
        Sat, 12 Apr 2008 02:50:20 -0700 (PDT)
Received: by 10.101.1.16 with HTTP; Sat, 12 Apr 2008 02:50:20 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 908236fa44acac3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79341>

gitk creates and uses ~/.gitk

Signed-off-by: Clifford Caoile <piyo@users.sourceforge.net>
---
 Documentation/gitk.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d247d63..1353b1a 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -80,6 +80,11 @@ gitk --max-count=100 --all \-- Makefile::
 	Show at most 100 changes made to the file 'Makefile'. Instead of only
 	looking for changes in the current branch look in all branches.

+Files
+-----
+Gitk creates the .gitk file in your $HOME directory to store preferences
+such as display options, font, and colors.
+
 See Also
 --------
 'qgit(1)'::
-- 
1.5.4.2.1161.g1a6f0
