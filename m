From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (3)
Date: Sun, 1 Apr 2007 22:21:38 +0200
Message-ID: <200704012221.39055.jnareb@gmail.com>
References: <200704012221.01676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 00:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY8xq-0004B4-Pa
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 00:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXDAWzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbXDAWzi
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 18:55:38 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:35089 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbXDAWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 18:55:22 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1163628muf
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 15:55:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H7ATV1FI6ricT6ItifU6ZiYM+PhdM1aPix5V5GiGAwxFon2er8u/hSqUWjYtIj10AHI0/wLieZUUQYeP8wplmmA1sg3+l0z/qdeDV7SFZhA+sNqkWmi5g5oFDr8L+3rT/o/kQGjnhueMmIJY75Otd0W1rC+dU8lWklTzVjU4CD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iKd5bR/bgsQ3jcqs+OzqDCQZ8bAgejCcr1RXwOLb4kbG5l2GD4lbcbvPnuO2URK0E0Mgl+x0wV9lSC2XPcr42UCYeSs5TxizogyaPk7B0W8dlVOK2JoKCh7ki/ZoAOr4Q40TiniazOFwQShSOeFbvt54oVLTln5CmHpKTHyxr7U=
Received: by 10.82.138.6 with SMTP id l6mr7141669bud.1175468120091;
        Sun, 01 Apr 2007 15:55:20 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm17434124mue.2007.04.01.15.55.18;
        Sun, 01 Apr 2007 15:55:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200704012221.01676.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43595>

Code should be look the same way, regardless of tab size.
Use tabs for indent, but spaces for align.

Indent continued part of command spanning multiple lines, but only once.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d1f4aeb..5c49056 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1800,7 +1800,7 @@ EOF
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
+		                       -values => ['commit', 'author', 'committer', 'pickaxe']) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
@@ -3097,7 +3097,7 @@ sub git_summary {
 		git_project_list_body(\@forklist, undef, 0, 15,
 		                      $#forklist <= 15 ? undef :
 		                      $cgi->a({-href => href(action=>"forks")}, "..."),
-				      'noheader');
+		                      'noheader');
 	}
 
 	git_footer_html();
@@ -3204,7 +3204,7 @@ HTML
 		my $rev = substr($full_rev, 0, 8);
 		my $author = $meta->{'author'};
 		my %date = parse_date($meta->{'author-time'},
-				      $meta->{'author-tz'});
+		                      $meta->{'author-tz'});
 		my $date = $date{'iso-tz'};
 		if ($group_size) {
 			$current_color = ++$current_color % $num_colors;
@@ -3216,9 +3216,9 @@ HTML
 			print " rowspan=\"$group_size\"" if ($group_size > 1);
 			print ">";
 			print $cgi->a({-href => href(action=>"commit",
-						     hash=>$full_rev,
-						     file_name=>$file_name)},
-				      esc_html($rev));
+			                             hash=>$full_rev,
+			                             file_name=>$file_name)},
+			              esc_html($rev));
 			print "</td>\n";
 		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
@@ -3227,13 +3227,13 @@ HTML
 		close $dd;
 		chomp($parent_commit);
 		my $blamed = href(action => 'blame',
-				  file_name => $meta->{'filename'},
-				  hash_base => $parent_commit);
+		                  file_name => $meta->{'filename'},
+		                  hash_base => $parent_commit);
 		print "<td class=\"linenr\">";
 		print $cgi->a({ -href => "$blamed#l$orig_lineno",
-				-id => "l$lineno",
-				-class => "linenr" },
-			      esc_html($lineno));
+		                -id => "l$lineno",
+		                -class => "linenr" },
+		              esc_html($lineno));
 		print "</td>";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
@@ -3623,7 +3623,7 @@ sub git_snapshot {
 	my $name = $project;
 	$name =~ s/\047/\047\\\047\047/g;
 	open my $fd, "-|",
-	"$git archive --format=tar --prefix=\'$name\'/ $hash | $command"
+		"$git archive --format=tar --prefix=\'$name\'/ $hash | $command"
 		or die_error(undef, "Execute git-tar-tree failed");
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -3736,7 +3736,7 @@ sub git_commit {
 		# difftree output is not printed for merges
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
 			@diff_opts, $parent, $hash, "--"
-				or die_error(undef, "Open git-diff-tree failed");
+			or die_error(undef, "Open git-diff-tree failed");
 		@difftree = map { chomp; $_ } <$fd>;
 		close $fd or die_error(undef, "Reading git-diff-tree failed");
 	}
@@ -4308,13 +4308,13 @@ sub git_search {
 		if ($page > 0) {
 			$paging_nav .=
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-						       searchtext=>$searchtext, searchtype=>$searchtype)},
-					"first");
+				                       searchtext=>$searchtext, searchtype=>$searchtype)},
+				        "first");
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-						       searchtext=>$searchtext, searchtype=>$searchtype,
-						       page=>$page-1),
-					 -accesskey => "p", -title => "Alt-p"}, "prev");
+				                       searchtext=>$searchtext, searchtype=>$searchtype,
+				                       page=>$page-1),
+				         -accesskey => "p", -title => "Alt-p"}, "prev");
 		} else {
 			$paging_nav .= "first";
 			$paging_nav .= " &sdot; prev";
@@ -4322,9 +4322,9 @@ sub git_search {
 		if ($#commitlist >= 100) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-						       searchtext=>$searchtext, searchtype=>$searchtype,
-						       page=>$page+1),
-					 -accesskey => "n", -title => "Alt-n"}, "next");
+				                       searchtext=>$searchtext, searchtype=>$searchtype,
+				                       page=>$page+1),
+				         -accesskey => "n", -title => "Alt-n"}, "next");
 		} else {
 			$paging_nav .= " &sdot; next";
 		}
@@ -4332,9 +4332,9 @@ sub git_search {
 		if ($#commitlist >= 100) {
 			$next_link =
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-						       searchtext=>$searchtext, searchtype=>$searchtype,
-						       page=>$page+1),
-					 -accesskey => "n", -title => "Alt-n"}, "next");
+				                       searchtext=>$searchtext, searchtype=>$searchtype,
+				                       page=>$page+1),
+				         -accesskey => "n", -title => "Alt-n"}, "next");
 		}
 
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
-- 
1.5.0.5
