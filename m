From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: blame porcelain: lineno and orig lineno swapped
Date: Wed, 11 Oct 2006 00:30:05 -0700 (PDT)
Message-ID: <20061011073005.1178.qmail@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 11 09:30:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYXc-0004C1-Um
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWJKHaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWJKHaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:30:09 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:49555 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161005AbWJKHaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:30:07 -0400
Received: (qmail 1181 invoked by uid 60001); 11 Oct 2006 07:30:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RPvXzsmJhxS72y8qjX3wiljFbRlYNRLKjFIflPHufy9wUkrmtgyV66GJJ9inSaAqi41C34cfQ13ncr5EQbm374/TsXtNKP5k85IIiybjTlTvPNXfBSt1tu9talphpq52pIKCsTKhKhYs45E/PlKWRgeIsMaa+YkYSCQA3KkVc00=  ;
Received: from [71.80.233.118] by web31813.mail.mud.yahoo.com via HTTP; Wed, 11 Oct 2006 00:30:05 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28698>

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 77063f0..19f434d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2594,7 +2594,7 @@ HTML
 	while (1) {
 		$_ = <$fd>;
 		last unless defined $_;
-		my ($full_rev, $lineno, $orig_lineno, $group_size) =
+		my ($full_rev, $orig_lineno, $lineno, $group_size) =
 		    /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/;
 		if (!exists $metainfo{$full_rev}) {
 			$metainfo{$full_rev} = {};
-- 
1.4.3.rc2.gacda
