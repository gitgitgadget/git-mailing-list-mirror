From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH/RFC] Documentation/git-stripspace: Update synopsis
Date: Wed, 19 Nov 2014 13:40:14 -0800
Message-ID: <xmqqk32qrhs1.fsf@gitster.dls.corp.google.com>
References: <546BD367.40301@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, conrad.irwin@gmail.com
To: Slavomir Vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:40:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCzB-0000GZ-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbaKSVkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:40:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756527AbaKSVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:40:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F29C1ED18;
	Wed, 19 Nov 2014 16:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=glzSVuSmwYpX2m3pLLrRpPS4III=; b=iOu881
	hGX2txT4yWjwQh9kFbXUsY0wDuMFYBwtgbG5PPWadfRVv9yGCMxa3+Nv9XADtxr6
	ivRjxWtvbK+uR/TcJa6Y3tJjgSdI0aZJiOq+gAJilOsuoORkDrEoI3T0JV33CMbr
	an71FXneTvuJjJI27txnThO0rZy+WTbwHINGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khHGLBdXdn13pJk1dtq2BfsJev9fwKt4
	kwstwdoikadEdx+DmhbUycXszXAHkEq4BA5pgVUWWn7SjiFpv1xWbJe/kXtXpbA7
	ZUSNAxHZGofHK7VVInSqIBG7yvMU9WeMEBZdaDEJIJsMCt6TI/cvqDSt2fqDz5RR
	iN1LX5972IQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56BA81ED17;
	Wed, 19 Nov 2014 16:40:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D26611ED16;
	Wed, 19 Nov 2014 16:40:15 -0500 (EST)
In-Reply-To: <546BD367.40301@inventati.org> (Slavomir Vlcek's message of "Wed,
	19 Nov 2014 00:16:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A64E263C-7034-11E4-A490-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavomir Vlcek <svlc@inventati.org> writes:

> I solved this by adding an extra (second) synopsis line
> so it looks just like the 'usage_msg' in 'builtin/stripspace.c'.
>
> But perhaps it would be wiser to have something like
> "git stripspace [[-s | --strip-comments] | [-c | --comment-lines]] < input"
> instead (and perhaps ordered alphabetically).

That might be more "manly" but much less friendly to humans compared
to what your patch gives us.

These two modes are really about two different operations (the
latter is not "strip" at all, but is about adding spaces, to which
"comments" are often equated to), and two-line synopsis shows more
prominently that they are distinct, which I think is the right thing
to do.

> diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
> index c87bfcb..6c6e989 100644
> --- a/Documentation/git-stripspace.txt
> +++ b/Documentation/git-stripspace.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git stripspace' [-s | --strip-comments] < input
> +'git stripspace' [-c | --comment-lines] < input
>  
>  DESCRIPTION
>  -----------
