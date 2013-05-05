From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Git::SVN::*: add missing "NAME" section to perldoc
Date: Sun, 5 May 2013 00:50:33 -0700
Message-ID: <20130505075033.GA27215@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 05 09:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYtim-0008Ho-MY
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 09:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab3EEHuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 03:50:44 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55392 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab3EEHun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 03:50:43 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so1559958pad.2
        for <git@vger.kernel.org>; Sun, 05 May 2013 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=KkxVzc+Z+yJEJK122xToh+a7NPPyvrouUFv0Sk/OcRs=;
        b=R77zi/FDcLhrli8EQRE724qoTrfTf8vUqQIyDsQ2JOz/DUZEZm4I0PHZcvJFxQTmSl
         4HUApVxOH2PCMn6qKpbyP+mjt23NqVRgFkAbqQbHgOLOD0B8wKtDvsmfUxV1D29RDaBX
         2av1w/P1QvX3R/qRRhe/c3baOciO26P/nhOXFiJv7ZW5F1RQ0IUSnX1DFBRq5n9StoC7
         Js4EKs4gmLYKsr4ASLRu74eYJul14aHWwJ4xAJo4HM1UZzZ1FXFG+GPot5tTPJEtufEl
         uf/wIs/zk8kkeqDDrOoy9ERA8fVmt+jnaIIpgg/f322YLW7kFkJlCxHJa1nwRqya9EzH
         SwyA==
X-Received: by 10.66.216.136 with SMTP id oq8mr21528122pac.161.1367740243009;
        Sun, 05 May 2013 00:50:43 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id fn2sm10995665pbc.15.2013.05.05.00.50.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 05 May 2013 00:50:41 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223394>

lexgrog(1) relies on the NAME section to find a manpage's subject's
name and description for easy access later using "man -k".  Add the
section it expects.

Noticed using lintian.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Eric,

Just noticed this by running a tool to sanity-check my build result.
I hadn't noticed before because I hadn't been installing the manpages.
Anyway, perhaps the patch can be useful.

 perl/Git/SVN/Editor.pm  | 2 ++
 perl/Git/SVN/Fetcher.pm | 2 ++
 perl/Git/SVN/Prompt.pm  | 2 ++
 perl/Git/SVN/Ra.pm      | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index fa0d3c6c..b3bcd476 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -499,6 +499,8 @@ sub apply_diff {
 1;
 __END__
 
+=head1 NAME
+
 Git::SVN::Editor - commit driver for "git svn set-tree" and dcommit
 
 =head1 SYNOPSIS
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 046a7a2f..72150af6 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -512,6 +512,8 @@ sub stash_placeholder_list {
 1;
 __END__
 
+=head1 NAME
+
 Git::SVN::Fetcher - tree delta consumer for "git svn fetch"
 
 =head1 SYNOPSIS
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index 74daa7a5..e940b085 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -125,6 +125,8 @@ sub _read_password {
 1;
 __END__
 
+=head1 NAME
+
 Git::SVN::Prompt - authentication callbacks for git-svn
 
 =head1 SYNOPSIS
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 6a212eb7..75ecc425 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -627,6 +627,8 @@ sub skip_unknown_revs {
 1;
 __END__
 
+=head1 NAME
+
 Git::SVN::Ra - Subversion remote access functions for git-svn
 
 =head1 SYNOPSIS
-- 
1.8.3.rc1
