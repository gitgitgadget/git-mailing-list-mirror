From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-commit: Typo under --edit
Date: Thu, 02 May 2013 12:46:03 -0700
Message-ID: <7va9od17yc.fsf@alter.siamese.dyndns.org>
References: <1367519056-8889-1-git-send-email-andersgb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anders Granskogen =?utf-8?Q?Bj=C3=B8rnstad?= <andersgb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzSM-0001hp-So
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046Ab3EBTqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 15:46:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761355Ab3EBTqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 15:46:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB886196D4;
	Thu,  2 May 2013 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=blK3fGJzoqdM
	JMWWTkvA9bdFkQg=; b=xN5oCZK2g2jLPhVjv+8sPwQS2fmfGgSGHPHcXv5ezmPb
	0D6B0ycgBO+9j2xaZDxOHnCKfIgBmTKv7wFtMd0EpzoTexWK0bIo4iDKJtMa4FrH
	+uxccgckkBVMC9A5UsyHTRgj2RmIW8RXy9yaVNLAdCQrrxmorq0CiMZePhEesB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dr1LOf
	+sy4wwAuvMvBF9zjzv1nB77g5ULBp1XrZGfs9oO+7DWZ1ki2B8jzPZEOYigO/KgW
	3XzEZXegYWDUZkA24ri2WhFrF7Gj/TuEQ2+oIpAAzI5OYwladOYVZELTr5RXNyGF
	MMP8zA7H/BxgSwEllffdPttb6iEYa27m5127c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10D0196D3;
	Thu,  2 May 2013 19:46:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85E47196D1;
	Thu,  2 May 2013 19:46:05 +0000 (UTC)
In-Reply-To: <1367519056-8889-1-git-send-email-andersgb@gmail.com> ("Anders
	Granskogen =?utf-8?Q?Bj=C3=B8rnstad=22's?= message of "Thu, 2 May 2013
 20:24:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED64E14C-B360-11E2-A1E0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223256>

Anders Granskogen Bj=C3=B8rnstad  <andersgb@gmail.com> writes:

> -C takes a commit object, not a file.
>
> Signed-off-by: Anders Granskogen Bj=C3=B8rnstad <andersgb@gmail.com>
> ---
>  Documentation/git-commit.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 9b1be55..8172938 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -197,8 +197,8 @@ variable (see linkgit:git-config[1]).
>  -e::
>  --edit::
>  	The message taken from file with `-F`, command line with
> -	`-m`, and from file with `-C` are usually used as the
> -	commit log message unmodified.  This option lets you
> +	`-m`, and from commit object with `-C` are usually used as
> +	the commit log message unmodified. This option lets you
>  	further edit the message taken from these sources.
> =20
>  --no-edit::

Obviously correct; thanks.  Will apply to 'maint'.
