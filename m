From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/9] gitweb: No periods for error messages
Date: Sat, 05 Aug 2006 13:13:53 +0200
Organization: At home
Message-ID: <eb1ug6$8ti$2@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:30:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KM7-0004fz-V5
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWHELaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWHELaI
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:2472 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161124AbWHELaG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:30:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9KLy-0004f0-1d
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:30:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:30:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24911>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Like in Luben Tuikov patch

 gitweb/gitweb.perl |   92 ++++++++++++++++++++++++++--------------------------
 1 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8773a8d..d8ba016 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -76,7 +76,7 @@ # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
        if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
-               die_error(undef, "Invalid action parameter.");
+               die_error(undef, "Invalid action parameter");
        }
        # action which does not check rest of parameters
        if ($action eq "opml") {
@@ -89,13 +89,13 @@ our $project = ($cgi->param('p') || $ENV
 if (defined $project) {
        $project =~ s|^/||; $project =~ s|/$||;
        if (!validate_input($project)) {
-               die_error(undef, "Invalid project parameter.");
+               die_error(undef, "Invalid project parameter");
        }
        if (!(-d "$projectroot/$project")) {
-               die_error(undef, "No such directory.");
+               die_error(undef, "No such directory");
        }
        if (!(-e "$projectroot/$project/HEAD")) {
-               die_error(undef, "No such project.");
+               die_error(undef, "No such project");
        }
        $rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
                    "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
@@ -108,42 +108,42 @@ if (defined $project) {
 our $file_name = $cgi->param('f');
 if (defined $file_name) {
        if (!validate_input($file_name)) {
-               die_error(undef, "Invalid file parameter.");
+               die_error(undef, "Invalid file parameter");
        }
 }
 
 our $hash = $cgi->param('h');
 if (defined $hash) {
        if (!validate_input($hash)) {
-               die_error(undef, "Invalid hash parameter.");
+               die_error(undef, "Invalid hash parameter");
        }
 }
 
 our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
        if (!validate_input($hash_parent)) {
-               die_error(undef, "Invalid hash parent parameter.");
+               die_error(undef, "Invalid hash parent parameter");
        }
 }
 
 our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
        if (!validate_input($hash_base)) {
-               die_error(undef, "Invalid hash base parameter.");
+               die_error(undef, "Invalid hash base parameter");
        }
 }
 
 our $page = $cgi->param('pg');
 if (defined $page) {
        if ($page =~ m/[^0-9]$/) {
-               die_error(undef, "Invalid page parameter.");
+               die_error(undef, "Invalid page parameter");
        }
 }
 
 our $searchtext = $cgi->param('s');
 if (defined $searchtext) {
        if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
-               die_error(undef, "Invalid search parameter.");
+               die_error(undef, "Invalid search parameter");
        }
        $searchtext = quotemeta $searchtext;
 }
@@ -172,7 +172,7 @@ my %actions = (
 
 $action = 'summary' if (!defined($action));
 if (!defined($actions{$action})) {
-       die_error(undef, "Unknown action.");
+       die_error(undef, "Unknown action");
 }
 $actions{$action}->();
 exit;
@@ -418,7 +418,7 @@ sub git_get_hash_by_path {
        my $tree = $base;
 
        open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
-               or die_error(undef, "Open git-ls-tree failed.");
+               or die_error(undef, "Open git-ls-tree failed");
        my $line = <$fd>;
        close $fd or return undef;
 
@@ -1265,13 +1265,13 @@ ## actions
 sub git_project_list {
        my $order = $cgi->param('o');
        if (defined $order && $order !~ m/project|descr|owner|age/) {
-               die_error(undef, "Invalid order parameter '$order'.");
+               die_error(undef, "Invalid order parameter '$order'");
        }
 
        my @list = git_read_projects();
        my @projects;
        if (!@list) {
-               die_error(undef, "No projects found.");
+               die_error(undef, "No projects found");
        }
        foreach my $pr (@list) {
                my $head = git_read_head($pr->{'path'});
@@ -1405,7 +1405,7 @@ sub git_summary {
              "</table>\n";
 
        open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project)
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist = map { chomp; $_ } <$fd>;
        close $fd;
        git_header_div('shortlog');
@@ -1461,10 +1461,10 @@ sub git_tag {
 sub git_blame2 {
        my $fd;
        my $ftype;
-       die_error(undef, "Permission denied.") if (!git_get_project_config_bool ('blame'));
+       die_error(undef, "Permission denied") if (!git_get_project_config_bool ('blame'));
        die_error('404 Not Found', "File name not defined") if (!$file_name);
        $hash_base ||= git_read_head($project);
-       die_error(undef, "Couldn't find base commit.") unless ($hash_base);
+       die_error(undef, "Couldn't find base commit") unless ($hash_base);
        my %co = git_read_commit($hash_base)
                or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
@@ -1476,7 +1476,7 @@ sub git_blame2 {
                die_error("400 Bad Request", "Object is not a blob");
        }
        open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
-               or die_error(undef, "Open git-blame failed.");
+               or die_error(undef, "Open git-blame failed");
        git_header_html();
        my $formats_nav =
                $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
@@ -1519,18 +1519,18 @@ sub git_blame2 {
 
 sub git_blame {
        my $fd;
-       die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
-       die_error('404 Not Found', "File name not defined.") if (!$file_name);
+       die_error('403 Permission denied', "Permission denied") if (!git_get_project_config_bool ('blame'));
+       die_error('404 Not Found', "File name not defined") if (!$file_name);
        $hash_base ||= git_read_head($project);
-       die_error(undef, "Couldn't find base commit.") unless ($hash_base);
+       die_error(undef, "Couldn't find base commit") unless ($hash_base);
        my %co = git_read_commit($hash_base)
-               or die_error(undef, "Reading commit failed.");
+               or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
                $hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-                       or die_error(undef, "Error lookup file.");
+                       or die_error(undef, "Error lookup file");
        }
        open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
-               or die_error(undef, "Open git-annotate failed.");
+               or die_error(undef, "Open git-annotate failed");
        git_header_html();
        my $formats_nav =
                $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
@@ -1640,9 +1640,9 @@ sub git_blob_plain {
                if (defined $file_name) {
                        my $base = $hash_base || git_read_head($project);
                        $hash = git_get_hash_by_path($base, $file_name, "blob")
-                               or die_error(undef, "Error lookup file.");
+                               or die_error(undef, "Error lookup file");
                } else {
-                       die_error(undef, "No file name defined.");
+                       die_error(undef, "No file name defined");
                }
        }
        my $type = shift;
@@ -1673,14 +1673,14 @@ sub git_blob {
                if (defined $file_name) {
                        my $base = $hash_base || git_read_head($project);
                        $hash = git_get_hash_by_path($base, $file_name, "blob")
-                               or die_error(undef, "Error lookup file.");
+                               or die_error(undef, "Error lookup file");
                } else {
-                       die_error(undef, "No file name defined.");
+                       die_error(undef, "No file name defined");
                }
        }
        my $have_blame = git_get_project_config_bool ('blame');
        open my $fd, "-|", $GIT, "cat-file", "blob", $hash
-               or die_error(undef, "Couldn't cat $file_name, $hash.");
+               or die_error(undef, "Couldn't cat $file_name, $hash");
        my $mimetype = git_blob_plain_mimetype($fd, $file_name);
        if ($mimetype !~ m/^text\//) {
                close $fd;
@@ -1738,9 +1738,9 @@ sub git_tree {
        }
        $/ = "\0";
        open my $fd, "-|", $GIT, "ls-tree", '-z', $hash
-               or die_error(undef, "Open git-ls-tree failed.");
+               or die_error(undef, "Open git-ls-tree failed");
        my @entries = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading tree failed.");
+       close $fd or die_error(undef, "Reading tree failed");
        $/ = "\n";
 
        my $refs = read_info_ref();
@@ -1816,7 +1816,7 @@ sub git_log {
 
        my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
        open my $fd, "-|", $GIT, "rev-list", $limit, $hash
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist = map { chomp; $_ } <$fd>;
        close $fd;
 
@@ -1877,7 +1877,7 @@ sub git_log {
 sub git_commit {
        my %co = git_read_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
        my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
@@ -1887,9 +1887,9 @@ sub git_commit {
                $parent = "--root";
        }
        open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $hash
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed");
 
        # non-textual hash id's can be cached
        my $expires;
@@ -2105,15 +2105,15 @@ sub git_commitdiff {
        mkdir($git_temp, 0700);
        my %co = git_read_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        if (!defined $hash_parent) {
                $hash_parent = $co{'parent'};
        }
        open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed");
 
        # non-textual hash id's can be cached
        my $expires;
@@ -2191,9 +2191,9 @@ sub git_commitdiff {
 sub git_commitdiff_plain {
        mkdir($git_temp, 0700);
        open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading diff-tree failed.");
+       close $fd or die_error(undef, "Reading diff-tree failed");
 
        # try to figure out the next tag after this commit
        my $tagname;
@@ -2251,7 +2251,7 @@ sub git_history {
        my $ftype;
        my %co = git_read_commit($hash_base);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        my $refs = read_info_ref();
        git_header_html();
@@ -2309,14 +2309,14 @@ sub git_history {
 
 sub git_search {
        if (!defined $searchtext) {
-               die_error(undef, "Text field empty.");
+               die_error(undef, "Text field empty");
        }
        if (!defined $hash) {
                $hash = git_read_head($project);
        }
        my %co = git_read_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        # pickaxe may take all resources of your box and run for several minutes
        # with every query - so decide by yourself how public you make this feature :)
@@ -2454,7 +2454,7 @@ sub git_shortlog {
 
        my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
        open my $fd, "-|", $GIT, "rev-list", $limit, $hash
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist = map { chomp; $_ } <$fd>;
        close $fd;
 
@@ -2482,9 +2482,9 @@ ## feeds (RSS, OPML)
 sub git_rss {
        # http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
        open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist = map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-rev-list failed.");
+       close $fd or die_error(undef, "Reading git-rev-list failed");
        print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
        print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
              "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
-- 
1.4.1.1
