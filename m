From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3] trailer: support multiline title
Date: Mon, 31 Aug 2015 11:14:29 +0200
Message-ID: <CAP8UFD3KH=5Y+Y3MKu7U-FkSTeu1qFkRYapne8LyNWVT_qF9iQ@mail.gmail.com>
References: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
	<vpqtwrfg8dt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 11:14:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWLAg-0004gz-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 11:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbbHaJOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 05:14:30 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36162 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbbHaJO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 05:14:29 -0400
Received: by iod35 with SMTP id 35so21457809iod.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iDLTfi6BMrMC6y4h0IbQWz7CpJth/Uu73U5cpw1geG4=;
        b=n78qEInS2PdGT9641slHj7ylC9Fxbo8pSSfXk4WukcVpMNx1g9bGj9cpejwsYaBY7f
         x4XjbZ8tGilF7Rg+F82m3PrtUfEefrpRS5s4A+ultl+UiqhC2mkn5g/zp8CzT5+/XmGB
         KbdUr/6MjOrTDfJdTL7jR1KQ7NCJ2/56RbPRwO/8DBUGPWXbOYxmSKkAH3E8xxajsoOr
         AGKo1LR4pLqryGGf2mPlMHmXfFl74FMnSFQQSUC36SEmS6TSSI2i94kga2XXQtz2xogE
         BvgvKef5QvvMdnlC0v4ivIgx+31iRanpxTzJc4AxdlMOvelGQ6/uQrr7JAkSIx2Gc+TV
         56rQ==
X-Received: by 10.107.14.84 with SMTP id 81mr27813356ioo.195.1441012469445;
 Mon, 31 Aug 2015 02:14:29 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Mon, 31 Aug 2015 02:14:29 -0700 (PDT)
In-Reply-To: <vpqtwrfg8dt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276859>

On Mon, Aug 31, 2015 at 10:38 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> That's why instead of ignoring only the first line, it is better to
>> ignore the first paragraph.
>> ---
>
> Lacks sign-off again.

Ooops, sorry.

> This replaces PATCH 2/2 in your previous series, but requires PATCH 1/2,
> right? If so that would be simpler to resend both patches IMHO.

This first patch is already in master. That's why I only sent the
second one. But yeah I could have explained that after the three
dashes.

> The patch works for me, thanks.

Thanks for reviewing and testing,
Christian.
