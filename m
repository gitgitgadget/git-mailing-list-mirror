From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 3/3] gitweb: align comments to code
Date: Sat, 31 Jan 2009 02:31:52 +0100
Message-ID: <1233365512-7130-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1233365512-7130-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1233365512-7130-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 02:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4jk-0000Os-Uj
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbZAaBb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbZAaBb4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:31:56 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:59555 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbZAaBbz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:31:55 -0500
Received: by fxm13 with SMTP id 13so525091fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=feJfk4dnHqCeosQT+8+hsUeYf5es7agyBqrOr+rLXCQ=;
        b=Jamr8SV5ZBPAk4ROJNmizcSrN34duVgphn5Z/Xt2KQCbujpaxZXQupvcbffkJssbe3
         HY3y8xaCJWpe9Y/Vik6NPaDaqH218QCmK5g9I74EtHKuNNo7Uk4UutPDO1XfftxC252Y
         yN/LTtX0W5MNIB8d7oEJvEihf63A8I3xoqUGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q+EIlwajM+Yd1IF8K4AplGuyt1HRoIOy3u9tVUnQw9E1wwLeo6OC37tjojpbCjtkHJ
         0TdhU6O0C95IJePEawla8dUl0s9fSKm3Bxq8i88NCLIpEtNZ8Nv+LQKQ/ZHFhBqi6aCn
         uUQv8Pcf354eeRnuCxid1VUvV2lCPOqaabNY4=
Received: by 10.181.156.12 with SMTP id i12mr640625bko.140.1233365512849;
        Fri, 30 Jan 2009 17:31:52 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id g28sm2067333fkg.38.2009.01.30.17.31.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 17:31:52 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1233365512-7130-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107900>

---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 538bd5a..c5f0130 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,14 +2901,14 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
-# the stylesheet, favicon etc urls won't work correctly with path_info unless we
-# set the appropriate base URL
+	# the stylesheet, favicon etc urls won't work correctly with path_info
+	# unless we set the appropriate base URL
 	if ($ENV{'PATH_INFO'}) {
 		print '<base href="'.esc_url($my_url).'" />\n';
 	}
-# print out each stylesheet that exist
+	# print out each stylesheet that exist, providing backwards capability
+	# for those people who defined $stylesheet in a config file
 	if (defined $stylesheet) {
-#provides backwards capability for those people who define style sheet in a config file
 		print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
 	} else {
 		foreach my $stylesheet (@stylesheets) {
-- 
1.5.6.5
