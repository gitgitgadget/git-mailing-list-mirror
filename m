From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1] gitweb: whitespace cleanup
Date: Sat, 29 Jul 2006 22:43:40 +0200
Message-ID: <200607292243.41264.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 29 22:43:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6vel-0006Fx-JO
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWG2Un2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWG2Un2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 16:43:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:32144 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932229AbWG2Un1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 16:43:27 -0400
Received: by ug-out-1314.google.com with SMTP id m3so206133ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 13:43:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=upvWUa1ualTt19882ITvISn4m350iwGhbq8RYF9iRArIXcu+Hw/E9YPz0PiGmSHHEvw31hPp/VB98ZvB14pVgKOAP1Gajtge6kfdySQVsgy5TdFc1Acu0JGJACWoGYMdiwj73Hd7GclkxnM0z07A0RZqFcEbI0oT2JMjtPUqgP8=
Received: by 10.67.100.12 with SMTP id c12mr982638ugm;
        Sat, 29 Jul 2006 13:43:26 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id m1sm3065982ugc.2006.07.29.13.43.25;
        Sat, 29 Jul 2006 13:43:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24433>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Use tab for indenting commands, spaces for align
(because the fact that some elements are aligned 
should not depend on the tab width).

 gitweb/gitweb.cgi |   58 +++++++++++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e5fca63..f92eeab 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -36,7 +36,7 @@ our $git_version = qx($GIT --version) =~
 # location for temporary files needed for diffs
 our $git_temp = "/tmp/gitweb";
 if (! -d $git_temp) {
-    mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
+	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
 }
 
 # target of the home link on top of all pages
@@ -104,7 +104,7 @@ if (defined $project) {
 		die_error(undef, "No such project.");
 	}
 	$rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
-		    "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
+	            "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
 } else {
 	git_project_list();
@@ -303,7 +303,7 @@ sub git_header_html {
 	} else {
 		$content_type = 'text/html';
 	}
-	print $cgi->header(-type=>$content_type,  -charset => 'utf-8', -status=> $status, -expires => $expires);
+	print $cgi->header(-type=>$content_type, -charset => 'utf-8', -status=> $status, -expires => $expires);
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -1138,17 +1138,17 @@ sub git_summary {
 				      "</td>\n" .
 				      "<td>";
 				if (defined($comment)) {
-				      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, esc_html($comment));
+					print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, esc_html($comment));
 				}
 				print "</td>\n" .
 				      "<td class=\"link\">";
 				if ($tag{'type'} eq "tag") {
-				      print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
+					print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
 				}
 				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
 				if ($tag{'reftype'} eq "commit") {
-				      print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-					    " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+					print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
+					      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
 				}
 				print "</td>\n" .
 				      "</tr>";
@@ -1457,17 +1457,17 @@ sub git_tags {
 			      "</td>\n" .
 			      "<td>";
 			if (defined($comment)) {
-			      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+				print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
 			}
 			print "</td>\n" .
 			      "<td class=\"link\">";
 			if ($tag{'type'} eq "tag") {
-			      print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
 			}
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
 			if ($tag{'reftype'} eq "commit") {
-			      print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-				    " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
+				      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
 			}
 			print "</td>\n" .
 			      "</tr>";
@@ -1613,13 +1613,14 @@ sub git_blob_plain_mimetype {
 
 sub git_blob_plain {
 	if (!defined $hash) {
-                if (defined $file_name) {
-                        my $base = $hash_base || git_read_head($project);
-                        $hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
-                } else {
-                        die_error(undef, "No file name defined.");
-                }
-        }
+		if (defined $file_name) {
+			my $base = $hash_base || git_read_head($project);
+			$hash = git_get_hash_by_path($base, $file_name, "blob") 
+				or die_error(undef, "Error lookup file.");
+		} else {
+			die_error(undef, "No file name defined.");
+		}
+	}
 	my $type = shift;
 	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
 
@@ -1644,13 +1645,14 @@ sub git_blob_plain {
 
 sub git_blob {
 	if (!defined $hash) {
-                if (defined $file_name) {
-                        my $base = $hash_base || git_read_head($project);
-                        $hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
-                } else {
-                        die_error(undef, "No file name defined.");
-                }
-        }
+		if (defined $file_name) {
+			my $base = $hash_base || git_read_head($project);
+			$hash = git_get_hash_by_path($base, $file_name, "blob") 
+				or die_error(undef, "Error lookup file.");
+		} else {
+			die_error(undef, "No file name defined.");
+		}
+	}
 	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error(undef, "Open failed.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
@@ -1677,7 +1679,7 @@ sub git_blob {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain") . "<br/>\n";
 		}
 		print "</div>\n".
-		       "<div>" .
+		      "<div>" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
 		      "</div>\n";
 	} else {
@@ -2305,7 +2307,7 @@ sub git_commitdiff {
 		my $status = $5;
 		my $file = validate_input(unquote($6));
 		if ($status eq "A") {
-			print "<div class=\"diff_info\">" .  file_type($to_mode) . ":" .
+			print "<div class=\"diff_info\">" . file_type($to_mode) . ":" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, $to_id) . "(new)" .
 			      "</div>\n";
 			git_diff_print(undef, "/dev/null", $to_id, "b/$file");
@@ -2359,7 +2361,7 @@ sub git_commitdiff_plain {
 	      "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n".
 	      "Subject: $co{'title'}\n";
 	if (defined $tagname) {
-	      print "X-Git-Tag: $tagname\n";
+		print "X-Git-Tag: $tagname\n";
 	}
 	print "X-Git-Url: $my_url?p=$project;a=commitdiff;h=$hash\n" .
 	      "\n";
-- 
1.4.0
