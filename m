From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: update to my shorter email address
Date: Mon, 02 May 2016 13:08:12 -0700
Message-ID: <xmqqd1p4rzo3.fsf@gitster.mtv.corp.google.com>
References: <20160502193121.29081-1-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Mon May 02 22:08:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axK8t-00088r-8O
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbcEBUIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 16:08:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755109AbcEBUIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 16:08:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E94018484;
	Mon,  2 May 2016 16:08:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0ky3kgLx1P49
	IV9FewW4ozbHw4M=; b=wZG/luhh0HbFbCQQwssquRYVgfys+Hc3bBrIDYSJ4kSX
	N48udfONnEOp4MbcmcbMbf63JvVrtjtkJsExq38R1/a8+5NeRRpDaB6HIEYWWZEX
	cm08039f0zDjSVm40qiGqtC5+HcdGoXrfVA5bXzCvsQHK1FxqzeMbKsCfr0FbF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wOtT4j
	C37cM2IzfUeLuedhnOJJR93DphAdvl/mW+50GVRV7YfS3pO8aitWFQTBqbcCufo0
	hbqzURO9K8z695OSOuHzPDmBMIRHyIExymnWXVMhX2h0qeSaF1CtTm7V5ftOew2T
	FqNuf0CNzs9ZfKyrT0prCwwpfMCizlJRQhD8M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2632818483;
	Mon,  2 May 2016 16:08:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85D0B18482;
	Mon,  2 May 2016 16:08:14 -0400 (EDT)
In-Reply-To: <20160502193121.29081-1-e@80x24.org> (Eric Wong's message of
	"Mon, 2 May 2016 19:31:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A486460-10A1-11E6-A80A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293281>

Eric Wong <e@80x24.org> writes:

> Following f916ab0ccc ("send-email: more meaningful Message-ID"),
> my own email address is too long :x

Yuck.  That sounds like a tail wagging the dog.

I wouldn't insist you to use a particular name, but at least
to me you'll forever be known as the normalperson.

Will queue.

> While I could have an even shorter address by one character with
> "yhbt.net", "80x24.org" is more representative of my
> hacking-related pursuits.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index e5b4126..a9162c0 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -51,6 +51,7 @@ Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>  Eric Blake <eblake@redhat.com> <ebb9@byu.net>
>  Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
>  Eric S. Raymond <esr@thyrsus.com>
> +Eric Wong <e@80x24.org> <normalperson@yhbt.net>
>  Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
>  Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel=
=2Entnu.no>
>  Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.ac=
hleitner2.6.31@gmail.com>
