From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 02:24:17 +0530
Message-ID: <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com> <877gjrpsk4.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6ig-0000dy-NC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab3DXUzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:55:00 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46854 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759Ab3DXUy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:54:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so2732876iea.10
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hybte0l3mv7WAtoZAvbQ4mh6gR9hrQuXl/RTC9+j5z4=;
        b=vaA4gPswm6HEPqKJILyci7I2zQm5MrFis5QcgziNcqdt5Olq79IMrIdWFckI42k3XQ
         gVtiii06dKOfkeETWyrCdkZm3SPqZJCy7WmeQbiFvSRHRt6EP4+ZOGgqIFFiHkN+K7vj
         SKPuTpUWToxJUshiCrzAoixkObARK13AzYmFtHBZ2KBfuMNA7fMZTX6XiDPwGMRzXoao
         mPL53P+1YdZfDS4rghs47c//sDRHq+7R8dHlHng+i6Ms2GvcCU8Ooi3kQr7TZ95F95Ny
         l4A5frq5ICjpFYuM0URZQKkuQgWfMrR7rSEiYCAvGheP5WNhBpIkfDB6aAT40EhZvJaw
         cEPQ==
X-Received: by 10.50.55.73 with SMTP id q9mr23566300igp.44.1366836898365; Wed,
 24 Apr 2013 13:54:58 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 13:54:17 -0700 (PDT)
In-Reply-To: <877gjrpsk4.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222321>

Thomas Rast wrote:
> * Looking for the nearest fork point is expensive and subject to change
>   by simply fetching.  I hope you meant "... and exclude its upstream",
>   i.e., A defaults to @{u}, which might be at least somewhat useful.

I'm not proposing anything different from :/ in this aspect.

> * ~ is already taken; in your syntax, A~1234567 is ambiguous because
>   1234567 can both be a SHA1 and a number of generations to go back.

I'm not married to ~.  It can be any character.

> I personally think we have enough magic revision syntax to last at least
> another decade.  If you propose to add some, please make a patch that we
> can cook in next for a few release cycles and then conduct a straw poll
> if people actually use it.

Isn't it obviously incredibly useful?  I'm working on a topic branch I
need to send out to git.git, and I want see how my WIP looks: should I
have to rebase on master just to see this?

Why such a huge resistance against such a small feature?  Can you
think of ways in which it is myopic (and therefore a pain to keep
supporting, if we find it undesirable)?

On a related note- In my opinion, :/ is broken, because it blocks
composition completely.  I would've really liked {:/quuxery}~3.
