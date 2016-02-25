From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] log: introduce init_log_defaults()
Date: Thu, 25 Feb 2016 11:31:48 -0800
Message-ID: <xmqqk2lsoacb.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:32:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1e1-0007l4-Ec
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649AbcBYTbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:31:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933583AbcBYTbw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:31:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09D2847AB6;
	Thu, 25 Feb 2016 14:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=su2P79ZnhhrCZSdYp5sAhrh8+oo=; b=aCNPhy
	cY37PO6N3M2+GGQL5l96u//107fzNIrSN7DJ7yCZtGtTvA57IZIbf4WelUTQzyEw
	pP66t3ECO4VTFIoM/Kykvm9zGWsr6TOfSST1WZAk0x9VXzgBOd3zsaW7a0JFpOPx
	g9fMe+KALZ9FG3Souo7xajOouJE4ddHHP/FWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cpJvxJ1d7amnZp7AlN54rFqesVSnGukm
	QZZRfQIogqSGSx//xDJZXkKDyILTBMZMt7J/w6zxmAN7qKS2T+gtyVgpcUdj7KvR
	1hSZ3IWX2IV845VV93MUw0XfWdwaENwLs5Vc8BXS2614md+Xha8el8uJqHvMgT7k
	Rf6pMRrGkZ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00F2C47AB5;
	Thu, 25 Feb 2016 14:31:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01DBB47AB1;
	Thu, 25 Feb 2016 14:31:49 -0500 (EST)
In-Reply-To: <1456390761-27015-5-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 25 Feb 2016 09:59:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A855F56-DBF6-11E5-B34E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287422>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This is currently a wrapper around init_grep_defaults(), but will allow
> adding more initialization in further patches.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/log.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 0d738d6..7f96c64 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -100,6 +100,11 @@ static int log_line_range_callback(const struct option *option, const char *arg,
>  	return 0;
>  }
>  
> +static void init_log_defaults()

	static void init_log_defaults(void).

Locally patched up already; no need to resend.

Thanks.
