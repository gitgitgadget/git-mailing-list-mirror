From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] Documentation: say "the same" instead of "equal"
Date: Fri, 9 Oct 2009 05:17:43 -0500
Message-ID: <20091009101743.GD16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUt-0002is-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482AbZJIKJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760439AbZJIKJm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:09:42 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:52990 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760113AbZJIKJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:09:41 -0400
Received: by mail-vw0-f203.google.com with SMTP id 41so3687112vws.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pi723Gs79XFUOliPvsCPq8LV9+4sCkmV2HyVQ+zE7rQ=;
        b=Nm4qgeAJBDNT35LOpcX+UoCbnOUJGtsJOSpiBwrvufA5LmRr466Qa8dYGOJHu1Urur
         UNNpQnbjmoNLU3A2U9q78RAHxm+IpjZis+whtZs0/1oU5JYytTREedwgOCdO2iBxAUz+
         1QQQvNotMpxZEpxm2w8U01EFbAcdWNPHGJjbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nt7eMpzjZ+fhUfuS6sPg7PpMOhDsq6xgcanlDt3KYdl3M0tJFD9KeZWJwODEM0nQXv
         3fALG1xm2gnBRl4PSG3CLvElHjxkb2AZGpyNhFW+RouIjIRsh4n5lMzqMmQwopLVMYDy
         iF2Bdy4z67MvC1sUnsdlHWXTfH+V/DbkU02j0=
Received: by 10.220.89.82 with SMTP id d18mr3677009vcm.34.1255082970880;
        Fri, 09 Oct 2009 03:09:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm980yxe.13.2009.10.09.03.09.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:09:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129758>

When non-mathematical objects are declared equal in documentation,
this is a sign that perhaps the discussion is becoming too
technical or exact.  Use "same" instead if no other nuance is
required.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt    |    2 +-
 Documentation/git-merge.txt |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d01dde..cd17814 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -539,7 +539,7 @@ branch.<name>.merge::
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to those of linkgit:git-merge[1], but
+	supported options are the same as those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
 	supported.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6da07bb..6ffd4b0 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -50,8 +50,8 @@ include::merge-config.txt[]
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to those of 'git-merge', but option values
-	containing whitespace characters are currently not supported.
+	supported options are the same as those of 'git-merge', but option
+	values containing whitespace characters are currently not supported.
 
 HOW MERGE WORKS
 ---------------
-- 
1.6.5.rc1.199.g596ec
