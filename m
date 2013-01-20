From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] INSTALL: git-p4 doesn't support Python 3
Date: Sun, 20 Jan 2013 10:54:52 -0800
Message-ID: <7vwqv7lm6b.fsf@alter.siamese.dyndns.org>
References: <20130120110620.GJ31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx032-0004uX-WA
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab3ATSy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:54:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab3ATSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:54:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECFF1A433;
	Sun, 20 Jan 2013 13:54:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LhFBho/HUM9dTNUpkO1lKMPoDoU=; b=h+c3l4
	oVOTwRyWXY93ZQNyADvMXvoTIMtSJYWuq7nG7EADtD2U6rL0Y3riCr3pNUoCX/9p
	p5KYUvaLtae9dw61C1VsuRj6sTkCCxipSIWOJxI/xwDoTqwh5EPriQ0oCJFdfo/P
	zSU2XmzSIFh5zSQR62fqnHU4gkNUMaP+cPlRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHEHJk06A8YcyJUoNOUxoH23gPtkuFr2
	xykSLihV+yy/SZjIpHRvrK0XNH/OiiudT94P8juDJ6tQ+v0fRA/piHiYH3UdkaW4
	l5yrjtkZnHRQxe6QHwRaXN3vj28FnqfikPzi/vtI3nyzY54BTy1XWa2uQkLI9nf3
	kwSC6GO69mw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1673A432;
	Sun, 20 Jan 2013 13:54:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47FDFA431; Sun, 20 Jan 2013
 13:54:54 -0500 (EST)
In-Reply-To: <20130120110620.GJ31172@serenity.lan> (John Keeping's message of
 "Sun, 20 Jan 2013 11:06:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0A5F10E-6332-11E2-8DC6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214032>

John Keeping <john@keeping.me.uk> writes:

> git-p4 supports Python 2.6 and later versions of Python 2.  Since Python
> 2.8 will never exist [1], it is most concise to just list the supported
> versions.

Thanks; Eric's patch recently updated git-p4.py to require 2.4 I
think. Shouldn't it also be updated?

>
> [1] http://www.python.org/dev/peps/pep-0404/
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> Acked-by: Pete Wyckoff <pw@padd.com>
> ---
> Since v1:
>  - Fixed a typo in the commit message.
>
>  INSTALL | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/INSTALL b/INSTALL
> index 28f34bd..c456d1c 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -131,7 +131,7 @@ Issues of note:
>  	  use English. Under autoconf the configure script will do this
>  	  automatically if it can't find libintl on the system.
>  
> -	- Python version 2.6 or later is needed to use the git-p4
> +	- Python version 2.6 or 2.7 is needed to use the git-p4
>  	  interface to Perforce.
>  
>   - Some platform specific issues are dealt with Makefile rules,
