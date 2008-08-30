From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] mention required Perl version in INSTALL
Date: Sat, 30 Aug 2008 19:13:12 +0200
Message-ID: <20080830171312.GE7185@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 19:14:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZU1o-0002Jr-VK
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYH3RNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYH3RNS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:13:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:54655 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYH3RNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:13:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so824024fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :from:reply-to;
        bh=h/khIGSwHd7QVx81GI1mfSKyNOaP+I7GQoAQKJW0GXM=;
        b=RKJifhlslhCGzQLD4n3xUnkLzqpaheOcAY2IVJEaPRjYFSS6oUUIcGfDcr66WMAX1/
         KiX/EZfGgU5uQOgi04owXzTzf3U9VYt0C3IKRNUJsEhMXAgcrY3Sx68bZ+iqi0SKboQH
         1LbY9OEOppOqr1qle5bvkmYguFU0my9fZCQtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from:reply-to;
        b=t6k27fLVeETQ6421bpXKERaUsOHSFMEjrDzbVpNC3YJA4tHxwpJ+F6CwQnh2H+Q/oB
         1hE4vomPYbqY4KA/lvY4jV4vRdgZ/0TM0TicwRcWMViBCzfehauCLPIFZah6Lsd6CG5+
         UpToCpMqg2Zku0g/+JtCN68YD+zwcXRsmHTGg=
Received: by 10.86.77.5 with SMTP id z5mr3123279fga.10.1220116395780;
        Sat, 30 Aug 2008 10:13:15 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.78.90])
        by mx.google.com with ESMTPS id 4sm4289938fge.8.2008.08.30.10.13.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 10:13:14 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id A82F817BD2; Sat, 30 Aug 2008 19:13:12 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94389>

We use syntax in some places that is only supported on Perl 5.8 or
later.  One example for this is the list form of the open command in
combination with pipes in git-add--interactive.perl:

    open($fh, '-|', @_) or die;

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 INSTALL |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 2bae53f..0495fe5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -72,8 +72,8 @@ Issues of note:
 
 	- "ssh" is used to push and pull over the net
 
-	- "perl" and POSIX-compliant shells are needed to use most of
-	  the bare-bones Porcelainish scripts.
+	- "perl" 5.8 or later and POSIX-compliant shells are needed to use
+          most of the bare-bones Porcelainish scripts.
 
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
-- 
1.5.4.5
