From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 0/3] Add support for SMTP server options
Date: Sun, 5 Sep 2010 20:34:05 +0000
Message-ID: <AANLkTikH1nkVftN7fADWoMbocYVZ+MexSoFYWHjUUK-M@mail.gmail.com>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:34:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLun-0000Cb-8R
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab0IEUeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:34:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56297 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0IEUeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:34:06 -0400
Received: by iwn5 with SMTP id 5so3543845iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nxJfM7AjtTe5ZQDubWE9Z0XOpyl0DkH14xyhpVM0WNc=;
        b=bESHLqWNt+/F22lvXoUA1qCTK0znkXFhtwNgaT7aQyGYLO8ZoKr7LmrrkzSHt3juPg
         WiOMOI1GN/+C+ShZphDKhEPBy745avbIj/Mbh2ZlM/SN8/AsHlOvDlugzYd11/rWB4Dt
         S2it3l8qx90N4MJrCm3ADGgw0Qng1/+COgdHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RUwNprM3n1LeCouXXeylcDztZ2CZXkuZWHuneHtQrhTmtHEDFgxgZOBxB4Yiu5Y/gg
         k90fkAPUNt4299rRzBZMgc7y6hdeOWhG2gzW6/g6WlsaMnxP8iIXpaRlQShs+A/0UQuW
         P/oV6N0mUUlYmjBKqEoMT+Zw8h8DHRs5i2Y2Q=
Received: by 10.231.146.129 with SMTP id h1mr5033370ibv.181.1283718845723;
 Sun, 05 Sep 2010 13:34:05 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 5 Sep 2010 13:34:05 -0700 (PDT)
In-Reply-To: <1283708940-2172-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155485>

On Sun, Sep 5, 2010 at 17:48, Pascal Obry <pascal@obry.net> wrote:
> I'm not familiar at all with Perl so comments on style or usage most
> welcomed. This patch is to introduce a way to pass specific options to the
> SMTP server used by git-send-email.
>
> I need that to be able to use different SMTP account (wanadoo, gmail...) on
> some Git repositories to send over proper identity.
>
> This is v3 of the patch thanks to Junio and AEvar for the review and help.
>
> The two first patches are really code clean-up found while working on this
> new feature. The last patch is the actual implementation of this new
> feature.

I looked these over and they look good, thanks.
