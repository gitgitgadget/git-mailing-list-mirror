From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Wed, 01 Feb 2012 13:26:43 -0800
Message-ID: <7vhaza2qjw.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Dickey <dickey@his.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 22:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rshhb-0007r1-3D
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab2BAV0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 16:26:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab2BAV0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 16:26:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C1FC5B9C;
	Wed,  1 Feb 2012 16:26:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wzUTGiN451RP
	4bBgcaQ1S3rWwVI=; b=OanaOCAY6W6efvXnpBJWxb1GhKSJAasbJ4xSP1d8xFdK
	TDs72iLZTplIFE6Ia6md4IL553p5vqMTKhADB8deJszFj76/X6Mp3TiJ1EHfESi9
	39covrdiTw7spG29NqwR4KA5ak7IX63yza4jRjrxoV1L20La49t/0saOScHUFQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xghc+1
	v2UBRGITF6C09SUWPEuXPbSQRqXpvg7gv5IwFbMxtpJ1+VMzIQwAeQdsJkYgFGqr
	6mWXCyX3aNrwsz1GdfGU8vhxjOT+TyjYY4xUvSVHjXIY//erJ7gOLg7qxL54i66R
	t9+1egjyGX63ehaVlKK9d+mIUic74absjf3oM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 619425B9B;
	Wed,  1 Feb 2012 16:26:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCBDC5B96; Wed,  1 Feb 2012
 16:26:44 -0500 (EST)
In-Reply-To: <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 1 Feb
 2012 19:55:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70C8A512-4D1B-11E1-9ED9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189538>

Nice.  Will queue with a minor update to the log message:

commit 3f29ab34372ee11946439da3bde307eb90ad9031
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Wed Feb 1 19:55:07 2012 +0700

    Use correct grammar in diffstat summary line
   =20
    "git diff --stat" and "git apply --stat" now learn to print the lin=
e
    "%d files changed, %d insertions(+), %d deletions(-)" in singular f=
orm
    whenever applicable. "0 insertions" and "0 deletions" are also omit=
ted
    unless they are both zero.
   =20
    This matches how versions of "diffstat" that are not prehistoric pr=
oduced
    their output, and also makes this line translatable.
   =20
    [jc: with help from Thomas Dickey in archaeology of "diffstat"]
   =20
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

And also this bit on top:

diff --git a/diff.c b/diff.c
index 5c31b36..5f3ce97 100644
--- a/diff.c
+++ b/diff.c
@@ -1329,7 +1329,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
=20
 	if (!files) {
 		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fputs(_(" no changes\n"), fp);
+		return fputs(_(" 0 files changed\n"), fp);
 	}
=20
 	strbuf_addf(&sb,
