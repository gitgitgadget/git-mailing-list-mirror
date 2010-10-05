From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [TopGit PATCH v4] tg-files: list files changed by the topic branch
Date: Wed, 06 Oct 2010 00:02:45 +0200
Message-ID: <87k4lw1enu.fsf@gmail.com>
References: <20101005071723.GG11737@pengutronix.de>
	<1286305402-28284-1-git-send-email-bert.wesarg@googlemail.com>
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
X-From: git-owner@vger.kernel.org Wed Oct 06 00:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Fc7-0005aQ-8d
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab0JEWDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 18:03:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0JEWDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 18:03:46 -0400
Received: by fxm4 with SMTP id 4so810136fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=K+8ogZZ6mNsEyCdkEs6IjSqzPsDTNQgbqX6DiXoPV1s=;
        b=Y1dy4yh1bskYOgOMd6MKe0GcDimzStwrQnB6Hb2p8rs3lqiQpbRqZGhvaz7TDYLIBO
         3EpN5+yPPntGz5c30UJE1lPl1UwzG+NbOePjyMN/lIeHt7VYHz7J2Xur+YWD+pj3pH6o
         yu4WUUux99LTd2u0Z5fBVkuAT0wtVxLLVXSiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=NUYEZgoMRzfGL5dODXQbjQ8KoggrSoKGYRBpUIc18zB0bR7wu/cUdOxdDJsXnW0m2V
         somKK3UKsS9YDxjNaxG6qxymvceIYKWGVyB+ECdp08Pbf/CXVhHC/w2Y0YtHn15tE8or
         N0v5K753pKc2TAfSSn0q4rJMeyWxW4+hMFYFs=
Received: by 10.223.59.217 with SMTP id m25mr11478533fah.33.1286316225406;
        Tue, 05 Oct 2010 15:03:45 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id f28sm26140faa.0.2010.10.05.15.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 15:03:44 -0700 (PDT)
In-Reply-To: <1286305402-28284-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Tue, 5 Oct 2010 21:03:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158252>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> this could also be a --name-only option to tg-patch. But I Like the
> similarity to 'quilt files'.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
>
>  Changes:
>   v4:
>    * apply Uwe's suggestions

[...]

> +
> +
> +[ -n "$name" -a -n "$topic" ] &&
> +	die "$topic are mutually exclusive with NAME"

=2E..so, "are" should now be "is", as $topic will be _either_ `-i' or
`-w', not both.

=C5=A0t=C4=9Bp=C3=A1n
