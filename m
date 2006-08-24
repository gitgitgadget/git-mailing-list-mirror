From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4] gitweb: Remove invalid comment in format_diff_line
Date: Thu, 24 Aug 2006 19:32:13 +0200
Message-ID: <200608241932.14635.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHD-00011m-98
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWHXRp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWHXRp4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:45:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14929 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965071AbWHXRpz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:45:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638000nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L8bwnyZh7LPLRws2MV0sEZOGtxyCcdgtBqqtWXDOPyE3U98QPP25AlNQQTqWUqoGN9ZRiHHVI97SM+VA11M5NaARhYQPIhGIoW6XsKPyvFX+CNapFQa0Ex/SbfZO0CFsN2ujaRJ0RGKueGlem+fqH/9uKt2H9lwuPGYFGKabscA=
Received: by 10.49.75.2 with SMTP id c2mr4038328nfl;
        Thu, 24 Aug 2006 10:45:54 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.53;
        Thu, 24 Aug 2006 10:45:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25965>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch and all subsequent patches assumes (although this should
have no bearing) that patch
  [PATCH 2] gitweb: Replace git_commitdiff_plain by anonymous subroutine
was not applied. (In my repository this commit had been simply reverted).

 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fe9b9ee..1d3d9df 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -538,7 +538,6 @@ sub format_diff_line {
 	} elsif ($char eq "@") {
 		$diff_class = " chunk_header";
 	} elsif ($char eq "\\") {
-		# skip errors (incomplete lines)
 		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
-- 
1.4.1.1
