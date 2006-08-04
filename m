From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: git_heads cleanup
Date: Sat, 5 Aug 2006 00:42:30 +0200
Message-ID: <200608050042.30470.jnareb@gmail.com>
References: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98Nr-0007PF-R4
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161549AbWHDWm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWHDWm5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:42:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:53477 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161549AbWHDWmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:42:54 -0400
Received: by nf-out-0910.google.com with SMTP id k26so45286nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ic8Sv5svGZBHWsKTORlBGAOGGi/jFKltoqGoVek4LlVKfQ44xZPNaiknx/Q/hJ7qC0ovir2BVW1OPNpzvBuqrvMd9wArdKrlweZg29y+AgZYFTE379UtLFhoq+TUlcnBszYhCDjNl0xiICaLjzgjwjxypEAtaAr+TrU+pJ+Ooyo=
Received: by 10.48.242.19 with SMTP id p19mr6077348nfh;
        Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id q28sm2928781nfc.2006.08.04.15.42.52;
        Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608050036.06490.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24857>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Leftover from refactor generation of shortlog, tags and heads body.

 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5b30654..9e4822b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1641,7 +1641,6 @@ sub git_heads {
 	git_print_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/heads");
-	my $alternate = 0;
 	if (defined @$taglist) {
 		git_heads_body($taglist, $head);
 	}
-- 
1.4.1.1
