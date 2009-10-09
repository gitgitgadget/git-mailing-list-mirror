From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3-4/9 v2] Documentation: clarify mergeoptions description
Date: Fri, 9 Oct 2009 13:51:14 -0500
Message-ID: <20091009185114.GA3610@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101743.GD16558@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwKUp-0003JE-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725AbZJISoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbZJISox
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:44:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:26043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZJISox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:44:53 -0400
Received: by fg-out-1718.google.com with SMTP id 22so403876fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c1xl7aqLmvv7wPG/r2AM6ookD8jZJ5XOa86026gRteM=;
        b=FKQepwrEf1sLRGAPoQlAohoy0GOue4IdgCmOE5+MCX4Zu7gkZMiTAn1J0xE8RDlkVG
         MmtNtxh6+ggK3MPE1PSpPsiVE2xX+8avmzXMvmenOOFxzDkjqYpz4HBppfQxhsv73Gud
         DUywkdtg3WZP+OjqUWKyFEB2r07RGLeL5o4/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wiyUQgSZMm+uII9Ih0T9px6YlmLc9c01U4h343fkspEtm7hFpE1TY8hQgjIKLob38F
         iNukJpKhrAG15phrl9muBWSzgtNpjHEBfZ3jPVGOaQgsZO4TluFqmQnANdoXQgraocv3
         xDmnQrfNolXl4NKoUoBdBcm705jsUQYodVrKk=
Received: by 10.86.17.27 with SMTP id 27mr2700612fgq.31.1255113784868;
        Fri, 09 Oct 2009 11:43:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e20sm262051fga.0.2009.10.09.11.43.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 11:43:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101743.GD16558@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129832>

Sounds better this way, at least to my ears.  ("The syntax and
supported options of git merge" is a plural noun.  "the same"
instead of "equal" sounds less technical and seems to convey
the meaning better here.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sean Estabrooks wrote:

> P.S.  Patches 3 and 4 in this series would be better as a single patch.

Good idea.  Here's a squashed version.

 Documentation/config.txt    |    2 +-
 Documentation/git-merge.txt |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index be0b8ca..cd17814 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -539,7 +539,7 @@ branch.<name>.merge::
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of linkgit:git-merge[1], but
+	supported options are the same as those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
 	supported.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 354e9d9..6ffd4b0 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -50,8 +50,8 @@ include::merge-config.txt[]
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of 'git-merge', but option values
-	containing whitespace characters are currently not supported.
+	supported options are the same as those of 'git-merge', but option
+	values containing whitespace characters are currently not supported.
 
 HOW MERGE WORKS
 ---------------
-- 
1.6.5.rc1.199.g596ec
