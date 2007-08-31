From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 14/14] gitweb: minor whitespace cleanups
Date: Fri, 31 Aug 2007 13:19:14 +0200
Message-ID: <11885591742917-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591601143-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591653402-git-send-email-giuseppe.bilotta@gmail.com>
 <1188559169764-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4ZH-0002oW-1X
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbXHaLV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXHaLV1
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:21:27 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:31584 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964969AbXHaLVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:21:23 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1069542qbe
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:21:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UyQNofZpRubtNoJa7auO5aBvfWbIkJgaLuLR1nb/LkkBcEB2R6o4sGuqEUYhpjSXSI+0xy4KLzGjSJtEOyxFPaxojA/5lHyizuHdZuSP2BtMFynijXTvfH/ryiK+8hSmi3ZxpPNPmVCI4juSDQnpMPKCZD11q/5qS398RSbV+3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QhxnID2CQ5ChusGrWQDOdqEpyYukG5kPG5ORHXlHZRRNi5WoESZmSE0uk5JpfVfxpEzqAyQoCokGPcoJwp0pE6aJT4ufLGtgdrcencZmclWjyVuMZgQe9RQLdSaCVl06QUn9qazdr1+LZdydnC56fIVrZC0w77BNN0619d+ze8Q=
Received: by 10.64.27.13 with SMTP id a13mr3141978qba.1188559282255;
        Fri, 31 Aug 2007 04:21:22 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id 34sm3837122nfu.2007.08.31.04.21.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:21:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <1188559169764-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57160>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2c8a665..a767763 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2098,11 +2098,11 @@ sub git_get_heads_list {
 		my ($remote_heads) = gitweb_check_feature('remote_heads');
 		@class = ('heads', $remote_heads ? 'remotes' : undef);
 	}
-	my @refs = map { "refs/$_" } @class ;
+	my @refs = map { "refs/$_" } @class;
 	my @headslist;
 
 	if (grep { $_ eq 'heads' } @class) {
-		if (git_is_head_detached()) { ;
+		if (git_is_head_detached()) {
 			my %ref_item;
 			my @x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
 			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
@@ -2449,7 +2449,7 @@ sub git_footer_html {
 		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
 		              -class => "rss_logo"}, "TXT") . "\n";
 	}
-	print "</div>\n" ;
+	print "</div>\n";
 
 	if (-f $site_footer) {
 		open (my $fd, $site_footer);
-- 
1.5.2.5
