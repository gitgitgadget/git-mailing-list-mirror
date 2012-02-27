From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: document the --smtp-debug option
Date: Mon, 27 Feb 2012 12:19:23 -0800
Message-ID: <7v8vjo6nck.fsf@alter.siamese.dyndns.org>
References: <87ehtiu5dg.fsf@smith.obbligato.org>
 <1330359773-16759-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, greened@obbligato.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S272h-0004vD-M4
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2B0UT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 15:19:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab2B0UT0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 15:19:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC457D25;
	Mon, 27 Feb 2012 15:19:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9f9bkJZyvzW8
	FMrSSh/t832Plqw=; b=g7fyMG8DUrM4hQ62IaoLor5t1Ql5xZFCNtDT4miISq4m
	KWBNiOrg4LOhv7ZVVAwS6pS6hcAUhbKcSx7MyMPPQNR005iM9cGu3+UtlaDylEPK
	NDHzzLPUShVlodig9/F9mANUj48VVTnGeE2HoiIOCk7lBo6u4IsOjHh5aOumdUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oqmLYh
	WdG/U23T5f94PGqszn8SQVY6yrjNsQIyOlBv+a1KoVezLFf3vp88yQV/Idtq2Cwb
	gmObxcfyf7ojTY2hpQaOcJGMEoq2/dytyByY+WC4LN60Qm2qLBbQiroST4t2E8Du
	MjRKzkHeB5aHRp7FK0LkOwpPpxI+ZS1RuWVJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42C77D24;
	Mon, 27 Feb 2012 15:19:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07F437D23; Mon, 27 Feb 2012
 15:19:24 -0500 (EST)
In-Reply-To: <1330359773-16759-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Mon, 27 Feb 2012
 17:22:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 578DB8D4-6180-11E1-8041-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191663>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> The option was already shown in -h output, so it should be documented
> in the man page.
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> Suggested-by: David A. Greene <greened@obbligato.org>
> ---
> David Greene wrote:
>> I don't think --smtp-debug is documented in the man pages.  Was that=
 a
>> deliberate decision or an oversight?

Probably halfway in between "Meh"; anybody who is willing to look into =
the
issue will notice when he opens the script and reads it for the first t=
ime
anyway, so why bother.

But now "A patch already exists, and it does not seem to have any funny
letters that may screw up asciidoc, so why bother rejecting" ;-)

Will apply; thanks.

>  Documentation/git-send-email.txt |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index 327233c..3241170 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -198,6 +198,10 @@ must be used for each option.
>  	if a username is not specified (with '--smtp-user' or 'sendemail.sm=
tpuser'),
>  	then authentication is not attempted.
> =20
> +--smtp-debug=3D0|1::
> +	Enable (1) or disable (0) debug output. If enabled, SMTP
> +	commands and replies will be printed. Useful to debug TLS
> +	connection and authentication problems.
> =20
>  Automating
>  ~~~~~~~~~~
