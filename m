From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 13:53:47 -0500
Message-ID: <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net> <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 19:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3ZL-0006M1-J4
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 19:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1BNSyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 13:54:20 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50708 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab1BNSyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 13:54:18 -0500
Received: by iwn9 with SMTP id 9so5111557iwn.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=G9jGoiTOvd3Jr/KwA4DvZy/OrS4r8W9bk4UE5WwqNfQ=;
        b=vDl4UGt6nTevVS7NNkcbnMqZ/MDzPQ6lHrF0HlKB9TrX0SKur6MbnlLmrfZgU6tJHM
         1uTM0U2i+WlY69YHerBpAXvjjOZ/x/bBuRfLtoS4DrKZbn3GdnT5e/Ke50v0GX0Yxy9S
         qqvbvz0LlaU41JMm6nKho4h+kclaHwcZ6MhHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QjRkNfqc+bdOnrHYlluNuWKWB3llO2r4JvPs9chCJaCoaTIozfB4AgTl9wQ8tE1zuQ
         IQoTpUPr9vTSIm5UPhCU5iwIV2KxOo8vRxFATdMfu0H2oupg7Witm/C6bD/8oGr+92ZM
         6pQ5Wfgs11A8Zv/3wXn1td4ogkvQ6LtcvombI=
Received: by 10.231.38.2 with SMTP id z2mr3173464ibd.142.1297709657365; Mon,
 14 Feb 2011 10:54:17 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 10:53:47 -0800 (PST)
In-Reply-To: <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166747>

On Mon, Feb 14, 2011 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 warning("You do not have an explicit 'matching=
' setting for push.default");
> + =C2=A0 =C2=A0 =C2=A0 warning("Your workflow will be broken at 1.8.0=
 unless you do so now");

That message seems like it would confuse a new user. This seems less
confusing to me w/o becoming a paragraph of text that no one will
read:

  push.default is unset; its implicit value is changing in 1.8.0. To sq=
uelch
  this message, set push.default. See push.default in 'git help config'=
=2E

And update the git config man page entry for push.default to note that
matching is the current default behavior and current will be default
behavior starting with 1.8.0

(Aside, it would be nice if "git help config push.default" did what I w=
ant. :-)

j.
