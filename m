From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] Documentation: fix singular/plural mismatch
Date: Fri, 9 Oct 2009 05:16:57 -0500
Message-ID: <20091009101657.GC16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUt-0002is-Cb
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760600AbZJIKJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760439AbZJIKJX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:09:23 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:52990 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760113AbZJIKJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:09:22 -0400
Received: by vws41 with SMTP id 41so3687112vws.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CRi0nwVTwjUuszleST4dpATePODIa4Djc/YdD1lQYOw=;
        b=lq/XqPupQ7rO0mwxPQ3oIuJ0EiZcOkQ3LoD4kkMEBUqOraGun76OYldg347qMxB/cW
         3Mrx2T9HA/R0RDyFpDC7qW4x9CiF6gzgn1T+XNqX8QWmLFF3JmhGmQPvXduN9xZqvjnu
         4/0VPCFz1vza0nDJ94ChS0LR9ogSptC5CV6Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ai9/+OlVlO3x61wKvGD4L7jhoRnZqP7b9iNl4/pthTtIhxew53uK7lZpQ6nfnmYAIe
         tEqv95+hTUk1AjfOVtJvBmDky4w+B94l+Qz+tboI05EB3elXCKtMWzcUG+S55f8Za7NT
         JZ3OpWUEBXMue0jcr00p5AcZUyluTlI/Lik7E=
Received: by 10.220.44.136 with SMTP id a8mr3598732vcf.47.1255082925296;
        Fri, 09 Oct 2009 03:08:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm900yxe.12.2009.10.09.03.08.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129760>

Sounds better this way, at least to my ears.  ("syntax and
supported options of git merge" is a plural noun.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt    |    2 +-
 Documentation/git-merge.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index be0b8ca..4d01dde 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -539,7 +539,7 @@ branch.<name>.merge::
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of linkgit:git-merge[1], but
+	supported options are equal to those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
 	supported.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 354e9d9..6da07bb 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -50,7 +50,7 @@ include::merge-config.txt[]
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of 'git-merge', but option values
+	supported options are equal to those of 'git-merge', but option values
 	containing whitespace characters are currently not supported.
 
 HOW MERGE WORKS
-- 
1.6.5.rc1.199.g596ec
