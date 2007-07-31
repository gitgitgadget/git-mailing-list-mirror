From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make verse of git-config manpage more readable
Date: Wed, 1 Aug 2007 00:01:17 +0200
Message-ID: <20070731220117.GA3196@steel.home>
References: <81b0412b0707310453pc6b11d2r90ca0f22b5ed601e@mail.gmail.com> <Pine.LNX.4.64.0707311258340.14781@racer.site> <81b0412b0707310502x588c9c6dh7d9290360b27647a@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFzmT-0001Se-KF
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 00:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760369AbXGaWBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757105AbXGaWBW
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 18:01:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:26592 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbXGaWBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 18:01:21 -0400
Received: from tigra.home (Fa803.f.strato-dslnet.de [195.4.168.3])
	by post.webmailer.de (fruni mo7) (RZmta 10.3)
	with ESMTP id 601c30j6VKgxmD ; Wed, 1 Aug 2007 00:01:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 19A1C277BD;
	Wed,  1 Aug 2007 00:01:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 934D5C21D; Wed,  1 Aug 2007 00:01:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0707310502x588c9c6dh7d9290360b27647a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTZ4
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54376>

Also mention '--file' in FILES.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Tue, Jul 31, 2007 14:02:13 +0200:
> On 7/31/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > You could use this chance to make the verse nicer, i.e. split it into a
> > [<file-option>] and an [<action>] part.

Did only the long one, file-option. I don't think the [<action>] part
is essential, though. It is quite understandable...

 Documentation/git-config.txt |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 88acf6c..8451ccc 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,17 +9,17 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global | [-f|--file] config-file] [type] [-z|--null] name [value [value_regex]]
-'git-config' [--system | --global | [-f|--file] config-file] [type] --add name value
-'git-config' [--system | --global | [-f|--file] config-file] [type] --replace-all name [value [value_regex]]
-'git-config' [--system | --global | [-f|--file] config-file] [type] [-z|--null] --get name [value_regex]
-'git-config' [--system | --global | [-f|--file] config-file] [type] [-z|--null] --get-all name [value_regex]
-'git-config' [--system | --global | [-f|--file] config-file] [type] [-z|--null] --get-regexp name_regex [value_regex]
-'git-config' [--system | --global | [-f|--file] config-file] --unset name [value_regex]
-'git-config' [--system | --global | [-f|--file] config-file] --unset-all name [value_regex]
-'git-config' [--system | --global | [-f|--file] config-file] --rename-section old_name new_name
-'git-config' [--system | --global | [-f|--file] config-file] --remove-section name
-'git-config' [--system | --global | [-f|--file] config-file] [-z|--null] -l | --list
+'git-config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
+'git-config' [<file-option>] [type] --add name value
+'git-config' [<file-option>] [type] --replace-all name [value [value_regex]]
+'git-config' [<file-option>] [type] [-z|--null] --get name [value_regex]
+'git-config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
+'git-config' [<file-option>] [type] [-z|--null] --get-regexp name_regex [value_regex]
+'git-config' [<file-option>] --unset name [value_regex]
+'git-config' [<file-option>] --unset-all name [value_regex]
+'git-config' [<file-option>] --rename-section old_name new_name
+'git-config' [<file-option>] --remove-section name
+'git-config' [<file-option>] [-z|--null] -l | --list
 
 DESCRIPTION
 -----------
@@ -40,6 +40,12 @@ convert the value to the canonical form (simple decimal number for int,
 a "true" or "false" string for bool).  If no type specifier is passed,
 no checks or transformations are performed on the value.
 
+The file-option can be one of '--system', '--global' or '--file'
+which specify where the values will be read from or written to.
+The default is to assume the config file of the current repository,
+.git/config unless defined otherwise with GIT_DIR and GIT_CONFIG
+(see <<FILES>>).
+
 This command will fail if:
 
 . The config file is invalid,
@@ -133,8 +139,8 @@ See also <<FILES>>.
 FILES
 -----
 
-There are three files where git-config will search for configuration
-options:
+If not set explicitely with '--file', there are three files where
+git-config will search for configuration options:
 
 .git/config::
 	Repository specific configuration file. (The filename is
-- 
1.5.3.rc3.116.g94fd8
