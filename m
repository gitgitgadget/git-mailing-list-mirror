From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Provide a 'git help user-manual' route to the docbook
Date: Tue, 18 Feb 2014 12:14:32 -0800
Message-ID: <xmqqha7wdvpz.fsf@gitster.dls.corp.google.com>
References: <1392472299-3780-1-git-send-email-philipoakley@iee.org>
	<1392472299-3780-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Thomas Ackermann <th.acker@arcor.de>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>,
	Kevin Bracey <kevin@bracey.fi>,
	Ondrej =?utf-8?Q?B=C3=ADlka?= <neleai@seznam.cz>,
	Phil Hord <hordp@cisco.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 21:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFr3y-0007zr-F7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 21:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbaBRUOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 15:14:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbaBRUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 15:14:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E96F6B2AA;
	Tue, 18 Feb 2014 15:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JY0z1K2BjryOrEhp+KJEHPm1ccQ=; b=DzZVyB
	6hwXSXWD6jLtbBNzQo7D0NKY033CFLtrEpDrNOtMJqsHllBv8uac7IxSOpvq3xsS
	0tX75oY9VAk+9IBEVjDdSc4wE3l54inMIL6nVCGKmWmzb/rcKrWuP3MPGLKP3r7z
	7N7NcKtuuyv/789J3/WoEhT+g2UcxLM3eL0+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDpoWz++N2NloT34rDjPbKRdnZIZcEmY
	jdOr06Wb9apuFY7gMdhVgvpka48Mq2h2Ha9gBFNk4hSgdvRitVNnpVE+SPyAwaIf
	Mjr+vli6bGEpXPCmDcich4JJXBHYSEbw5vzhuEwX5EIKIMMB7vWirIQPwChQ8Nuy
	7+7k1+mrjJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 393AD6B2A6;
	Tue, 18 Feb 2014 15:14:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48CBD6B29D;
	Tue, 18 Feb 2014 15:14:35 -0500 (EST)
In-Reply-To: <1392472299-3780-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sat, 15 Feb 2014 13:51:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4926D8E2-98D9-11E3-9FE5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242349>

Philip Oakley <philipoakley@iee.org> writes:

> diff --git a/Documentation/gituser-manual.txt b/Documentation/gituser-manual.txt
> new file mode 100644
> index 0000000..9fd4744
> --- /dev/null
> +++ b/Documentation/gituser-manual.txt
> @@ -0,0 +1,34 @@
> +gituser-manual(7)
> +=================
> +
> +NAME
> +----
> +gituser-manual - a link to the user-manual docbook
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git help user-manual'
> +
> +link:user-manual.html[Git User's Manual]

Is it just me, or is typing

	$ git help user-manual

and not seeing the manual itself, but only a link you have to click
to get there a worthwhile addition?

I would not mind having a clickable link in the output from

	$ git help git

or something that does already have other useful information, though.

> +
> +DESCRIPTION
> +-----------
> +Git is a fast, scalable, distributed revision control system with an
> +unusually rich command set that provides both high-level operations
> +and full access to internals.
> +
> +The link:user-manual.html[Git User's Manual] provides an
> +in-depth introduction to Git.
> +
> +SEE ALSO
> +--------
> +linkgit:gittutorial[7],
> +linkgit:giteveryday[7],
> +linkgit:gitcli[7],
> +linkgit:gitworkflows[7]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/builtin/help.c b/builtin/help.c
> index 1fdefeb..be7c39d 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -427,6 +427,7 @@ static struct {
>  	{ "modules", N_("Defining submodule properties") },
>  	{ "revisions", N_("Specifying revisions and ranges for Git") },
>  	{ "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 or newer)") },
> +	{ "user-manual", N_("A link to the user-manual docbook") },
>  	{ "workflows", N_("An overview of recommended workflows with Git") },
>  };
