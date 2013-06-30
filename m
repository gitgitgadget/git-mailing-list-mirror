From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: spell 'ls-files --delete' option correctly in test descriptions
Date: Sun, 30 Jun 2013 12:30:29 -0700
Message-ID: <7vd2r3jt0q.fsf@alter.siamese.dyndns.org>
References: <1372589125-8529-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtNKV-0007KI-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab3F3Tac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 15:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3F3Tab convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 15:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3A02CEA3;
	Sun, 30 Jun 2013 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v+XXR0vthFrV
	vAf4ZeYWhHB9q1k=; b=AsJv9JlKUB+fhdDeOSQhiqDa22e0kPhUgWnn31WQ2ppE
	Yz7j2eh7utAe30srrxEgWOmEF/2nD/W8LjhVJ1UPeqvtjhPMX7NcFn2AzsbtlZGZ
	KtrXDeDR9dUZZhZHTDhava0P5ZAAApuGAgUIlBAD2DsV31fI+66hYkpEoJiiZUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u6CWRH
	gg/jjhWp8VxPRGASKK3oqreE8+32zvm8QUceOCHqiLy12rotuAuIqKaS5N1IMi7t
	53tCW/HPd6BqSjHkYA8prv8rxB6hD2LizrEUrRFPmvnA3q8FP7nSr4wEDLz15UTL
	TODgKm0SPxFTPFOyNuWEuHvDXaWA0iJVXvnu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 058C72CEA1;
	Sun, 30 Jun 2013 19:30:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78BFF2CEA0;
	Sun, 30 Jun 2013 19:30:30 +0000 (UTC)
In-Reply-To: <1372589125-8529-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 30 Jun 2013 12:45:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 866DEDBA-E1BB-11E2-B565-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229285>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The option is spelled '--deleted'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---

Thanks.

>  t/t7011-skip-worktree-reading.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree=
-reading.sh
> index 8f3b54d8..88d60c1c 100755
> --- a/t/t7011-skip-worktree-reading.sh
> +++ b/t/t7011-skip-worktree-reading.sh
> @@ -91,12 +91,12 @@ test_expect_success 'update-index --remove' '
>  	test_cmp expected 1
>  '
> =20
> -test_expect_success 'ls-files --delete' '
> +test_expect_success 'ls-files --deleted' '
>  	setup_absent &&
>  	test -z "$(git ls-files -d)"
>  '
> =20
> -test_expect_success 'ls-files --delete' '
> +test_expect_success 'ls-files --deleted' '
>  	setup_dirty &&
>  	test -z "$(git ls-files -d)"
>  '
