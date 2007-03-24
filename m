From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add some installation notes in gitweb/INSTALL
Date: Sat, 24 Mar 2007 20:59:53 +0100
Message-ID: <11747663931269-git-send-email-jnareb@gmail.com>
References: <etufpl$7en$1@sea.gmane.org>
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 20:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCME-0000Xu-Ne
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 20:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbXCXT4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbXCXT4z
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 15:56:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:25173 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbXCXT4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 15:56:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1289093uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 12:56:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IV/1IfVPb1WvvgLvtWDxZCuvxLU8yDccftacm04cRSkEjIRNgSi/yNNj7EuadWQSmXEsOw+TP2uhvurtPQ+YfIzRloQT3MvODcqlYzaqhp21j5PT5553LcmLDhh48+cftfxEUIAtyN2B5u091CFn5rpZ/43JKh6jaJdqHvt1Dng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EGjswoboA7B21AnPUU8mHTCj4kF3vNFdFIYrLcGqlnIE/uLx7kbJpjkJptASCB8gBQzssRyBdzpvekrcRE9SAmp1yvqwivkuQNw3At/KVVYUA8HcjpRvmmRhi0RIN8XkYcdzuOI0JMypwStX4c/iJqRolmgjqJH38cnEe4iqfYk=
Received: by 10.67.21.11 with SMTP id y11mr9056457ugi.1174766212317;
        Sat, 24 Mar 2007 12:56:52 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm21163505muf.2007.03.24.12.56.49;
        Sat, 24 Mar 2007 12:56:50 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l2OJxrva006440;
	Sat, 24 Mar 2007 20:59:54 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l2OJxrVh006439;
	Sat, 24 Mar 2007 20:59:53 +0100
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <etufpl$7en$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43013>

Add some installation and configuration notes for gitweb in
gitweb/INSTALL. Make use of filling gitweb configuration by
Makefile.

It does not cover (yet?) all the configuration variables and
options.

Some of contents duplicates information in gitweb/README file
(it is referred from gitweb/INSTALL).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, Mar 22, 2007, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:

> I'm trying to get gitweb to serve my local repositories on the intranet
> here, but I am not successful in getting it to run.  I got as far as
> getting gitweb page, containing no projects but only "403 forbidden - No
> projects found." I tried setting the projects_list to a directory, a
> subdirectory, a file with the projects to be published, etc.
>
> Is there a guide on setting up gitweb for hare-brained people like me
> that don't know apache and don't know perl? In particular, the format of
> gitweb_conf.perl is not documented at all.

I hope that this addresses your questions.

---
We should probably think about what should go to gitweb/README
file, and what should go to gitweb/INSTALL. 

I haven't checked gitweb/README when writing gitweb/INSTALL, so it
repeats some information from README (there are references to related
sections in README).

Some information which is in gitweb/README should probably be in
gitweb/INSTALL, but gitweb/INSTALL did not exist when the information
was added.


Another issue is using `cp' vs `install' for gitweb installation.

 gitweb/INSTALL |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/INSTALL

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
new file mode 100644
index 0000000..371407d
--- /dev/null
+++ b/gitweb/INSTALL
@@ -0,0 +1,184 @@
+GIT web Interface (gitweb) Installation
+=======================================
+
+First you have to generate gitweb.cgi from gitweb.perl using
+"make gitweb/gitweb.cgi", then copy appropriate files (gitweb.cgi,
+gitweb.css, git-logo.png and git-favicon.png) to their destination.
+For example if git was (or is) installed with /usr prefix, you can do
+
+	$ make prefix=/usr gitweb/gitweb.cgi  ;# as yourself
+	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+
+Alternatively you can use autoconf generated ./configure script to
+set up path to git binaries (via config.mak.autogen), so you can write
+instead
+
+	$ make configure                     ;# as yourself
+	$ ./configure --prefix=/usr          ;# as yourself
+	$ make gitweb/gitweb.cgi             ;# as yourself
+	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+
+The above example assumes that your web server is configured to run
+[executable] files in /var/www/cgi-bin/ as server scripts (as CGI
+scripts).
+
+
+Build time configuration
+------------------------
+
+See also "How to configure gitweb for your local system" in README
+file for gitweb (in gitweb/README).
+
+- There are many configuration variables which affects building of
+  gitweb.cgi; see "default configuration for gitweb" section in main
+  (top dir) Makefile, and instructions for building gitweb/gitweb.cgi
+  target.
+
+  One of most important is where to find git wrapper binary. Gitweb
+  tries to find git wrapper at $(bindir)/git, so you have to set $bindir
+  when building gitweb.cgi, or $prefix from which $bindir is derived. If
+  you build and install gitweb together with the rest of git suite,
+  there should be no problems. Otherwise, if git was for example
+  installed from a binary package, you have to set $prefix (or $bindir)
+  accordingly.
+
+- Another important issue is where are git repositories you want to make
+  available to gitweb. By default gitweb search for repositories under
+  /pub/git; if you want to have projects somewhere else, like /home/git,
+  use GITWEB_PROJECTROOT build configuration variable.
+
+  By default all git repositories under projectroot are visible and
+  available to gitweb. List of projects is generated by default by
+  scanning the projectroot directory for git repositories. This can be
+  changed (configured) as described in "Gitweb repositories" section
+  below.
+
+  Note that gitweb deals directly with object database, and does not
+  need working directory; the name of the project is the name of its
+  repository object database, usually projectname.git for bare
+  repositories. If you want to provide gitweb access to non-bare (live)
+  repository, you can make projectname.git symbolic link under
+  projectroot linking to projectname/.git (but it is just
+  a suggestion).
+
+- You can control where gitweb tries to find its main CSS style file,
+  its favicon and logo with GITWEB_CSS, GITWEB_FAVICON and GITWEB_LOGO
+  build configuration variables. By default gitweb tries to find them
+  in the same directory as gitweb.cgi script.
+
+Build example
+~~~~~~~~~~~~~
+
+- To install gitweb to /var/www/cgi-bin/gitweb/ when git wrapper
+  is installed at /usr/local/bin/git and the repositories (projects)
+  we want to display are under /home/local/scm, you can do
+
+	make GITWEB_PROJECTROOT="/home/local/scm" \
+	     GITWEB_CSS="/gitweb/gitweb.css" \
+	     GITWEB_LOGO="/gitweb/git-logo.png" \
+	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
+	     bindir=/usr/local/bin \
+	     gitweb/gitweb.cgi
+
+	cp -fv ~/git/gitweb/gitweb.{cgi,css} \
+	       ~/git/gitweb/git-{favicon,logo}.png \
+	     /var/www/cgi-bin/gitweb/
+
+
+Gitweb config file
+------------------
+
+See also "Runtime gitweb configuration" section in README file
+for gitweb (in gitweb/README).
+
+- You can configure gitweb further using gitweb configuration file;
+  by default it is file named gitweb_config.perl in the same place as
+  gitweb.cgi script. You can control default place for config file
+  using GITWEB_CONFIG build configuration variable, and you can set it
+  using GITWEB_CONFIG environmental variable.
+
+- Gitweb config file is [fragment] of perl code. You can set variables
+  using "our $variable = value"; text from "#" character until the end
+  of a line is ignored. See perlsyn(1) for details.
+
+  See the top of gitweb.perl file for examples of customizable options.
+
+
+Gitweb repositories:
+--------------------
+
+- By default all git repositories under projectroot are visible and
+  available to gitweb. List of projects is generated by default by
+  scanning the projectroot directory for git repositories (for object
+  databases to be more exact).
+
+  You can provide pre-generated list of [visible] repositories,
+  together with information about their owners (the project ownership
+  is taken from owner of repository directory otherwise), by setting
+  GITWEB_LIST build configuration variable (or $projects_list variable
+  in gitweb config file) to point to a plain file.
+
+  Each line of projects list file should consist of url-encoded path
+  to project repository database (relative to projectroot) separated
+  by space from url-encoded project owner; spaces in both project path
+  and project owner have to be encoded as either '%20' or '+'.
+
+  You can generate projects list index file using project_index action
+  (the 'TXT' link on projects list page) directly from gitweb.
+
+- By default even if project is not visible on projects list page, you
+  can view it nevertheless by hand-crafting gitweb URL. You can set
+  GITWEB_STRICT_EXPORT build configuration variable (or $strict_export
+  variable in gitweb config file) to only allow viewing of
+  repositories also shown on the overview page.
+
+- Alternatively, you can configure gitweb to only list and allow
+  viewing of the explicitly exported repositories, via
+  GITWEB_EXPORT_OK build configuration variable (or $export_ok
+  variable in gitweb config file). If it evaluates to true, gitweb
+  show repository only if this file exists in its object database
+  (if directory has the magic file $export_ok).
+
+
+Requirements
+------------
+
+ - Core git tools
+ - Perl
+ - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
+ - web server
+
+
+Example web server configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+See also "Webserver configuration" section in README file for gitweb
+(in gitweb/README).
+
+
+- Apache2, gitweb installed as CGI script,
+  under /var/www/cgi-bin/
+
+	ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
+
+	<Directory "/var/www/cgi-bin">
+	    Options Indexes FollowSymlinks ExecCGI
+	    AllowOverride None
+	    Order allow,deny
+	    Allow from all
+	</Directory>
+
+- Apache2, gitweb installed as mod_perl legacy script,
+  under /var/www/perl/
+
+	Alias /perl "/var/www/perl"
+
+	<Directory "/var/www/perl">
+	    SetHandler perl-script
+	    PerlResponseHandler ModPerl::Registry
+	    PerlOptions +ParseHeaders
+	    Options Indexes FollowSymlinks +ExecCGI
+	    AllowOverride None
+	    Order allow,deny
+	    Allow from all
+	</Directory>
-- 
1.5.0.5
