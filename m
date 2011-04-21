From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Tabs and spaces
Date: Thu, 21 Apr 2011 12:57:38 +0000
Message-ID: <3d145d51-e76d-44c7-b9b2-7b48c14b6043-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
            <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
            <20110421000701.GA10987@elie>
            <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
            <20110421021825.GA23373@elie>
            <BANLkTi=XqynMpRkR=cRMTXYjr+p=Jxt=Ng@mail.gmail.com>
            <BANLkTin4kD96Fw_hpJCGW1K8Khfc=A=n_Q@mail.gmail.com>
            <BANLkTimgVCh19saLiJJfFnoWKny8-MiHrA@mail.gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCtYK-0000v7-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 15:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1DUNEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 09:04:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56721 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab1DUNEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 09:04:05 -0400
Received: by wya21 with SMTP id 21so1406291wya.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:references;
        bh=60MtjPbHoZiWa1yU6wjdLcdpY4pFwyrRFIxE/aAg8nA=;
        b=k+Ug1P+yCTrtI3fFMc9Ac66MuxobQIRid2QDV1xBvKfaq3zx7D/UR7DC1pHMTb6XJH
         N2GisArO7CW11wrmOo3XYDUDmZh05gyCRUfAqXXxwIBfSAUffcgY9ehjowMc47+tpM3l
         W0BUCjVUjMCAKuFJJS3ru35dCXPi4iKWF/sRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:references;
        b=Sv6KOgIWeWSyrVZ1iYHLdO3NM2Y4VEhl50eJE0vpz65UhB72d4nkWgfKObKO/8KHjC
         LT10RM7alkw/Wt0U1jzkwV0mmwQWkwlrvfHG4zfa8rqSasRxsBAYhbUJi3IHqSKIhmHd
         gtNguzvpWMeCDVRGdYqgf8zdr+CgHDPkFiPRA=
Received: by 10.217.5.202 with SMTP id w52mr956911wes.91.1303391044174;
        Thu, 21 Apr 2011 06:04:04 -0700 (PDT)
Received: from gmail.com (morales.torservers.net [195.60.76.241])
        by mx.google.com with ESMTPS id h39sm956100wes.5.2011.04.21.06.04.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 06:04:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171905>

On Thu, Apr 21, 2011 at 10:46, Alex Riesen <raa.lkml@gmail.com> wrote:

> On Thu, Apr 21, 2011 at 05:25, Thiago Farina <tfransosi@gmail.com> wrote:
>> On Thu, Apr 21, 2011 at 12:15 AM, Michael Witten <mfwitten@gmail.com> wrote:
>>>> Oh, I still think a tabstop of 2 is insane (for various reasons, some
>>>> explained in the thread you mentioned).
>>>
>> tabstop of 2 is what we use on Chromium code (with spaces, no tabs).
>
> It's indentation. You indent your code by 2 space.
> It has nothing to do with tabstop.

In this discussion, it has everything to do with the tabstops
(1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com):

> Again, it should be recognized that there are 2 issues:
>
>        * Indentation : This *can* be implemented with tabs
>        * Alignment   : This *should* be implemented with only spaces
>
> and it should also be recognized that treating tabs as a primitive
> means of space-saving compression by having it always represent
> some constant number of spaces (8) is just as flaky as expecting
> people to properly use spaces for alignment; thus you might as
> well go for the latter in order to get the best of both worlds,
> because somebody is going to mess it up either way.
