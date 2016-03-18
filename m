From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Sat, 19 Mar 2016 06:09:43 +0700
Message-ID: <CACsJy8BiXLXuU1CNJ3sdo1JVDGYN7fQXu4G1effN+NwGAKCq_g@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
 <alpine.DEB.2.20.1603151517590.4690@virtualbox> <1458151880.9385.1.camel@twopensource.com>
 <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
 <alpine.DEB.2.20.1603171536420.4690@virtualbox> <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
 <alpine.DEB.2.20.1603180752540.4690@virtualbox> <CACsJy8Amdr-2WqwYjYjyaag0jR_pq=h36QFKMk3BYQmE_A-DOw@mail.gmail.com>
 <1458321734.9385.26.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 00:10:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah3XQ-0003gN-SC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 00:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbcCRXKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 19:10:17 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35906 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbcCRXKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 19:10:14 -0400
Received: by mail-lf0-f51.google.com with SMTP id d82so28815352lfe.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fuOdxz3mB9X7e2iOqQQHuymxzMJl4pIeQ3lmhryT8Ik=;
        b=UZL15nF9Ww1DoONL0QhFfFSkUTXV502d3Ck39R9c5KPTyq24CEmaCzG+INhVEXD0iA
         1zqiS5wgqosRKEIoPWI6pMqr4WjdSWdYRW+mGsnbljuPCDIS0dORhcgcTKnkvwPEJnQr
         Iu5RoR+Tinzq1zEhtkvsp6rSySskfhqmYz2LnD0E6EZyF2M/lsQONFTe+gfD61NwadCE
         esBgfDtgs+RY2mW0y4qRfZq9Bd+2rWz9Qgn3ZFFFHFfJhd2lUO82NAGp5uZzOLPRKRtB
         eA3YatKU8FEliT3nytzJovQhljk980R3YYXtsLuWyUZQeBd+CM/tW4y72FJctb36Wo0P
         D0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fuOdxz3mB9X7e2iOqQQHuymxzMJl4pIeQ3lmhryT8Ik=;
        b=j9yO6m4Sk82H2MXauzAGOHSO2UT7IsPQzgXRveXYw3fTmxTicdIm74TeL22vNIZaiQ
         6/AkNHbwM6wm82E1qzE+1YwIrQTmk/ofhJIZUsDP8L7NY3iZ5ZxTYbBifb+FJHZOL66v
         6rlTjEjaYBmya6zIMei9r6G2ZzfmlxkYMOXJy82W96jBvF0wsEHvxXcxf4NLwUNvJITW
         sGs6BmPlC37WHDL7RpxP0dAcpWutJt7ttbAAeyL0tGgD0pJZBBo8VCnS4VC7d+Np40tQ
         MVwjciCO4ioKdz8AwcgXo6BdQj9KtxtnEiOaSWRMC2BjPqS7+bjyClia0hE+wW+MA7f0
         iB4A==
X-Gm-Message-State: AD7BkJK+7+ua1/8w0Rk5Zhkh2vBUbdrkFEOCZLUvwjxUFjCM4zda5163mvy8VPVfZLe2lOuQKm1Vms3RjaJ+aw==
X-Received: by 10.25.211.75 with SMTP id k72mr6765605lfg.45.1458342612721;
 Fri, 18 Mar 2016 16:10:12 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 16:09:43 -0700 (PDT)
In-Reply-To: <1458321734.9385.26.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289265>

On Sat, Mar 19, 2016 at 12:22 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-03-18 at 14:44 +0700, Duy Nguyen wrote:
>> > So yeah, this is the challenge: to make Git work at real-world
>> > scale
>> > (didn't we hear a lot about this at the latest Git Merge?)
>>
>> I'm all for making Junio cry by using Git for what it is (or was) not
>> intended for, but this seems too much. A repo about 500k files or
>> less, I think I can deal with,  not those in million range.
>
> Sad news: Facebook's repo was already getting towards that size three
> years ago:
> http://comments.gmane.org/gmane.comp.version-control.git/189776

I've been doing this for too long I forgot about numbers in that mail.
The good news is I also forgot that I tried an artificial index of 200
MB nearly two years ago [1]. 100ms read time from that test is not
bad. But Johannes' point stands, it will hurt if index-helper is
bypassed at this size.

[1] http://article.gmane.org/gmane.comp.version-control.git/248771
-- 
Duy
