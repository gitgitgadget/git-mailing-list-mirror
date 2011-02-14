From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 20:44:11 +0100
Message-ID: <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net> <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Lz-0004V3-1x
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab1BNTox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 14:44:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42872 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1BNTow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 14:44:52 -0500
Received: by gyb11 with SMTP id 11so2229673gyb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 11:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=n+VaYCdJN8PpBwUx0V6KrycvIeXN1lI/QiZ2r8Pre3I=;
        b=CPPH+CZl0Q8IpQwgED3ch1yV32QAt1e+DJsu6akrHVdDm/lKtWxX4cRnwCxmbvTLKk
         IovTT4tPeYogPfHRdfUWv8CH1myHjq3tKtylXG3fwlEfqddpmmAVwl45nSLvvJJkzuUL
         LEmJ6zmtwYSRZvOvDH80XXLBU5SI3Cka2784U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D2JonShU6Riwx9dA7MgUHPrPEToVy73jlKViVvR2DVkxcOjsChjc+srWBNrijBjs7Y
         BJyNci83EEg0dQzitHtQYFwORjW2TSZiz+4CiIzS1uySntbXDm7apET09ZC0o3Qg82jw
         rnpU9stp01BVE2Wzfk2hxi8FDEUKG5ql1nT3o=
Received: by 10.150.198.8 with SMTP id v8mr4842180ybf.393.1297712691418; Mon,
 14 Feb 2011 11:44:51 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Mon, 14 Feb 2011 11:44:11 -0800 (PST)
In-Reply-To: <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166755>

Heya,

On Mon, Feb 14, 2011 at 19:53, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> =C2=A0push.default is unset; its implicit value is changing in 1.8.0.=
 To squelch
> =C2=A0this message, set push.default. See push.default in 'git help c=
onfig'.

This is worse than what Junio suggested because it does not tell you
what to set it to.

--=20
Cheers,

Sverre Rabbelier
