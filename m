From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Fri, 14 Sep 2012 09:54:03 -0700
Message-ID: <7vvcfg5yvo.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 18:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZ9r-0001Vc-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 18:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057Ab2INQyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 12:54:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab2INQyH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 12:54:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82CD983A7;
	Fri, 14 Sep 2012 12:54:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j/8NgqBLIZ7y
	byPzrfViv5/Oh5A=; b=f3dWe+B8Zuj1IQPf6XPJM/8H4wsxQqctdVQ/upyHstpx
	7z2ShzEnNQr8KAqwZAabY2MD/sx//vkde9X1S+H5WQ3IYlItN+3WTYFxQiJkLdDb
	h9zSos7wYR1qlnOZKf8r/yX5hiytH/ECVyZ/yxezHHY3oFt5z3fNraRajNgW8sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TN5hYB
	DkSjVS77SXC1OMhEjRpJ5ZBkB60lBtzcptL0JD08/HB8v6v3HKJ1u4HQVXpnZgvh
	d7M1hC8yJyds8pSvFE+Dzc1M8nZDOt4NQPNzYi79olVhaVRjFUTG6yZcTpNJJNFt
	qxuzTTGkyWYqrQ/EQed7Ib0BzEy4TkWv2tPDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FC6383A6;
	Fri, 14 Sep 2012 12:54:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8C9983A5; Fri, 14 Sep 2012
 12:54:05 -0400 (EDT)
In-Reply-To: Junio C. Hamano's message of "Fri\, 14 Sep 2012 09\:35\:37
 -0700"
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB58D772-FE8C-11E1-84EA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205500>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This reverts the i18n part of 7f81463 (Use correct grammar in diffst=
at
>> summary line - 2012-02-01) but still keeps the grammar correctness f=
or
>> English. It also reverts b354f11 (Fix tests under GETTEXT_POISON on
>> diffstat - 2012-08-27). The result is diffstat always in English
>> for all commands.
>>
>> This helps stop users from accidentally sending localized
>> format-patch'd patches.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>

Why am I getting this from t3300?

    --- expected    2012-09-14 16:43:09.000000000 +0000
    +++ current     2012-09-14 16:43:09.000000000 +0000
    @@ -1,2 +1,2 @@
      "tabs\t,\" (dq) and spaces"
    - 1 file changed, 0 insertions(+), 0 deletions(-)
    + 1 files changed, 0 insertion(+), 0 deletion(-)

Ah, your rewrite of Q_() is wrong. Will squash the attached in
before queueing this for maint.

Thanks.

 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/diff.c w/diff.c
index 3ddf0e6..1d9783c 100644
--- c/diff.c
+++ w/diff.c
@@ -1401,7 +1401,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 	}
=20
 	strbuf_addf(&sb,
-		    files ? " %d files changed" : " %d file changed",
+		    (files =3D=3D 1) ? " %d file changed" : " %d files changed",
 		    files);
=20
 	/*
@@ -1418,7 +1418,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    insertions ? ", %d insertions(+)" : ", %d insertion(+)",
+			    (insertions =3D=3D 1) ? ", %d insertion(+)" : ", %d insertions(=
+)",
 			    insertions);
 	}
=20
@@ -1428,7 +1428,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    deletions ? ", %d deletions(-)" : ", %d deletion(-)",
+			    (deletions =3D=3D 1) ? ", %d deletion(-)" : ", %d deletions(-)"=
,
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
