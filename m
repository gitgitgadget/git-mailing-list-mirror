From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Mon, 06 Dec 2010 22:55:47 +0100
Message-ID: <87zksi5zx8.fsf@gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPj4A-00071o-3f
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0LFV5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 16:57:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43406 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab0LFV5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 16:57:44 -0500
Received: by fxm20 with SMTP id 20so4678657fxm.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=iRX/hj2FNViK+p3efWNxw97PpaKTq721BlzQG5umvKQ=;
        b=AV8q5CSFTWWUcCRbn/+Yl3aaga3wPOehj5KgC3j95K55Qrzk6j+wcuUPRaGsr9rhwl
         R0fBBXk0f1y5L6SSu0yT59q5ncyoSQGu007omcXGA0JGHqnFEO0vZVdL7W6LAKfuudDf
         m1P3zwyEyr3iAoq6AanLmN1KFRSshttBBdLc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=q/WAXdtDl2sPaGCmHHe5iCepCWIGRs6L/vBVd6uZMKifV4P2ur/iKbbGs7Qb9uqP4Z
         VvUDsDKUUGNgOb/S5jO8vt4nkDcIot7+X+oTJRSZqOvjfP5rTjgWdiuwlG71/i+wkTis
         TbcX8ZJAsZu9MlZlKUBwWujaxypcfzER7zJU8=
Received: by 10.223.74.6 with SMTP id s6mr6114808faj.111.1291672662905;
        Mon, 06 Dec 2010 13:57:42 -0800 (PST)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id c11sm1721597fav.2.2010.12.06.13.57.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 13:57:42 -0800 (PST)
In-Reply-To: <7vlj42siu5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 Dec 2010 13:16:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163031>

Junio C Hamano <gitster@pobox.com> writes:

[...]

Just two cosmetic nits I noticed:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d82c0da..bdf90eb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -351,6 +351,12 @@ This value is true by default in a repository th=
at has
>  a working directory associated with it, and false by
>  default in a bare repository.
> =20
> +core.logRefDeletion::
> +	Enable logging of eletion of refs (e.g. branches), allowing `git
                          ^^^^^^^

[...]

> diff --git a/refs.c b/refs.c
> index e3c0511..afdd634 100644
> --- a/refs.c
> +++ b/refs.c

[...]

> -	/* removing the loose one could have resurrected an earlier
> -	 * packed one.  Also, if it was not loose we need to repack
> -	 * without it.
> -	 */

Could also the first sentence start with a capital letter?

[...]

> +		if (!(delopt & REF_NODEREF))
> +			lock->lk->filename[i] =3D '.';
> +	}
> +	/*
> +	 * removing the loose one could have resurrected an earlier
> +	 * packed one.  Also, if it was not loose we need to repack
> +	 * without it.
> +	 */

Same here.

Thank you,

  =C5=A0t=C4=9Bp=C3=A1n
