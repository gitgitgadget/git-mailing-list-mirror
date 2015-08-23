From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Sun, 23 Aug 2015 22:00:49 +0200
Message-ID: <vpqzj1hkc5q.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTbRv-0006N5-9Z
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 22:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbbHWUA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 16:00:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42981 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbbHWUA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 16:00:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7NK0klH023150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 23 Aug 2015 22:00:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7NK0nik014936;
	Sun, 23 Aug 2015 22:00:49 +0200
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 22 Aug 2015 09:09:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 23 Aug 2015 22:00:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7NK0klH023150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440964849.28777@X9dtoRtLHHaJR17LoPfjvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276426>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 1997657..06d468e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -133,7 +133,8 @@ align::
>  	`<position>` is either left, right or middle and `<width>` is
>  	the total length of the content with alignment. If the
>  	contents length is more than the width then no alignment is
> -	performed.
> +	performed. If used with '--quote' everything in between %(align:..)
> +	and %(end) is quoted.

There's no --quote, there are --shell, --python, ... (well, actually, I
would have prefered to have a single --quote=language option, but that's
not how it is now).

I had already commented on a preliminary version of this series
off-list. I think all my previous comments have been taken into account.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
