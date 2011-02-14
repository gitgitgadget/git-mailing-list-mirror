From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 14:50:17 -0500
Message-ID: <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net> <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com> <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
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
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:50:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Rh-0007mc-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1BNTuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 14:50:50 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45997 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab1BNTus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 14:50:48 -0500
Received: by yib18 with SMTP id 18so2225465yib.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=EMgBHKXenYhJV1t/hOPQpQf9YMDFXfc259hAenC64kU=;
        b=OvIT8XB099J2vI+slr/g7yAnkKW4ayCCEXnCRg00kl90PbkuwUonE6q+slmKH+rrK+
         ZK09SdVLFuvc3rXJjfvBuVVFDbBrgk0wYg/8kLnC1EIJ5BKQXoFyLIY80W4denSh9F4r
         9Al/d/cR2MAie/5C+r0QUigKH9CZz/W759Rdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BWDzTqQe2ACe17b0DYlx/e4huWN1ygom7V/5lOYhfDNgKTZ0GxqEwQft9byaFpwVKF
         ErBSx+D5KZUF84X9puHoCIurDm7K8ZGTKV1Wo2/DKrZay5lh2f42qYq26TzPU+WSjs24
         IRpIyKudFkjdC/48OKGMv3IaA6Te3RcJ8JgNA=
Received: by 10.42.230.74 with SMTP id jl10mr5564699icb.177.1297713047875;
 Mon, 14 Feb 2011 11:50:47 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 11:50:17 -0800 (PST)
In-Reply-To: <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166759>

On Mon, Feb 14, 2011 at 2:44 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Mon, Feb 14, 2011 at 19:53, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>> =C2=A0push.default is unset; its implicit value is changing in 1.8.0=
=2E To squelch
>> =C2=A0this message, set push.default. See push.default in 'git help =
config'.
>
> This is worse than what Junio suggested because it does not tell you
> what to set it to.

Which was intentional on my part. If the message says what to set it
to, the beginner will just go 'okay' and set it to that, in which
case, what is the point of changing the default? Hence pointing to the
man page.

Alternately, you could take the wall of text approach, which I was
trying to avoid:

  push.default is unset; its implicit value is changing in 1.8.0 from
  'matching' to 'current'. To squelch this message and maintain the cur=
rent
  behavior post-1.8.0, use 'git config [--global] push.default matching=
'. To
  squelch this message and adopt the 1.8.0 behavior now, use
  'git config [--global] push.default current'. See 'git help config' a=
nd
  search for 'push.default' for further information.

j.
