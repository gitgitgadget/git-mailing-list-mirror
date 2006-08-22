From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: all bold lists are "list_bold" style
Date: Tue, 22 Aug 2006 01:57:39 -0700 (PDT)
Message-ID: <20060822085739.75519.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1320975009-1156237059=:71989"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 22 10:57:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFS4u-0006Ah-3r
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWHVI5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWHVI5l
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:57:41 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:53414 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932145AbWHVI5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 04:57:40 -0400
Received: (qmail 75521 invoked by uid 60001); 22 Aug 2006 08:57:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=spsgrCvandGmpE7R9l5r3AkegjanbR4irfE45L+1VMPmQNqp7pvkxOMvDAuyGEzBLmKYyb7yp0ZsRZuLbvYsC7uSpVwf8Htll6w7KJ3Oqv7d6l0qjSOkE9m9p56lQObf0rewXyTTt4+vZdcdtR8RWPAA0alnGgQN4OH48K63//M=  ;
Received: from [71.84.29.50] by web31810.mail.mud.yahoo.com via HTTP; Tue, 22 Aug 2006 01:57:39 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25843>

--0-1320975009-1156237059=:71989
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--0-1320975009-1156237059=:71989
Content-Type: text/inline; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: name="p1.txt"; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5237f25..4caf69e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1583,7 +1583,7 @@ sub git_tags_body {
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'}),
-		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		               -class => "list_bold"}, esc_html($tag{'name'})) .
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
@@ -1637,7 +1637,7 @@ sub git_heads_body {
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      ($tag{'id'} eq $head ? "<td class=\"current_head\">" : "<td>") .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'}),
-		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		               -class => "list_bold"}, esc_html($tag{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . " | " .
@@ -2686,7 +2686,7 @@ sub git_search {
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 			      "<td>" .
-			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}) -class => "list"}, "<b>" . esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}) -class => "list_bold"}, esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 			my $comment = $co{'comment'};
 			foreach my $line (@$comment) {
 				if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
@@ -2739,8 +2739,8 @@ sub git_search {
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 					      "<td>" .
-					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list"}, "<b>" .
-					      esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
+					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list_bold"},
+					      esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 					while (my $setref = shift @files) {
 						my %set = %$setref;
 						print $cgi->a({-href => href(action=>"blob", hash=>$set{'id'}, hash_base=>$co{'id'}, file_name=>$set{'file'}), class => "list"},
-- 
1.4.2.g3851f

--0-1320975009-1156237059=:71989--
