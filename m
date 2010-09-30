From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/16] send-email: get_patch_subject doesn't need a prototype
Date: Thu, 30 Sep 2010 13:42:57 +0000
Message-ID: <1285854189-10240-5-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQf-00012b-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab0I3Nns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:47 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TMs4ZCYXAK5U4Kj/AQGXa4inXKnpVK7awgr+rASodpw=;
        b=mKBMxxRwQMa7NM4N/S50RiL1WYvX0dnWHc70IPV3W8d018k/LHSEBWB9kcYBquMJue
         eHQOL9qsAipP2oBjp33BWVTSpoAdBVBl19s5f8LcoduPB8gIa0WbJjr7vrFJt+Q5ldK0
         GPA6dy96jG4sv6Wj4W8x1gpaA27Wp+IQ/2BCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kkJe+GtK5Lv/QVz9rr9+H7G+leIRML/LUY0gicSIQD6Skd71NpSh4giiT9BdUbDrNl
         zlpH1OVOlCjvyp18LML9CdVk03VYm6n6zNgbcbmhRi+uL9gpamowDX1tEhCD2157q3uy
         +hKngD7SSBVxCmdbNbpFnGZ9tr/HAyYrlZnc4=
Received: by 10.216.231.97 with SMTP id k75mr3057820weq.4.1285854226965;
        Thu, 30 Sep 2010 06:43:46 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157655>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 488d894..b50c963 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -549,7 +549,7 @@ if (@files) {
 	usage();
 }
=20
-sub get_patch_subject($) {
+sub get_patch_subject {
 	my $fn =3D shift;
 	open (my $fh, '<', $fn);
 	while (my $line =3D <$fh>) {
--=20
1.7.3.159.g610493
