From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] diff: activate diff.renames by default
Date: Thu, 25 Feb 2016 09:52:40 -0800
Message-ID: <xmqq60xcpthz.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456390761-27015-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:52:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ05p-0005Cx-4q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbcBYRwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:52:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932381AbcBYRwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:52:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16E7E47DF1;
	Thu, 25 Feb 2016 12:52:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VQ7f3mbrCvHsEolosBMvUbWrAfM=; b=MvA6VB
	H7dDkagOtduQeZ7Ng81LA7IncRIvTc8xPygwZHYUHObj5MP+3nUaNQt91cpuJJcm
	OI7rin4LyDmAIbVP3xRIpGtGWA2DAig4RX5gdYFfx1Ute0WyhOi/mNuRKFdTRQDS
	T0YVO6kO9XGy+zIjQ7Fyg/JmoAfx5GCTzxauM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSEJx/z+STDUZ73oyfH0XFwGSsB8DVFt
	lTgmWbOQiVuGvwP4sC+QDQRD/aV6egEF+Vj8uJUT1z6SvCy0pVz0aFdr1QsxUNn7
	oRK8nNL27bdFuXVjOdcfNxmPq1wSQB7Ec61h8kfPabg9g1os+V9ULKbFNC2QwJbK
	2C2+f/Q9ww8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E66D47DF0;
	Thu, 25 Feb 2016 12:52:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 786A747DEC;
	Thu, 25 Feb 2016 12:52:41 -0500 (EST)
In-Reply-To: <1456390761-27015-6-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 25 Feb 2016 09:59:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90ED8A46-DBE8-11E5-BD0A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287406>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 40e5de9..69389ae 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -111,7 +111,7 @@ diff.renames::
>  	Whether and how Git detects renames.  If set to "false",
>  	rename detection is disabled. If set to "true", basic rename
>  	detection is enable.  If set to "copies" or "copy", Git will

Not a new issue, but s/enable/&d/, I think.

> -	detect copies, as well.  Defaults to false.  Note that this
> +	detect copies, as well.  Defaults to true.  Note that this
>  	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
>  	linkgit:git-log[1], and not lower level commands such as
>  	linkgit:git-diff-files[1].
