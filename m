From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: style fix for 9f93e46 (git-clean: use a git-add-interactive ...)
Date: Tue, 06 Jan 2015 11:17:33 -0800
Message-ID: <xmqq4ms3pvle.fsf@gitster.dls.corp.google.com>
References: <1420464563-5579-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8ZdP-0006Se-T4
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbbAFTRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2015 14:17:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755940AbbAFTRg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2015 14:17:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19A902D0BA;
	Tue,  6 Jan 2015 14:17:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BlccYYEeJdkk
	pv/P2Y9lu0sQrbU=; b=mgNrSg7zJLPnSdSzF0OKS7ilVoMjeTHB+PrlOjJ3tMti
	HEYiMBZKWH4I2sS3UMeodm3XqJMtwkfoeKaspJVni6p5x7ObSVfRiE06Amh8+s2g
	ZHIZX5m75R2Ck/5X1rkYPJpOhsgT4vzcfMIjaOmxYDLb2gfd4SEUZEemnose7aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rag+Bg
	/pTwuC40QIKibVu1fLaoZbdkz4HIBTiU/ZdwM5jhL6Knxa6jCKpIgSI4X5JaxMzv
	CCfKBwbGzse3DdSFew9172L0FtloXWMwzgYe3JdKpWsNGIp2jDyc2IYxk8lIS2UF
	Q18DzZTf/nsg5zhIliJz9AL/0dbqIFtonVjFA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F2952D0B9;
	Tue,  6 Jan 2015 14:17:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84EB02D0B7;
	Tue,  6 Jan 2015 14:17:35 -0500 (EST)
In-Reply-To: <1420464563-5579-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 5 Jan
 2015 20:29:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ABC96922-95D8-11E4-A9D8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262091>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -	int (*fn)();
> +	int (*fn)(void);

This is an independent fix that has already been merged to 'maint',
but to any topic that forked before the merge happened I need to
apply the fix without committing it when I test it in isolation, and
I screwed up when I did that SQUASH??? in question by running a
casual "commit -a" (or perhaps "add -u").  My bad.

When your series (with the squash) is merged to any integration
branch, this hunk becomes redundant, so I'd remove it from the
SQUASH???

When I do a SQUASH???, I expect the original authors use it as a
hint in their rerolls, but because this series has seen no comments
so far (no interests???), I do not foresee or expect you to feel a
need for rerolling at this point.  If you agree that the remainder
of the SQUASH??? (shown below) is sensible, I'll turn it into a
"fixup!" for cc44d4fe (untracked cache: load from UNTR index
extension, 2014-12-08) and requeue.

Thanks for catching my mistake before it gets too old.

 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index ef58547..95ff3f0 100644
--- a/dir.c
+++ b/dir.c
@@ -2459,7 +2459,7 @@ struct untracked_cache *read_untracked_extension(=
const void *data, unsigned long
 	const struct ondisk_untracked_cache *ouc;
 	struct untracked_cache *uc;
 	struct read_data rd;
-	const unsigned char *next =3D data, *end =3D data + sz;
+	const unsigned char *next =3D data, *end =3D (const unsigned char *)d=
ata + sz;
 	struct strbuf sb =3D STRBUF_INIT;
 	int len;
=20
