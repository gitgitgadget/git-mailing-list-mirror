From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/6] gitweb: Remove unused parse_date invocation from git_shortlog_body
Date: Sun, 6 Aug 2006 02:13:04 +0200
Message-ID: <200608060213.04199.jnareb@gmail.com>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WJr-0003ZT-TC
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWHFAQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHFAQg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:43057 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751445AbWHFAQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:34 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40347nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NH6SsH8jhWlIX5UaDhcQr0TMrnbfvicv6UPREkVdy9sr9oUBYtRAmAjGFd8movmcMHIEyGNr0CGt16MV3U3dtlz9F4B/8iuR6ykKsH7sTWbtBsaxNCZ0C/FKyKM7FEvVz4068q1szBIraYVVKHN0shlMZyMrv8wCu64Lvp0SDRo=
Received: by 10.49.94.20 with SMTP id w20mr6993546nfl;
        Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.32;
        Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24944>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Remainder from refactoring

 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b72f12f..cdce481 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1077,7 +1077,6 @@ sub git_shortlog_body {
 		#my $ref = defined $refs ? format_mark_referencing($refs, $commit) : '';
 		my $ref = format_mark_referencing($refs, $commit);
 		my %co = parse_commit($commit);
-		my %ad = parse_date($co{'author_epoch'});
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
-- 
1.4.1.1
