From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] Fix tests under GETTEXT_POISON on relative dates
Date: Mon, 27 Aug 2012 09:18:03 -0700
Message-ID: <7vfw78tikk.fsf@alter.siamese.dyndns.org>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6211-0000Qw-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab2H0QSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 12:18:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab2H0QSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 12:18:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6777C32;
	Mon, 27 Aug 2012 12:18:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Sc3s1AyDQtd
	7vNi3uZ83W8Vxcw=; b=von8P6IGZiPfjMajbci6ub7dd+ZjpvoaRYj1u4wuGshR
	CgViBkFeK7d6wKgjKqZXPyE+7yva5Y6c59w55HtynPsjqn950d0ig2Oh34Lmznoj
	BrVJkEWbbqyC6bU+GBoXuYCKEydwfuVzSjDJMvhM0BFfHs3V7xap3V5ukMI7UG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yBuaoN
	WalO7VouhdzmPDxerV+XMp8afUNAYoU2ENSC6nXnLvdc+inZKmmLPQ24trhwe9sL
	tcPKN6MZYnA3dTpDLVWYR6t7MhFhe4iBzmAkiF7SSbzvU3c62Czxqq7AJyShX+aG
	5yC5sLqjtJOUw3IroLeeo/6n95W5W2+P1HaSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5884A7C31;
	Mon, 27 Aug 2012 12:18:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83F307C29; Mon, 27 Aug 2012
 12:18:05 -0400 (EDT)
In-Reply-To: <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com> (Jiang Xin's message of "Mon, 27 Aug 2012 13:36:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8489DB6-F062-11E1-BDC1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204352>

Jiang Xin <worldhello.net@gmail.com> writes:

> Use a i18n-specific test_i18ncmp in t/t0006-data.sh for relative date=
s
> tests. This issue was was introduced in v1.7.10-230-g7d29a:
>
>     7d29a i18n: mark relative dates for translation
>
> and been broken under GETTEXT_POISON=3DYesPlease since.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks; will queue with s/0006-data/0006-date/

>  t/t0006-date.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 1d29..e53cf 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -11,7 +11,7 @@ check_show() {
>  	echo "$t -> $2" >expect
>  	test_expect_${3:-success} "relative date ($2)" "
>  	test-date show $t >actual &&
> -	test_cmp expect actual
> +	test_i18ncmp expect actual
>  	"
>  }
