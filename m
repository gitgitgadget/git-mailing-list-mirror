From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 37/38] i18n: unmark die messages for translation
Date: Tue, 07 Jun 2016 15:07:33 -0700
Message-ID: <xmqqtwh4odp6.fsf@gitster.mtv.corp.google.com>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
	<1465304141-9392-8-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:11:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAP9y-0004EL-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbcFGWHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:07:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755371AbcFGWHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:07:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86EAA23AE9;
	Tue,  7 Jun 2016 18:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vtf7ORTsuxtnzA545oK5bWXRWUM=; b=Xa4988
	QI+Cej4OO9Hg4TFav4s6yAINxdV+rFE6lljbow6xNt6a0yXMPz0kBBdwrPCX2X3i
	e48XeUFaqp+RL8rEtH1esKIlbVykjzepj9labOs1PQQYBLGg2u0o2SFHId4P/bPn
	nIqjyj7ujXSRkiTDYbtRvZf4pc0dzc/fo96s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLgsok3SfjL/dnXQ8r+yHSA/H0etriF/
	Bb4q1+56q5I8nLjfXnYhe/Y8QdTwZKA2mWEK2p+VcueqqaHpsIFun4lPUANI9e8T
	+3SqKeT5nlM2UGi+eHaaMXQzfnhdOSELFn26Wz0Ss2Sfo9FKDdxTvHDXGE2b4wtX
	5XvdeEYed8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FEC623AE8;
	Tue,  7 Jun 2016 18:07:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0744523AE7;
	Tue,  7 Jun 2016 18:07:34 -0400 (EDT)
In-Reply-To: <1465304141-9392-8-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Tue, 7 Jun 2016 12:55:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D222808-2CFC-11E6-A22C-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296734>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> These messages are relevant for the programmer only, not for the end
> user.  Thus, they can be unmarked for translation, saving translator
> some work.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-bisect.sh | 2 +-
>  wt-status.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 30d01bb..ae3cb01 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -274,7 +274,7 @@ bisect_state() {
>  	check_and_set_terms $state
>  	case "$#,$state" in
>  	0,*)
> -		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
> +		die "Please call 'bisect_state' with at least one argument." ;;

OK.  This should have had "bug:" prefix from the beginning, but that
is outside the topic.
