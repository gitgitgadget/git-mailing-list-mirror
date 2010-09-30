From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/16] send-email: file_declares_8bit_cte doesn't need a prototype
Date: Thu, 30 Sep 2010 13:42:58 +0000
Message-ID: <1285854189-10240-6-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQf-00012b-T6
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab0I3Nnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:50 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VhVLQehan9pL6+gkVyslQkkm0brxxBpo9Pwxt6HYsDo=;
        b=Fig49LtjV8HlYPtioaAnogENTfc8Q6NS3qXIZp4Kt2VWje3tsvhU6f+jc2LW4B+EOB
         RndyptZ6LVubILoVLFLNnSWfqwqcf0Mr60mpl7Kht/JoYXHfDVmd4TIC605lUbvfZ+wR
         Z3fodIuErrOoiGL4kUzR2KsI1Euugbtb/9/x4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u5Ow2YWhXxWWTbtnJbYwYLfJnmJwAQlDoAsbo+SETYrIl64XMDCXBXFUUrWlJtuuK5
         1IU3O0Czpnrkaj22QaVdXy+2ua5HUh6p4bpV8AZjab+qAew/wsKtCMVuwrE3JJu++PCw
         SiTA107sAup1YsT6uD23Pj+M23b9TkGYCxiNQ=
Received: by 10.216.87.84 with SMTP id x62mr686352wee.48.1285854229563;
        Thu, 30 Sep 2010 06:43:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157656>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b50c963..f471888 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -679,7 +679,7 @@ sub ask {
=20
 my %broken_encoding;
=20
-sub file_declares_8bit_cte($) {
+sub file_declares_8bit_cte {
 	my $fn =3D shift;
 	open (my $fh, '<', $fn);
 	while (my $line =3D <$fh>) {
--=20
1.7.3.159.g610493
