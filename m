From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Tue, 10 May 2016 13:23:29 -0700
Message-ID: <xmqqbn4doe66.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
	<20160427101833.GA5536@lanh>
	<xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
	<20160501002852.GA3963@lanh> <20160501060009.GA30748@lanh>
	<xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
	<CACsJy8DtFLkfqSHRjFU4N9H9C3MfVOn-XEy4yOwneQaatvvDkQ@mail.gmail.com>
	<xmqqposvxlpb.fsf@gitster.mtv.corp.google.com>
	<20160510115856.GA1964@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:23:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EBu-0001tA-QS
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbcEJUXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 16:23:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752063AbcEJUXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 16:23:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68DC3197FE;
	Tue, 10 May 2016 16:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q8A6Xy3pOlkM
	8dTo0BVJPZ3kQoQ=; b=uaFmutfYO8wfVNP3MlPcY+YZpvXGlEMo+yqgeptRjoQZ
	ZnImWoaZ765yixTGVa7iIB85wCJoauCJ9RRdNLuwO8MmdB02FKSzfUJ2XHi3UdbW
	CZTcjXpgkwS7PIOm9rB5y4aDUUbYk/EY0UtGF+FHHXVT4R8bptb1nBdvctnSWPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AAIycW
	vW0m7D3OjrbVg/Toz3Eo+mwEvpxknoJ1KdkMxGfRc7q/yOSoEuvkxJRcnKxF5mzR
	OVDdwnp2h485ACHMzHePJ9XqRgSUV1CXu9y+m6c/zktcW9VTW0ChU0C+cKY+hi9X
	2dGfx9miJ7JMJauN4ZdH79Q/rFkdvnxDQ8lOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E958197FD;
	Tue, 10 May 2016 16:23:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC528197FC;
	Tue, 10 May 2016 16:23:31 -0400 (EDT)
In-Reply-To: <20160510115856.GA1964@lanh> (Duy Nguyen's message of "Tue, 10
	May 2016 18:58:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 105FB2EC-16ED-11E6-A3FD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294184>

Duy Nguyen <pclouds@gmail.com> writes:

> Or a simpler, more-to-the-point patch like this?

I am OK with that, even though I find it a bit too "cute" for my
taste.



> -- 8< --
> Subject: [PATCH] wrap-for-bin.sh: regenerate bin-wrappers when switch=
ing branches
>
> Commit e6e7530 (test helpers: move test-* to t/helper/ subdirectory -
> 2016-04-13) moves test-* to t/helper. However because bin-wrappers/*
> only depend on wrap-for-bin.sh, when switching between a branch that =
has
> this commit and one that does not, bin-wrappers/* may not be regenera=
ted
> and point to the old/outdated test programs.
>
> This commit makes a non-functional change in wrap-for-bin.sh, just
> enough for 'make' to detect and re-execute wrap-for-bin.sh. When
> switching between a branch containing both this commit and e6e7530 an=
d
> one containing neither, bin-wrappers/*, we should get fresh bin-wrapp=
ers/*.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wrap-for-bin.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> index db0ec6a..22b6e49 100644
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -17,6 +17,7 @@ fi
>  GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLI=
B}"
>  GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
>  PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
> +
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
> =20
>  if test -n "$GIT_TEST_GDB"
