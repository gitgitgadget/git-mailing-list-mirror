From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 42/73] gettextize: git-merge "You have not concluded your merge" messages
Date: Tue, 22 Feb 2011 23:42:01 +0000
Message-ID: <1298418152-27789-43-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wu-0001H8-GK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1BVXqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:47 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51718 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab1BVXqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:46:44 -0500
Received: by bwz10 with SMTP id 10so3868774bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gwHqaBhKWTw7b3j76MrVb8faEHy5lwp8dp3tLs6aSLU=;
        b=qhArpqwJSFLMHfI/tBWNjNxR6uG7HzSE4BC1MDz/bXpbZFXBnQOoKLvrMrjSSsmOY5
         +L4zaCowxaBOBKh5Px1uI+e5Wm/mcYFEIQl7d2xD6ZeafYgmeNy3xKbRt9+5dI0FewSC
         lJAKeXgEZZGGfXJD+W5tlZLEaMRQ1bU7OCJRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H8ix0vaVuycb0XogMqgNlZvo2CX80u2+aOzvS+FHilLzxdB8cPjmlaH+YZOcCgvO2H
         KusoAtzboKx4MkSKVDoci6NLOnba/KU06dA44un49KRpCFWCDeYdcvgZ3IJXSZ7MYeF2
         QMsYUjqC1N3H/BAR4ilWOVxt+jdBrktVYPP3w=
Received: by 10.204.52.138 with SMTP id i10mr3066762bkg.23.1298418254359;
        Tue, 22 Feb 2011 15:44:14 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.13
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:13 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167650>

Gettextize the "You have not concluded your merge messages. A test in
t3030-merge-recursive.sh explicitly checked for this message. Change
it to skip the test under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3030-merge-recursive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 34794f8..806fdcc 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -312,7 +312,7 @@ test_expect_success 'merge-recursive result' '
=20
 '
=20
-test_expect_success 'fail if the index has unresolved entries' '
+test_expect_success C_LOCALE_OUTPUT 'fail if the index has unresolved =
entries' '
=20
 	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
--=20
1.7.2.3
