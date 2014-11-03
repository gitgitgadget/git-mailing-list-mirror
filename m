From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes/2.2.0.txt: fix minor typos
Date: Mon, 03 Nov 2014 11:28:57 -0800
Message-ID: <xmqqa948rsli.fsf@gitster.dls.corp.google.com>
References: <1415027520-28410-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlNJQ-0005k9-BC
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbaKCT3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:29:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753299AbaKCT3C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:29:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 28E261A499;
	Mon,  3 Nov 2014 14:29:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHJ2R17SIWVvCETaVSv5/8D+G+c=; b=EBW4t5
	rXGfIigxPGClXdeObz/OsV6yQOpJfyiNiYzu8jMUbKP9dey1+Hv6TKoDi+dvtlK6
	CypcNLks/NDLrbgkSvhqDGNqvS1bo+QqueaLk6I1NIDWvjqsigIf++XH7aHqwzX5
	m4x1uPfNWErz+X/b297KH23TVKqjXNd5IYg2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghe46PPG/Me57lKj64R2TojsH9XVddC9
	wTmqOJH6QdA3IAnzbBqxgrZcDazg5rNMzqpC2XylSFVf02RvWzmQDqJ1n96EXbdn
	RY4ro3hrmJBUWXuA9N0JekFMEvUombyTBSAhx9LWlhwkKAgTaqkIwQbJgZ1N5br7
	6llWddABqhk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2015B1A497;
	Mon,  3 Nov 2014 14:29:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8619C1A495;
	Mon,  3 Nov 2014 14:28:59 -0500 (EST)
In-Reply-To: <1415027520-28410-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 3 Nov 2014 16:12:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A90C3294-638F-11E4-A7E5-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Thanks.

>  Documentation/RelNotes/2.2.0.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.0.txt
> index 741e14e..a50896f 100644
> --- a/Documentation/RelNotes/2.2.0.txt
> +++ b/Documentation/RelNotes/2.2.0.txt
> @@ -40,7 +40,7 @@ UI, Workflows & Features
>     diff backend when it exits with a non-zero status.
>  
>   * "git grep" allows to paint (or not paint) partial matches on
> -   context lines whenshowing "grep -C<num>" output in color.
> +   context lines when showing "grep -C<num>" output in color.
>  
>   * "log --date=iso" uses a slight variant of ISO 8601 format that is
>     made more human readable.  A new "--date=iso-strict" option gives
> @@ -62,7 +62,7 @@ UI, Workflows & Features
>     e.g. "hello_BASE_4321.c").
>  
>   * The temporary files "git mergetools" uses can be placed in a newly
> -   creted temporary directory, instead of the current directory, by
> +   created temporary directory, instead of the current directory, by
>     setting the mergetool.writeToTemp configuration variable.
>  
>   * "git mergetool" understands "--tool bc" now, as version 4 of
> @@ -292,6 +292,6 @@ notes for details).
>     (merge b12d045 da/mergetool-meld later to maint).
>  
>   * "git pack-objects" forgot to disable the codepath to generate
> -   object recheability bitmap when it needs to split the resulting
> +   object reachability bitmap when it needs to split the resulting
>     pack.
>     (merge 2113471 jk/pack-objects-no-bitmap-when-splitting later to maint).
