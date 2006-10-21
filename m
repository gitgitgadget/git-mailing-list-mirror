From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sat, 21 Oct 2006 17:52:19 +0200
Message-ID: <200610211752.19891.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 17:55:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJBe-0004Tu-MW
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993122AbWJUPzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993120AbWJUPy7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:54:59 -0400
Received: from hu-out-0506.google.com ([72.14.214.239]:48549 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993116AbWJUPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:54:56 -0400
Received: by hu-out-0506.google.com with SMTP id 28so571720hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ff+NR7GvpoxsLsqx5ikxPQCi8MaIQSOGhx890vGX6y4fQZFlA1rLLnqm5uHZebu4RL4MNoRrLLconH/StRSQxC79s+37RK9mFBrg5ghVKSv1liFIp17Ll7cFn3YJDM1KlHabdCzFKXjIVJc0HAMCDw6ZVKPT9mxI9GfeKwUFSXY=
Received: by 10.67.97.7 with SMTP id z7mr3948308ugl;
        Sat, 21 Oct 2006 08:54:53 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2762273uge.2006.10.21.08.54.53;
        Sat, 21 Oct 2006 08:54:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610211750.49188.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29624>

Code should be aligned the same way, regardless of tab size.
Use tabs for indent, but spaces for align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   60 ++++++++++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 035e85e..c457884 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1722,13 +1722,13 @@ sub git_print_tree_entry {
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-					       file_name=>"$basedir$t->{'name'}", %base_key),
-				 -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
+			                       file_name=>"$basedir$t->{'name'}", %base_key),
+			        -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
 		print "<td class=\"link\">";
 		if ($have_blame) {
 			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
-						     file_name=>"$basedir$t->{'name'}", %base_key)},
-				      "blame");
+				                           file_name=>"$basedir$t->{'name'}", %base_key)},
+				            "blame");
 		}
 		if (defined $hash_base) {
 			if ($have_blame) {
@@ -1740,8 +1740,8 @@ sub git_print_tree_entry {
 		}
 		print " | " .
 			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
-					       file_name=>"$basedir$t->{'name'}")},
-				"raw");
+			                       file_name=>"$basedir$t->{'name'}")},
+			        "raw");
 		print "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
@@ -1809,7 +1809,7 @@ sub git_difftree_body {
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'}),
-				       -class => "list"}, esc_html($diff{'file'}));
+			              -class => "list"}, esc_html($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
 			print "<td class=\"link\">";
@@ -1836,11 +1836,11 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-						     file_name=>$diff{'file'})},
-				      "blame") . " | ";
+			                             file_name=>$diff{'file'})},
+			              "blame") . " | ";
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-						     file_name=>$diff{'file'})},
-				      "history");
+			                             file_name=>$diff{'file'})},
+			              "history");
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "M" || $diff{'status'} eq "T") { # modified, or type changed
@@ -1861,8 +1861,8 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-						     hash_base=>$hash, file_name=>$diff{'file'}),
-				       -class => "list"}, esc_html($diff{'file'}));
+			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			              -class => "list"}, esc_html($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
 			print "<td class=\"link\">";
@@ -1873,19 +1873,19 @@ sub git_difftree_body {
 					print $cgi->a({-href => "#patch$patchno"}, "patch");
 				} else {
 					print $cgi->a({-href => href(action=>"blobdiff",
-								     hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-								     hash_base=>$hash, hash_parent_base=>$parent,
-								     file_name=>$diff{'file'})},
-						      "diff");
+					                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                             hash_base=>$hash, hash_parent_base=>$parent,
+					                             file_name=>$diff{'file'})},
+					              "diff");
 				}
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-						     file_name=>$diff{'file'})},
-				      "blame") . " | ";
+			                             file_name=>$diff{'file'})},
+			              "blame") . " | ";
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-						     file_name=>$diff{'file'})},
-				      "history");
+			                             file_name=>$diff{'file'})},
+			              "history");
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "R" || $diff{'status'} eq "C") { # renamed or copied
@@ -1913,19 +1913,19 @@ sub git_difftree_body {
 					print $cgi->a({-href => "#patch$patchno"}, "patch");
 				} else {
 					print $cgi->a({-href => href(action=>"blobdiff",
-								     hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-								     hash_base=>$hash, hash_parent_base=>$parent,
-								     file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
-						      "diff");
+					                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+					                             hash_base=>$hash, hash_parent_base=>$parent,
+					                             file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+					              "diff");
 				}
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-						     file_name=>$diff{'from_file'})},
-				      "blame") . " | ";
+			                             file_name=>$diff{'from_file'})},
+			              "blame") . " | ";
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-						     file_name=>$diff{'from_file'})},
-				      "history");
+			                            file_name=>$diff{'from_file'})},
+			              "history");
 			print "</td>\n";
 
 		} # we should not encounter Unmerged (U) or Unknown (X) status
@@ -2851,7 +2851,7 @@ sub git_tree {
 			# FIXME: Should be available when we have no hash base as well.
 			push @views_nav,
 				$cgi->a({-href => href(action=>"snapshot", hash=>$hash)},
-					"snapshot");
+				        "snapshot");
 		}
 		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
-- 
1.4.2.1
