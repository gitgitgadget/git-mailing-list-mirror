From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [TopGit PATCH] tg-log: move note from tg base to tg log
Date: Mon, 04 Oct 2010 23:05:41 +0200
Message-ID: <87vd5h1xei.fsf@gmail.com>
References: <AANLkTi=sc-FBG=CeNTv9H4Fj0KqdHkoudjQHqEYZxPuV@mail.gmail.com>
	<1286219189-22054-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sFF-0005aa-BA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab0JDVGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:06:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43043 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab0JDVGm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 17:06:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4008350bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=RjYramlMLgLS0ulalvscuqRN5q6KoqXQUg9miya4xOU=;
        b=wdR37Ep6tOjoAoeiLjm1GfmfxKsviLPFVTCqEBHrAXntfC4/5NKG787WRc7Ywnh/qf
         r0fWuVsInc+0ziXC6AhyC1qiE33tqpvMTAUGBBAu4dANiUZZG+nImT1url287n6FszP7
         2sDdTuDQL/41L38m/KYugLgfW/IdzhafIYqO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=aquhwxKTQuvhgqqMLIdH9hwcrtPPiN2a/D7SXvme88b35/xcVhnSjYnCZ3+ieqIhEk
         f4YpmR+uU8sDBgbtgEJn7FXMZ9JVKTDVRnCuZH49gsetgXz4tU8DVaadDs7cPdP+fl5W
         XeUuDdqrFWAP2aw3OeuQ1u83dZnPmwzXM4ml8=
Received: by 10.204.156.212 with SMTP id y20mr7397908bkw.179.1286226401382;
        Mon, 04 Oct 2010 14:06:41 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id f10sm4186282bkl.5.2010.10.04.14.06.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:06:39 -0700 (PDT)
In-Reply-To: <1286219189-22054-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Mon, 4 Oct 2010 21:06:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158119>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

[...]

> -	(Note: if you have shared the TopGit branch, the above command
> -	only lists the commits that were made in the current
> -	repository, so you will not see work done by your
> -	collaborators.)
> +	branch.
> =20
>  tg log
>  ~~~~~~
>  	Prints the git log of the named topgit branch.
> =20
> +	Note: if you have shared the TopGit branch, this command
> +	only lists the commits that where made in the current
                                    ^^^^^
                                   =20
You managed to introduce a typo while (mostly just) moving the paragrap=
h. :-)

=C5=A0t=C4=9Bp=C3=A1n
