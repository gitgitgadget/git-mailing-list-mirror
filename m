From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/5] gettext docs: the Git::I18N Perl interface
Date: Fri, 10 Sep 2010 19:35:53 +0000
Message-ID: <1284147353-18000-6-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Oo-0006Xz-It
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab0IJTgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58786 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IJTgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so3171634wyf.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7xAZKdrVea1A1WJotx8S0nz5jSX/dMkVMck+PkCJ04o=;
        b=cBPpXxai25CymJefcSoxTdlgGO+f1SmhmB4mT+FfV66lLtD4yK+o16TKYuNjRp7Yk2
         fcvAhWW97chDy8FV/K57JosjecOplMBQunxlyuDvRwFcmAas+keWHMcvN5dJm10l7zVG
         bU2WJkKFOuRN51iMRTlqGh9HSr0uaaWexSmlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L+qJnqUaBG7nh9Eb4agNEI59M5RP0Zac3eiqK4HusjMgjD/OD3g+2RIN2R4PeLc6pD
         vdrLQ9rVrdJATHtZ/J5YZfBKh1TdBMEMXSx0NBnSvPNxNilcqV0lu5vLg/9mX76Diaz6
         +LnyVzWCW/AJzNUc4U0VtDwfNfIh88eikMLtw=
Received: by 10.227.134.144 with SMTP id j16mr299279wbt.50.1284147380385;
        Fri, 10 Sep 2010 12:36:20 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.36.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155964>

Change po/README's "Marking strings for translation" section so that
it covers the Git::I18N Perl interface.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/README |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/po/README b/po/README
index 513cf32..0d1cfa0 100644
--- a/po/README
+++ b/po/README
@@ -178,3 +178,14 @@ Shell:
    command to be translated) for examples is also useful:
=20
        git log --reverse -p --grep=3Dgettextize git-am.sh
+
+Perl:
+
+ - The Git::I18N module provides a limited subset of the
+   Locale::Messages functionality, e.g.:
+
+       use Git::I18N;
+       print __("Welcome to Git!\n");
+       printf __("The following error occured: %s\n"), $error;
+
+   Run `perldoc perl/Git/I18N.pm` for more info.
--=20
1.7.2.3.313.gcd15
