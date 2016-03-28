From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Mon, 28 Mar 2016 21:00:04 +0800
Message-ID: <CAKqreuzE6G0WO4gn2_R7-QfZYfVS2tuAMEnwiVE8FyNviJGD+Q@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<20160327220002.GA29057@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:00:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akWmH-0000uT-B9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 15:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbcC1NAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 09:00:08 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34370 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbcC1NAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 09:00:05 -0400
Received: by mail-oi0-f45.google.com with SMTP id o62so55620562oig.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=rpxqlGkzmNd0Pq3L/uEbiULufjoxs3BktzoyoJqrlrk=;
        b=dj3V8NoZWpAS2TVTzlXhY9gwOciP2W8o1hZCQFqpz7Bb6ZN/dHj/L9otE7wB+qYmDI
         XO6aUsv/DuDwFLrUUpLUwIdD60eLcDX1H/EX7J/LeB9Qo7kerqahwUXXzexWciE19gaA
         TFLjcsYvv1pWKGG4Po9qovHQQ5dTDCVydM4X9NCXooSRisq+Mra8qdR6tHqqkUgYtYBt
         rFYlaPL0Rf0PoRVEZbWmvO76D4krhCCtKydrXFQ9XNKjbJ+/MU1kkW+vFjTB8C4bapp8
         HWVlswbd0NxlVOzwxroEVpC9o0MQSn6UjTYMdKwSdrM/UguzXCTzKSfVyJwTtiWSOXLr
         hS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=rpxqlGkzmNd0Pq3L/uEbiULufjoxs3BktzoyoJqrlrk=;
        b=XyQghKuDaFV2hlyldLqFbQ7Y3AqKB0+q1cXW6GfpNeObODa3bPpUR/wXKEWNcETGxw
         Xqo7GfzxbsnZqmjLgoaRIHwya4D7PO+XooENmWtGevlHYdgHcjhAThAheK92h+rvHaOI
         MuFaN0scQBLeZapVTcelIo/6Afo1/6SwpNyS4BxuI0lFg1PaFSmYxMQ9i/bI7OjBk1tY
         0Mqa1RJh+zgPCqFMef2e27wu9t/ceFrmh3yZR9jHozGHDDy6aqin0kxZhc9FZGGpqaOK
         kGi9soEkfd1xxqR/XyJH1eYR/zbTZndDPAuFuo7KMfssIPpvp4M5RkFPrWPh3dG+lAYR
         K9+w==
X-Gm-Message-State: AD7BkJIZdNHFDUjSNYgoRfMbSdLIlps71LHODFLPgTdVmaEut9gKYg2sU+acCO77qaRBgO8eij4ePouW07l9qQ==
X-Received: by 10.157.49.116 with SMTP id v49mr12187004otd.97.1459170004199;
 Mon, 28 Mar 2016 06:00:04 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 06:00:04 -0700 (PDT)
In-Reply-To: <20160327220002.GA29057@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290031>

2016-03-28 6:00 GMT+08:00 Eric Wong <normalperson@yhbt.net>:
> Junio C Hamano <gitster@pobox.com> wrote:
>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>> > - Build a simple email client (maybe a web components based web ap=
p or
>> > wxwidgets based GUI client, they are both cross-platform) which is
>> > easy to use for sending patch without disrupting the mailbox forma=
t.
>>
>> I suspect it would yield a better result if the plan were to update
>> a popular email client and make it possible to tell it to read an
>> existing text file (i.e. mbox) without corrupting its contents.
>> People do not have to learn a new mail client if done that way.
>
> Another bigger problem is people rely heavily on webmail UIs
> nowadays instead of running any local mail clients :<

I know many heavily email user choose to migrate to client such as
alpine or mutt after using gmail for a long time.

> While Gmail provides SMTP access, it was (last I was told)
> incompatible with two-factor auth; so I've encountered users
> unable to send patches with their normal 2FA-enabled accounts.

That's the origin of this idea of `mailto`.

In fact, you could send mail via 2FA-enabled accounts via
"app password" metioned by Javier. But it's annoying to create
"app password" for every client.

If there is a `mailto` method to send patch, you could type something
like

    git send-patch --mailto origin/master..HEAD

Then, gmail is launched with the content of patch in it. You could edit
the list of `to` and `cc`(You could even take use of gmail contact). Th=
en
just send. That's all. No need to SMTP config or "app password" any
more.

> Maybe git hackers at Google have enough pull to lobby Gmail's
> web interface to make it easier to send plain-text patches;
> but I would love more to see users running local mail clients
> and even running their own SMTP servers.

Yes, this should be free with user to pick their favorite mail client.

>> That may not be a "Git" project, but GSoC is not limited to Git ;-)
>
> Completely agreed; email is critical to decentralized development;
> but I don't believe decentralization is in the best interests of
> any large and powerful corporation.
>
> IMHO, what we need is a SoIS: Summer of Independent Sysadmins :>
