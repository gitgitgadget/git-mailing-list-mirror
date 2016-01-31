From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Sun, 31 Jan 2016 14:08:15 -0800
Message-ID: <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
	<1454274011-4880-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Jonathan Smith <Jonathan.Smith@fphcare.co.nz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 23:08:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ0AR-0006LZ-JV
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 23:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbcAaWIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 17:08:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757294AbcAaWIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 17:08:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 695653F5E1;
	Sun, 31 Jan 2016 17:08:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nz1Mq/6HiA40Is86yHOlIKv6T7w=; b=QWuQrW
	QX9tuVjiO3YOyUx/IkrTGGgNBYHb5AI3XPshotSjH80bG+S7VZQ+FcB0pF++/Fzt
	oKF1rq3BxoiXHZJEzcDwaOSh0bRaIwVE2jsQL4wpxkGiBdTnBT4DUAJqQ/tCznlz
	yzEVoC/3h8UwdA6VOtNs4NwI7HjMWauwwkFj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyzojLZxngy6S73UGMsBGb/xQFtHV7B8
	t7JDj02fDMrtk59qH/ap1l28jAC7dx6xTD+/w70InbtHr75ishIkjoLgA7Hr9MJ5
	dZRzsyxLRJTb5TX60s8Z3TyHbdtivp/jhUw+CNDAffhvR9K/a+vAcOFQop5dk6KM
	IsgRmze+bqQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FA3F3F5D2;
	Sun, 31 Jan 2016 17:08:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D20813F5D1;
	Sun, 31 Jan 2016 17:08:16 -0500 (EST)
In-Reply-To: <1454274011-4880-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sun, 31 Jan 2016 21:00:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21313AC0-C867-11E5-A2DF-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285174>

Philip Oakley <philipoakley@iee.org> writes:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index bff6302..137c89c 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1132,6 +1132,17 @@ of clones and fetches.
>  	  - any external helpers are named by their protocol (e.g., use
>  	    `hg` to allow the `git-remote-hg` helper)
>  
> +Licencing: Your data, and the Git tool[[Licencing]]
> +---------------------------------------------------
> +
> +Git is an open source tool provided under GPL2.
> +Git was designed to be, and is, the version control system
> +for the Linux codebase.
> +Your respository data created by Git is not subject to Git's GNU2
> +licence, see GPL FAQs
> +http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#TOCGPLOutput).
> +
> +User should apply a licence of their own choice to their repository data.
>  
>  Discussion[[Discussion]]
>  ------------------------

While I know you mean well, and I do understand the sentiment behind
this addition, there are at least two reasons why I do not want to
(and why we should not) add any "clarification" or "interpretation"
like this.

One is because such a statement is pointless.  Because we do not do
copyright assignment to the project, you are not the sole copyright
owner of Git.  Individual contributors hold copyright to the part
they wrote.  The above statement you made, even with an endorsement
by me as the project lead, does not have any power to assure that
the users will not get sued by one copyright holder, who is not you
or me, and at that point it is up to the court to interpret GPLv2.
We can call such a copyright holder crazy or call such a suit
frivolous, but that does not change the fact that the court is what
decides the matter, so having that statement does not help the user.

Another is because we are amateurs.  Philip, you may or may not be a
lawyer yourself, but I know you are not _our_ lawyer.  An amateurish
"interpretation" or "clarification" does not necessarily clarify the
text but it muddies it, especially when done carelessly.  Imagine a
case where a user creates a derived work of Git itself and stored it
in a Git repository.  "Your respository data created by Git is not
subject to Git's GNU2"--really?  At least the phrasing must say that
the act of storing something in Git alone would not *MAKE* that
something governed under GPLv2.  What the user puts in Git may
already be covered under GPLv2 for other reasons, and a statement
carelessly written like the above can be twisted to read as if we
are endorsing use of our code outside GPLv2 as long as they store it
in Git repository, which is not what you meant to say, but "that is
not what the copyright holder meant" is another thing the lawyer
need to argue in court to convince the judge, when we need to go
after a real copyright violator.

We should leave the lawyering to real lawyers and we should not add
unnecessary work of interpreting our amateurish loose statement to
our laywers.

Thanks.
