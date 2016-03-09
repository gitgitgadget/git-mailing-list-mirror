From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Wed, 9 Mar 2016 07:18:31 +0700
Message-ID: <CACsJy8AgPQ__aVgoJc860yapWs_rTbXfBuGSBNRG-FT+v+rK1w@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com> <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
 <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com> <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:19:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adRqM-0003qL-Qt
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbcCIATG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:19:06 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:32775 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCIATD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:19:03 -0500
Received: by mail-lb0-f171.google.com with SMTP id k15so42522624lbg.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=szS+nkDOzSOPv6eSkoRaUQULfBtNHlRHOVLjN4Ip2CY=;
        b=a0jcZo4kOQWk/8LrSlL0dmN/II/Y4LWoxq3Gh4DOMMvrs77p5sbE6hqZLeMphKlYCN
         vfeN3TpaXDRPhIC2QRkqBQO7WEDTXVNFQ05HUFw/atSJVXzUopYRyWCHW1wOQgS5uOic
         K+WQc+J3wui0gSTPAyOctzh8tOq0hYDe1pmAOIxmi7tFMceAeI+izSL1SMmgMpxOrMbL
         i2p5us6WFYM7C2tCDE0IQVuL3VcDCHzd9YYHQwuAcvDUhADPpR8S7IXsfeAeG8DWKWQX
         QKTUFcres+R40kuNvXD6uGym8lhtldXqO8W/Vjmgiok9I4kLyT3mYU5xzr3/uhjztRxJ
         yL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=szS+nkDOzSOPv6eSkoRaUQULfBtNHlRHOVLjN4Ip2CY=;
        b=JtlOmE5oo6L9L7aZfqfWYLJacPeAPasTlg6T+nsIyRmCQdsIyJ0LaJD0zdJW9AfOUi
         ZNyZLY1dxobiA19YRitds0hioPpx4ScFBONmYe8Z96wd9PpSBffFFZoqJNY8Us72C5hf
         Sss5anUGzxklcOEaICXPzsi70McqVLOYw42ZwdTdi/Vrs88oNe6dWfMKiGnxV4P5/QC8
         4z8R2ZOPcHNegFWoJofdhRGiPnz1xWuQmRsTh+WJgMC6VOtwIl0gjNtwq6vOw9NzHFlf
         KxsJPd5LkDNEs/kzqBES4XTrQ7dcZ96TWg682Vch4BO01gFe5pYX740ZwHuVxJTc/DGd
         PJiw==
X-Gm-Message-State: AD7BkJIM9nrfTHOl6M2zMp3WKbhJPEqQUrLuoQ3XDxWtQ6E0yfs21fqzqgH18xYMuaw/ZOUkSlVpwoipXknEDw==
X-Received: by 10.112.209.99 with SMTP id ml3mr10348550lbc.26.1457482741394;
 Tue, 08 Mar 2016 16:19:01 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Tue, 8 Mar 2016 16:18:31 -0800 (PST)
In-Reply-To: <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288463>

On Wed, Mar 9, 2016 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> So what do we want to do for the upcoming release?

I don't know. Befoire 2.8.0, all three matching cases are broken. With
the current changes on 2.8.0, one case is fixed with the other cases
broken. I guess it can create even more confusion. Yeah documentation
helps a bit.

> I am OK to leave
> the code as-is for now and describe it as a known bug that is still
> being worked on (as long as it indeed is being worked on, that is),

I do want to fix it. I don't know how much code is impacted yet (and
how many more bugs I'll be introducing while attempting to fix it). It
may take a few cycles before the fix can be released.
-- 
Duy
