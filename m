From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/4] t/t0000-basic.sh: Run the passing TODO test inside
 its own test-lib
Date: Thu, 19 Aug 2010 12:39:54 -0500
Message-ID: <AANLkTin5XciuPCusghw4GihsYp2Lq8Ng1UcWACRrDy6f@mail.gmail.com>
References: <7vpqxhaw92.fsf@alter.siamese.dyndns.org> <1282138473-15613-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 19:40:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om96I-0001GY-Sn
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 19:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0HSRkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 13:40:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63461 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab0HSRkU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 13:40:20 -0400
Received: by gxk23 with SMTP id 23so851838gxk.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2naN8R4b7seK1vXHI/MI06bWCt0VdHcnATqGzTZxGoQ=;
        b=YEcOj2svy+5dxLC5cEIkMo/XK/Oxv6+tYYFGM0szuTUtLlXOQqiikG2Wby3KjMbcMS
         87eTZjV/ashvPw3gb4KNc/5uHbkcWX/ou4IFxcIYTYI0jEE+lb3zTHfvGt6LjJkdDHUR
         wVWxy+3Ix1+v3iu4EKYpLwE9NhUEAmkSpOaXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cn5YB8EZg84+2Yp0ReAxmB94Zk/ToHdQIdZtOYaMCqKD99AR87EE1wsKMOm9XUpBxh
         3odq3BIvbZzK+WQGWz0Igbo3y527WNmKcupX8H8kWKbE19e/etWRKhoyQAdY60iDpzC9
         Nl/yUu+JoNA5e0XmSGZ6TaS6Tsl7JtTUsIOlI=
Received: by 10.150.212.11 with SMTP id k11mr676438ybg.31.1282239619449; Thu,
 19 Aug 2010 10:40:19 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Thu, 19 Aug 2010 10:39:54 -0700 (PDT)
In-Reply-To: <1282138473-15613-5-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153945>

Heya,

On Wed, Aug 18, 2010 at 08:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Change the passing TODO test in t0000-basic.sh to run inside its own
> test-lib.sh. The motivation is to have nothing out of the ordinary on
> a normal test run for test smoking purposes.

I like the effect of this patch, but the patch itself is a bit obscure
perhaps. I'll defer judgement on whether this is acceptable to others
:).

--=20
Cheers,

Sverre Rabbelier
