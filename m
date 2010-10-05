From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-patch: use pretty_tree
Date: Tue, 5 Oct 2010 10:05:35 +0200
Message-ID: <AANLkTikXT=rzOJTTcNOsWkXctKOM3FzQ9ycVtOprLHGh@mail.gmail.com>
References: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
	<1286222981-28358-1-git-send-email-bert.wesarg@googlemail.com>
	<AANLkTinOOzY2wk3Z89D2K8qDuHZkj65L56bHr79q2jpT@mail.gmail.com>
	<20101005071849.GH11737@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 10:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P32Wu-0007um-3b
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 10:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826Ab0JEIFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 04:05:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46411 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab0JEIFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 04:05:35 -0400
Received: by iwn5 with SMTP id 5so8004578iwn.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GmiRNAYHaWbJjXy5PlVJ4zeT+a/k5gl7ebOixmHMj3c=;
        b=aXykpdVa9/Kr3zKfvws/wFdfZ2Z6vAr53d+uHKbnzj9kpg/HjXpo4jczlP3CTLm9XY
         QPrCNIM6cxNsIei5/dlWyywypYfUq+FTivUlGjM+j32BFIXCL4mJs4bqSvkWAQrL56A3
         mer/Yp/GI5LSIkU+AiUw+kSMkHwPsw/lp3iNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kti1NNJRmzQAlrIKOL/3kojW1AElFlUjeotj2f0SlL5IxxkdPOxFdYScfEsx+JaO0X
         PRgi6Frtcgt6yFm4VnwrzactOj3ArmdtLpZ3Lhnv2XDXyD/TGcagzRGIceZ04HfYz5PV
         5VydVKqyZ7gLba7AjRclXj6q+Cv1k/eEA91H0=
Received: by 10.231.170.208 with SMTP id e16mr11686187ibz.44.1286265935082;
 Tue, 05 Oct 2010 01:05:35 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Tue, 5 Oct 2010 01:05:35 -0700 (PDT)
In-Reply-To: <20101005071849.GH11737@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158177>

2010/10/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Oct 05, 2010 at 01:02:07AM +0200, Bert Wesarg wrote:
>> On Mon, Oct 4, 2010 at 22:09, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
>> > @@ -46,22 +44,32 @@ base_rev=3D"$(git rev-parse --short --verify "=
refs/top-bases/$name" 2>/dev/null)"
>> >
>> > =C2=A0setup_pager
>> :
>> > +git diff-tree -p --stat -r $b_tree $t_tree
>>
>> There is currently no color output and I don't know if a simple
>> --color suffice here.
> --color=3Dauto maybe?

I think it should depend on the color.diff config option. Is auto the
default, when this is not set?

Bert

>
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
