From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Sat, 3 Jan 2009 14:23:28 +0100
Message-ID: <200901031423.31305.jnareb@gmail.com>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu> <6db6bed70812311027g3be1cfbei35c014243237fd59@mail.gmail.com> <200901012351.28864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Thomas Amsler" <tamsler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 14:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ6V0-0000ez-AI
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 14:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357AbZACNXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 08:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbZACNXn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 08:23:43 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:59183 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZACNXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 08:23:42 -0500
Received: by ewy10 with SMTP id 10so7127031ewy.13
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 05:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M5l1IRLe8ALx/p9xwBEoFcXO75A8yJ1FvcLd66N7fns=;
        b=Gh3K2hCfjq7bmS87zdvitWWG13ELx5kc+6lH0wxDi2Q3IyBsutoHnwOMc/xLYxf2gk
         AN8RxHxpGIOVMS+jaxoAbjtT+c3yprvI9liG7Vg0GOUDS/5YR9JjOLGFiZOTMlYjfxv8
         if+YujbyJJr5pCbX9ZgAO/Yc4Bz/tdTXDaJp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DRRPVHjU/MuWFjMAqV7U0x8O91bfoF7VpOLDKQiHB+AeCpGdsrlJtZwIJ0IpemJXYX
         SV4qFA0bpnws3W0DhrioBONxWytCVWAu/RCVNtiFBAtH81oUxgqtRo0k7dP42hEl6NLw
         BflzKGE/E4DGsR8BndiOdoDFoaMf5S/sv6QkM=
Received: by 10.210.22.16 with SMTP id 16mr8301531ebv.68.1230989019571;
        Sat, 03 Jan 2009 05:23:39 -0800 (PST)
Received: from ?192.168.1.11? (abwk96.neoplus.adsl.tpnet.pl [83.8.234.96])
        by mx.google.com with ESMTPS id k10sm53439332nfh.56.2009.01.03.05.23.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jan 2009 05:23:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200901012351.28864.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104467>

Add reminders to gitweb/README and gitweb/INSTALL that gitweb works
with bare repositories.  While it might be obvious to us, it is not
apparently as evident for newcomers.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 1 Jan 2009, Jakub Narebski wrote:

> The longer explanation (which probably should made into gitweb/README
> or gitweb/INSTALL) is that gitweb is meant to deal with _bare_ 
> repositories; gitweb doesn't touch and doesn't examine working area
> of "live" (non-bare) repository. If you host git repositories (like
> kernel.org, freedesktop.org or repo.or.cz) you usually host them bare
> (public repositories should be bare); but you might want to have
> gitweb for your own repository too.

And here it is.

By the way, I was wondering if to mark this patch as an RFC, because
I am not completely sure about the wording I used...

 gitweb/INSTALL |   14 ++++++++++++++
 gitweb/README  |   12 +++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 18c9ce3..f43e233 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -127,6 +127,20 @@ GITWEB_CONFIG file:
 Gitweb repositories
 -------------------
 
+- Gitweb deals with bare repositories, which means that gitweb scans for
+  (in the case where $projects_list is a directory to search for
+  repositories) or has to be provided with list of (in the case where
+  $projects_list is a text file) bare repositories, i.e. $GIT_DIR for
+  each repository. The consequence of that is the fact that if you use
+  gitweb to view non-bare repository named 'repo' then gitweb would show
+  (or would have to be provided with) 'repo/.git'.
+
+  If you want to view a buch of non-bare repositories in gitweb but want
+  them named 'repo.git' as is the standard for bare repositories, you
+  can as a workaround populare $projectroot / $project_list with
+  symbolic links to $GIT_DIR of each project you want to publish (have
+  shown) in gitweb.
+
 - By default all git repositories under projectroot are visible and
   available to gitweb. The list of projects is generated by default by
   scanning the projectroot directory for git repositories (for object
diff --git a/gitweb/README b/gitweb/README
index 825162a..6dbfcd5 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -34,10 +34,11 @@ You can specify the following configuration variables when building GIT:
  * GITWEB_LIST
    Points to a directory to scan for projects (defaults to project root
    if not set / if empty) or to a file with explicit listing of projects
-   (together with projects' ownership). See "Generating projects list
-   using gitweb" in INSTALL file for gitweb to find out how to generate
-   such file from scan of a directory. [No default, which means use root
-   directory for projects]
+   (together with projects' ownership). Note that gitweb deals with bare
+   repositories; it shows/uses $GIT_DIR for each repository. See also
+   "Generating projects list using gitweb" in INSTALL file for gitweb to
+   find out how to generate such file from scan of a directory. 
+   [No default, which means use root directory for projects]
  * GITWEB_EXPORT_OK
    Show repository only if this file exists (in repository).  Only
    effective if this variable evaluates to true.  [No default / Not set]
@@ -153,7 +154,8 @@ not include variables usually directly set during build):
    Absolute filesystem path which will be prepended to project path;
    the path to repository is $projectroot/$project.  Set to
    $GITWEB_PROJECTROOT during installation.  This variable have to be
-   set correctly for gitweb to find repositories.
+   set correctly for gitweb to find repositories.  (Note that gitweb deals
+   with bare repositories.)
  * $projects_list
    Source of projects list, either directory to scan, or text file
    with list of repositories (in the "<URI-encoded repository path> SP
-- 
1.6.0.4
