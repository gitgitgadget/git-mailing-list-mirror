From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Fri, 15 May 2009 23:17:57 +0200
Message-ID: <20090515211611.27697.82605.stgit@localhost.localdomain>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Timur Tabi <timur@freescale.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri May 15 23:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54nB-0005Xk-QO
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbZEOVSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZEOVSA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:18:00 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:36710 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbZEOVR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:17:59 -0400
Received: by bwz22 with SMTP id 22so2142062bwz.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:cc:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=aJZw80siQ4rm29U8PaLSeoHgC4dHwKFtkjOV8NCPdok=;
        b=CflSQbuquoxscTi2cS5m7LzsDgKqv47ejRr/dAsGX12MC8+XLup9ymtgvZGhRdnQDm
         ioqOU0vvfcAzmkr+vhURPc3Rngqgm5AgQPp7GNX0PJKiW5H7dMriu7YXWIImNCYs7ccV
         lfB/ejYEQ7988h+TiItbakr/y8lRYBA5MHlI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:cc:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-type:content-transfer-encoding;
        b=h39eoc2JqFrwiStq6VOvsXlZtNIw6YZ4WNQeqsm1uSlfha+MA9eR1jnJExB91ahIaZ
         EvUN765ndnTwwxc0fRBHlZ3JiB+xv2QkqhafVgN8bOSnGFWArwr8LodrM/8jfOdkhCbJ
         J8WEh1KzQuYC5yx87T9i4oqLKgaVJL084oZ8Y=
Received: by 10.103.214.8 with SMTP id r8mr2550363muq.92.1242422279398;
        Fri, 15 May 2009 14:17:59 -0700 (PDT)
Received: from localhost.localdomain (abvj81.neoplus.adsl.tpnet.pl [83.8.207.81])
        by mx.google.com with ESMTPS id e8sm1799547muf.6.2009.05.15.14.17.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 14:17:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4FLHwna027744;
	Fri, 15 May 2009 23:17:59 +0200
In-Reply-To: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119298>

Add reminders to gitweb/README and gitweb/INSTALL that gitweb works
with bare repositories.  While it might be obvious to us, it is not
apparently as evident for newcomers.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Timur Tabi wrote:

> I noticed that most gitweb pages show their repositories like this:
> 
> bluetooth/bluez-gnome.git 	Bluetooth applications for ... 	Marcel Holtmann
> bluetooth/bluez-hcidump.git 	Bluetooth packet analyzer 	Marcel Holtmann
> bluetooth/bluez.git		Bluetooth protocol stack for... Marcel Holtmann
> 
> However, mine looks like this:
> 
> alsa.1862/.git  8610 audio: fabric driver uses wrong DMA channels for... 	Timur
> alsa.2598/.git  8610 audio: migrate ASoC V2 drivers to mainline	Timur
> alsa.3313/.git  Introduce spin_event_timeout()	Timur
> 
> Notice how my repositories have a trailing "/.git" to them?  How do I
> get rid of that?
> 
> My gitweb.conf is:
> 
> $projectroot = '/home/b04825/git/';
> $site_name = "Timur Tabi's git repositories";
> $home_link = $my_uri;
> @stylesheets = ("gitweb.css");
> $favicon = "git-favicon.png";
> $logo = "git-logo.png";
> $projects_list = '/home/b04825/git/projects_list';
> $projects_list_description_width = 50;
> 
> And /home/b04825/git/projects_list looks like:
> 
> alsa.1862/.git Timur
> alsa.2598/.git Timur
> alsa.3313/.git Timur
> 
> I presume the reason why gitweb shows the trailing "/.git" is because
> that's what my projects_list file contains.  However, if I remove the
> "/.git" from projects_list, gitweb can't find any repositories.

Does this explanation help?

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
index ccda890..a61fa2f 100644
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
