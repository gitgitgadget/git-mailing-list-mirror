From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/16] send-email: unique_email_list doesn't need a prototype
Date: Thu, 30 Sep 2010 13:42:59 +0000
Message-ID: <1285854189-10240-7-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQg-00012b-FE
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab0I3Nnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:53 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=trTLu/pQY2gNzkGX/xMG7DIt5Eo45l53TsguVv5je64=;
        b=QIAXr97C29ZOI9DsnNiDdKqIWymalYnR1Jl94NB2x/6JExw38WNuiTInz4eGFmo1P+
         6y1g7Dkj7PS9bZr/i4pLyGeYBLfqbcJpx5BkPUs2+5WgkGLIjiLnrFPd1tDcPVpqpAZa
         CnPde/7TAR8E7dRyuEe6hqI4sK2NpbaQzXDIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qxJkRsWQsJlj8DGxbSWyrgNiwifQ2Dm2t8vxr1/8lE+WhxjkqnEoW4hUKynUbRx0T3
         Wj8xckHyMkSC1vMMTsxLQanbhBshWKHZXF3fklPoUpnbrg9WSVeWVsb77KbDvWKIX98Y
         4JymQHEM6+7bssgp7vUjon4+r7QC0v4qfBemQ=
Received: by 10.216.93.73 with SMTP id k51mr3004022wef.8.1285854232645;
        Thu, 30 Sep 2010 06:43:52 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157657>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f471888..90b777a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -136,7 +136,6 @@ my $have_mail_address =3D eval { require Mail::Addr=
ess; 1 };
 my $smtp;
 my $auth;
=20
-sub unique_email_list(@);
 sub cleanup_compose_files();
=20
 # Variables we fill in automatically, or via prompting:
@@ -1332,7 +1331,7 @@ sub cleanup_compose_files() {
=20
 $smtp->quit if $smtp;
=20
-sub unique_email_list(@) {
+sub unique_email_list {
 	my %seen;
 	my @emails;
=20
--=20
1.7.3.159.g610493
