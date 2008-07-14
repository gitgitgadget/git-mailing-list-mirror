From: Frederik Schwarzer <schwarzerf@gmail.com>
Subject: [PATCH] typo
Date: Mon, 14 Jul 2008 18:30:24 +0200
Message-ID: <200807141830.24844.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 18:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIQzx-0006Jt-37
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 18:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYGNQdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 12:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbYGNQdA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 12:33:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:28625 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYGNQc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 12:32:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2929973fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Lu0Y/EGt1q7eRMGsQrA4Ex+8VG31yfwFJnATLi9Rl8w=;
        b=IkFw5rlVkHL4pjtovYnm2mMfWVMLPn3ti+dPOG/Sp2cGzLUNkH2dotDPUwy+458cUH
         ZfClXLxpnNlewuA7KsdxsVcjjfgtPLiL/wVlKhN5RGcBqD0ubTLMb+ScimMZbeVygLsG
         8c29VTmuIOnbrSQROpar8Bem1F1zxSjzpt2D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=wneZW2ayB+h69ustCdE+HhzTBlHc6gVmC18sJQShbY7pBTyZKIivBtn8UEXyKZpno5
         Csz+LEes2qoQ4V+R2gOY09jHQn4LallxAguXjduVyihpAt+i9tynPt3JkOFKlIM5/mjJ
         1CeZoXHWXK+5TgjGOE3pTg8ShvB339TkwJmAM=
Received: by 10.86.52.6 with SMTP id z6mr14586438fgz.18.1216053177593;
        Mon, 14 Jul 2008 09:32:57 -0700 (PDT)
Received: from pino.localnet ( [78.54.223.123])
        by mx.google.com with ESMTPS id e11sm7490438fga.4.2008.07.14.09.32.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 09:32:56 -0700 (PDT)
User-Agent: KMail/1.10.0 (Linux/2.6.25-fs; KDE/4.0.85; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88434>

>From ffa0baf13d033b3dc6b49e86ed3de9fb3003ec4e Mon Sep 17 00:00:00 2001
From: Frederik Schwarzer <schwarzerf@gmail.com>
Date: Mon, 14 Jul 2008 18:22:52 +0200
Subject: [PATCH] typo

full stop in the middle of the sentence

Signed-off-by: Frederik Schwarzer <schwarzerf@gmail.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a366c89..8478ca6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4619,7 +4619,7 @@ sub migrate_from_v1 {
 	mkpath([$svn_dir]);
 	print STDERR "Data from a previous version of git-svn exists, but\n\t",
 	             "$svn_dir\n\t(required for this version ",
-	             "($::VERSION) of git-svn) does not. exist\n";
+	             "($::VERSION) of git-svn) does not exist.\n";
 	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
 	while (<$fh>) {
 		my $x = $_;
-- 
1.5.6.2
