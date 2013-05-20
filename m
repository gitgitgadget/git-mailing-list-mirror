From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-index man page
Date: Mon, 20 May 2013 15:48:19 -0700
Message-ID: <7vy5b9s1xo.fsf@alter.siamese.dyndns.org>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
	<7vhahzza2v.fsf@alter.siamese.dyndns.org>
	<CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
	<7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
	<20130520062743.GA2919@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Albert Netymk <albertnetymk@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYsU-0002Xp-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab3ETWsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:48:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab3ETWsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:48:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0323C20336;
	Mon, 20 May 2013 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8ByN8YEJel1gLbRcbls/ed357rE=; b=FuP0IzEbzOk7267w1U8i
	IJqDUFP5BISwbZkS7/Yk7iB1RoBRkbAHYkPB9iMrqOwesiY2l205YFVGXwK8q5Yz
	FD04qcGaxDLzFAGnhX4rq+9hWzFKrblGmu26PlO7UJAScOIimBbJ6uNoReeKiPF1
	Do4P7OXm+GMj0+7Kxz8aF5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jS9kbqY8UqOMVoVQKunju7QNg4oGTsHaOTMGs9BAF3cXvt
	bbMbGHcbeW94CldcGhtMSa7r6vFQiIss+yr8pgZY/jOy44dpcQpzqUKcTogDeHbI
	FfFqaVg9jKu8wl1pruTmKB0PgwEpp7C4w8PjAItlZzD8/MhqXJ3ibhN6HwM9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA2A420335;
	Mon, 20 May 2013 22:48:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58EBC20332;
	Mon, 20 May 2013 22:48:21 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F15762A-C19F-11E2-8508-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224994>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks and hope that helps,
> Jonathan

Thanks, the result reads much better, I think.

Albert?


> diff --git i/Documentation/git-diff-index.txt w/Documentation/git-diff-index.txt
> index 58308e15..a86cf62e 100644
> --- i/Documentation/git-diff-index.txt
> +++ w/Documentation/git-diff-index.txt
> @@ -3,7 +3,7 @@ git-diff-index(1)
>  
>  NAME
>  ----
> -git-diff-index - Compare a tree and the working tree or the index
> +git-diff-index - Compare a tree to the working tree or index
>  
>  
>  SYNOPSIS
> @@ -13,12 +13,11 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -
> -Compare the content and mode of the blobs found in a tree object
> -with the corresponding tracked file in the working tree, or with the
> -corresponding paths in the index.  When paths are specified,
> -compares only those named paths.  Otherwise all entries in the index
> -are compared.
> +Compares the content and mode of the blobs found in a tree object
> +with the corresponding tracked files in the working tree, or with the
> +corresponding paths in the index.  When <path> arguments are present,
> +compares only paths matching those patterns.  Otherwise all tracked
> +files are compared.
>  
>  OPTIONS
>  -------
