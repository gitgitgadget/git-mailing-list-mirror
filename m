From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] README.md: add hyperlinks on filenames
Date: Tue, 23 Feb 2016 11:10:00 -0800
Message-ID: <xmqqio1f1bw7.fsf@gitster.mtv.corp.google.com>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYILd-0004Kq-0m
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcBWTKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:10:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcBWTKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:10:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE7E744C67;
	Tue, 23 Feb 2016 14:10:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZNb8NxDyeJvzJQyeFRmllGBgHKI=; b=hNr5WE
	Jht82mCQ6j8Tnty9EKYxs1DKip2oMmECfOnD+aWMA9W2i6yGHzv/HPJHcpUUa3l7
	sSchnV5APWgX75a3kmr/2WSh9iYwz9U5Eea6Iziu0yjUSGADHuwKZgPvA2PUSC8i
	ogdBLHxhfcglMvwe1ltLUMQ4kz2OZzpR+nd/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSW4o0TZTH3BXUUIOotTqd1Z1c5xyjC9
	01Xe/cXPaPqYGMv04EpQ7bR1qGxpQdZaq9NV+OJjQSxGUF2wPn4flmhTfVqjDhXO
	sqP1RpBS1yxXjURbcXX82Bb5BAm72coDgQWXeS5ZZndya83+XU3ed8CbPbwpcI+q
	nuYkVFOjqfo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6128944C66;
	Tue, 23 Feb 2016 14:10:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F10F044C5C;
	Tue, 23 Feb 2016 14:10:02 -0500 (EST)
In-Reply-To: <1456249229-30454-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 23 Feb 2016 18:40:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AA66FE4-DA61-11E5-AF16-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287102>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  README.md | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Makes sense, provided if we want to do Markdown.

If I were pushing this topic (i.e. cater to those who browse at
GitHub, not with "less" in the source tree), I'd have further made
these links to the preformatted documentation at git-scm.com; I
expected the later steps in this series to do that, but it seems you
stopped short of it for some reason.

> diff --git a/README.md b/README.md
> index 907eb3b..750fdda 100644
> --- a/README.md
> +++ b/README.md
> @@ -20,17 +20,17 @@ License version 2 (some parts of it are under different licenses,
>  compatible with the GPLv2). It was originally written by Linus
>  Torvalds with help of a group of hackers around the net.
>  
> -Please read the file INSTALL for installation instructions.
> +Please read the file [INSTALL][] for installation instructions.
>  
> -See Documentation/gittutorial.txt to get started, then see
> -Documentation/giteveryday.txt for a useful minimum set of commands, and
> -Documentation/git-commandname.txt for documentation of each command.
> +See [Documentation/gittutorial.txt][] to get started, then see
> +[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
> +[Documentation/git-commandname.txt][] for documentation of each command.
>  If git has been correctly installed, then the tutorial can also be
>  read with "man gittutorial" or "git help tutorial", and the
>  documentation of each command with "man git-commandname" or "git help
>  commandname".
>  
> -CVS users may also want to read Documentation/gitcvs-migration.txt
> +CVS users may also want to read [Documentation/gitcvs-migration.txt][]
>  ("man gitcvs-migration" or "git help cvs-migration" if git is
>  installed).
>  
> @@ -40,7 +40,7 @@ including full documentation and Git related tools.
>  The user discussion and development of Git take place on the Git
>  mailing list -- everyone is welcome to post bug reports, feature
>  requests, comments and patches to git@vger.kernel.org (read
> -Documentation/SubmittingPatches for instructions on patch submission).
> +[Documentation/SubmittingPatches][] for instructions on patch submission).
>  To subscribe to the list, send an email with just "subscribe git" in
>  the body to majordomo@vger.kernel.org. The mailing list archives are
>  available at http://news.gmane.org/gmane.comp.version-control.git/,
> @@ -50,3 +50,10 @@ The maintainer frequently sends the "What's cooking" reports that
>  list the current status of various development topics to the mailing
>  list.  The discussion following them give a good reference for
>  project status, development direction and remaining tasks.
> +
> +[INSTALL]: INSTALL
> +[Documentation/gittutorial.txt]: Documentation/gittutorial.txt
> +[Documentation/giteveryday.txt]: Documentation/giteveryday.txt
> +[Documentation/git-commandname.txt]: Documentation/git-commandname.txt
> +[Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
> +[Documentation/SubmittingPatches]: Documentation/SubmittingPatches
