From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/13] Call it "Git User Manual" and remove reference to very old Git version
Date: Sat, 24 Aug 2013 20:07:36 -0700
Message-ID: <xmqq1u5io4cn.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<119602113.1090836.1377329085278.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQg2-0005ne-NI
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3HYDHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150Ab3HYDHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:07:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E83F2ABD0;
	Sun, 25 Aug 2013 03:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k9ZqNnAdw3I/mGKb7oYI2vgmDyI=; b=fHlw10
	QhCCP5t1M5Tr5sbSdeajeMYBgcnyNBFTBj0vTLnTYO3+4l/PeZnXYHnBirqscx5W
	XKqeOWuPQs7KjpgXaYyC3yH9WUYD3nnQbzqcQ33l/x6dE69OiJgMOmpuhOrWaKV6
	9TyP16FzadYR4UQPx4UhjMM8bqj2PKcadmAoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h98Sn0Kegzu07L8bRKmz46IhX8M5UHo0
	oswTDvCB//+6Un1nDcVanq6uQjmhRatRoxzdQnBgKwiiDYIZ7tiOwGx+xL8iA5W+
	XFQwxU2YTSI1gb1W4jKCl/GQ2hvDMVEU0aPgzd3hyGWiZCopxDxnBQ30fJPhuSQJ
	vYbVa0G3KLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 314922ABCF;
	Sun, 25 Aug 2013 03:07:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ACB92ABCD;
	Sun, 25 Aug 2013 03:07:37 +0000 (UTC)
In-Reply-To: <119602113.1090836.1377329085278.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:24:45 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7EF6770C-0D33-11E3-AE1D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232897>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index fe723e4..103ec9a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,6 +1,5 @@
> -Git User's Manual (for version 1.5.3 or newer)
> -______________________________________________
> -
> +Git User Manual
> +_______________
>  
>  Git is a fast distributed revision control system.

Yeah, it is about time.
