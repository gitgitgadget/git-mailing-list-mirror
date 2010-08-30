From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 13/17] gettext tests: mark a test message as not needing translation
Date: Mon, 30 Aug 2010 21:28:19 +0000
Message-ID: <1283203703-26923-14-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvb-0000N5-5Y
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0H3V3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0H3V3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:12 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wrdoCc5+NNrE1VcJvyAto7xahU6zkOB5DyM7MF+202A=;
        b=tE+fIEd5XuUcFuOD0AxvaAG6gwbQTol4TeLy0zKTqjKJ8jU/SLQIBj5jB765Ada4Tw
         BgeO4ILF/8b/z/AY4fAMnSXZOclFlbNDiqwnE0QFhv6D0C9RJgKATX1fSjdlt4ScPONj
         p6xP7tP8ODKZHhgSZJNFTzoakN3oEWRD1V9OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eYRU4Iky5CYEWS3V4t1ZQm14FMMpKcrmI0tQMlzyZbK74deQuuSZ9zVUo2KgpJNusR
         ok6Zws7soPvtuzX1Fgle8QFkjeWaEVTJCFK1u+JzlagftNdLMRST1DjAhHKR+zNIEqQV
         LE2yxgTphpztgpJXcntHX4sPxP01HPxInUAqQ=
Received: by 10.227.134.69 with SMTP id i5mr5414682wbt.165.1283203751871;
        Mon, 30 Aug 2010 14:29:11 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154857>

This was the only message in t/t0200/* that didn't have a TRANSLATORS
comment, without it translators will waste time translating this
needlessly.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0200/test.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0200/test.c b/t/t0200/test.c
index ff15c2f..584d45c 100644
--- a/t/t0200/test.c
+++ b/t/t0200/test.c
@@ -1,6 +1,7 @@
 /* This is a phony C program that's only here to test xgettext message=
 extraction */
=20
 const char help[] =3D
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
 	N_("See 'git help COMMAND' for more information on a specific command=
=2E");
=20
 int main(void)
--=20
1.7.2.2.536.g3f548
