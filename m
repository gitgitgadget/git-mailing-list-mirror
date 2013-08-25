From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] Remove irrelevant reference from "Tying it all together"
Date: Sat, 24 Aug 2013 20:56:08 -0700
Message-ID: <xmqqwqnal8yv.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1749978317.1091238.1377329758522.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us, jdl@jdl.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:56:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRR2-0007Hb-Cl
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab3HYD4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755517Ab3HYD4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:56:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5832B2C4EF;
	Sun, 25 Aug 2013 03:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FC0GmGYslTW4h1dzRLRwCQQ1bTM=; b=IEEwB8
	8GNnx7Xv7ePU2qdqa+zvlRog64R5P7t2sG9d2FmM5UJd42Ls+kwzi2OHuC8XdsrX
	pCUT0MP2It/0wnJ7cUIYTx9YumnHK7gak7FmWB8FnAusPAczEQdmEsFa4SvF9GAZ
	vlitpapXHvA5dZevxd1JbxxuPI6kKv8RoI5bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CAbcjD3sGuyA2foOy8kMs2jKBxOF1UNp
	Gt/Sbezor6m/pvjz8ew91mAWjwdimYBIo3gsq1OJq7wsDD8j8Vo2BTi91bDgB/3U
	hKGEuVRm+mnPy4X1v7q4Syz8FCanbZvsBCnpD2ZSFROPnQbSS2Sv6E/O2Pcn7m43
	0rbM2WCKdzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DBE22C4EE;
	Sun, 25 Aug 2013 03:56:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A832F2C4ED;
	Sun, 25 Aug 2013 03:56:10 +0000 (UTC)
In-Reply-To: <1749978317.1091238.1377329758522.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:35:58 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4750E9DE-0D3A-11E3-9850-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232907>

Thomas Ackermann <th.acker@arcor.de> writes:

> Sorry Jon, but this might not be of any help to new Git users ;)
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>

Yeah, I think this is long overdue.  The drawing was taken from an
e-mail posted in a discussion, and the credit should have been given
in the commit log message, not in-text.


> ---
>  Documentation/user-manual.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 0d3f04e..08d8c91 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3908,8 +3908,7 @@ save the note about that state, in practice we tend to just write the
>  result to the file pointed at by `.git/HEAD`, so that we can always see
>  what the last committed state was.
>  
> -Here is an ASCII art by Jon Loeliger that illustrates how
> -various pieces fit together.
> +Here is a picture that illustrates how various pieces fit together:
>  
>  ------------
