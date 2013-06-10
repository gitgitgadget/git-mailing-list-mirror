From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/28] Follow perlcritic's recommandations
Date: Sun, 9 Jun 2013 21:09:52 -0400
Message-ID: <CAPig+cR1=32TwatmTdVBDnkpkhwtUNyKL_Z9f=V_FPtt_Y-xiA@mail.gmail.com>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulqce-0002Ud-MN
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab3FJBJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:09:54 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:45735 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3FJBJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:09:54 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so5242628lab.14
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jFwy/njlytzhIDYWjk+mgMwVJ5GjfyAH7xn3/nHSZdo=;
        b=UnOPB6HyiOg/6igWzMni3BbqLJpnU8ILdsXo5g6UFKcIjxyTb1tyWgVEcBE0L7hY6q
         EHZt5DoHrREh2sOe3laE1y6Fau1uVSnVjUkZgevqEMb+dJpcApXkkZPf/5Yiyt1G84N2
         0dlnn4dGWFxbd9+Wr9FEp//GJF8sSiklzOMLi1M682FJL9py/ts+PGvspagBaCf3iPNb
         ata/WtD3Ey458nvI+cRBMDSypE9KOblqXHon6z5e9hSPxxlXNa/qW3O5kNNqR7SwaIBl
         XNq/qM63+9CF9bhg48ca+9lBl/r5plmLBovFUuzIfkX2iswNz4kW4nPyrHBff51tqEni
         CB8w==
X-Received: by 10.112.159.202 with SMTP id xe10mr5365041lbb.52.1370826592442;
 Sun, 09 Jun 2013 18:09:52 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:09:52 -0700 (PDT)
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: RWWbR6DKvz31v22k15IwWyyrmZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227221>

On Sun, Jun 9, 2013 at 6:22 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Changes with v2:
> - Remove patch [02/22] about using the Readonly module
> - Split commit [07/22] into 5 different ones

This was easier to review after being split. Thanks.

> - Split commit [14/22] into 2 different ones
> - Patch [17/22] was *not* split: tell me if it is necessary

[now patch 22/28]

You, Matthieu, and Junio should decide, but I again found it
time-consuming and onerous to review with all the changes mashed
together.

> - Remove wrong change in patch [22/22]
>
> Patch about fixing a bug in a regexp (with has been renames "Make a r=
egexp
> clearer"), which had been sent as a separate patch, is reintegrated i=
nto this
> series of patches.

Overall, this series was more pleasant and easy to read than previous
versions. With the exception of minor comments, questions, and the
whitespace noise in 22/28, I did not spot any issues worth mentioning
in the remainder of the series.
