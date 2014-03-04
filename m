From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] i18n: proposed command missing leading dash
Date: Tue, 04 Mar 2014 10:40:32 -0800
Message-ID: <xmqqa9d5lsdb.fsf@gitster.dls.corp.google.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jn.avila@free.fr,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKuGg-0002jc-0A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbaCDSkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 13:40:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbaCDSkg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 13:40:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0326FBC0;
	Tue,  4 Mar 2014 13:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Brbho4MRyhzz
	jnrvXB2EdSQyj/k=; b=mVUi3Wu00XudexUwh6YQsipjUWn1KEaaR2vriSaMDGkK
	ReI7AjKs1igllqyN9QWOLGPA/+9eGpsKDtVKGS0h4XOzeECYJ5kaZa/EjLsbKOx5
	96Xg1atpcU3uSKidj/kCyRqquDz/Jh0HsLi3PSd0YZmB6I4cvAIOv037RvHruhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=roOaie
	JvrgSj3AU0xCfQRwAILv27awNT+wprEECXdn1AnhzY4bh0SuzDV+2RvpyWLuXnfZ
	SuhPpoArSWKtc5XKAht0Y7bHp8R90eTipAyWGwMWhlTxHcymh0rnJjrsYQR4MXS7
	Hgf99SxSfrBmqQFrZxVzbuMpr44JV7B8ZV1cU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3ED26FBBF;
	Tue,  4 Mar 2014 13:40:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 290AA6FBBD;
	Tue,  4 Mar 2014 13:40:34 -0500 (EST)
In-Reply-To: <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
	(Sandy Carter's message of "Mon, 3 Mar 2014 09:55:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 788354E6-A3CC-11E3-BEFC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243368>

=46rom: Sandy Carter <sandy.carter@savoirfairelinux.com>
Date: Mon,  3 Mar 2014 09:55:53 -0500

Add missing leading dash to proposed commands in french output when
using the command:
    git branch --set-upstream remotename/branchname
and when upstream is gone

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Forwarding to the i18n coordinator.  I don't do French, but this
   seems trivially correct.

 po/fr.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index e10263f..0b9d59e 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -1075,7 +1075,7 @@ msgstr "Votre branche est bas=C3=A9e sur '%s', ma=
is la branche amont a disparu.\n"
=20
 #: remote.c:1875
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
-msgstr "  (utilisez \"git branch -unset-upstream\" pour corriger)\n"
+msgstr "  (utilisez \"git branch --unset-upstream\" pour corriger)\n"
=20
 #: remote.c:1878
 #, c-format
@@ -3266,7 +3266,7 @@ msgstr "    git branch -d %s\n"
 #: builtin/branch.c:1027
 #, c-format
 msgid "    git branch --set-upstream-to %s\n"
-msgstr "    git branch -set-upstream-to %s\n"
+msgstr "    git branch --set-upstream-to %s\n"
=20
 #: builtin/bundle.c:47
 #, c-format
--=20
1.9.0
