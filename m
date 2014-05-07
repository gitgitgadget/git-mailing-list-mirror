From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] shell doc: remove stray "+" in example
Date: Wed, 7 May 2014 16:44:01 -0700
Message-ID: <20140507234401.GY9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 01:44:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiBVS-000433-VL
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 01:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaEGXoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 19:44:06 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61578 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbaEGXoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 19:44:04 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so1669917pdj.32
        for <git@vger.kernel.org>; Wed, 07 May 2014 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=JQ6OuWMN3T6UcMU+vFIqBz/YmV43LEzHPf5PiRl69eQ=;
        b=PC0ueTeaVMy53ypCgrDx7KxkXGyVVnLYfdkKTktfZKGsI8Zingw1vVv2h7sBnCay77
         tWlSwa4XtBNwrnvJpYR5aMXTG1M/6OMxpJ6EnhfSNSggjU7RMwiolJ6gLkWcHEOBx2Wp
         vxENRLs1SRJQWJweu1+NQPPznzhM0xkyc1NN4hbqsZDptqMYJrbW+X2rwZs3+zRb1gwJ
         ZDXaPX3goobSVE4+KuA5VfHhI3gKjBZUoe5nXgyavg1LiJ0wuRVDDHeuim9K7lqDrspI
         8NRwq5gDCDXZdoF4Stkl+aTJK+8iQX2s/j57obUFDa5baoMTyPIOl9lGMKSIlL06j2Vv
         MUgA==
X-Received: by 10.66.66.135 with SMTP id f7mr530541pat.22.1399506243783;
        Wed, 07 May 2014 16:44:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qv3sm5194349pbb.87.2014.05.07.16.44.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 May 2014 16:44:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248390>

The git-shell(1) manpage says

	EXAMPLE
	       To disable interactive logins, displaying a greeting
		instead:

		+

		   $ chsh -s /usr/bin/git-shell
		   $ mkdir $HOME/git-shell-commands
[...]

The stray "+" has been there ever since the example was added in
v1.8.3-rc0~210^2 (shell: new no-interactive-login command to print a
custom message, 2013-03-09).  The "+" sign between paragraphs is
needed in asciidoc to attach extra paragraphs to a list item but here
it is not needed and ends up rendered as a literal "+".  Remove it.

A quick search with "grep -e '<p>+' /usr/share/doc/git/html/*.html"
doesn't find any other instances of this problem.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-shell.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index c35051b..e4bdd22 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -66,7 +66,7 @@ EXAMPLE
 -------
 
 To disable interactive logins, displaying a greeting instead:
-+
+
 ----------------
 $ chsh -s /usr/bin/git-shell
 $ mkdir $HOME/git-shell-commands
-- 
1.9.1.423.g4596e3a
