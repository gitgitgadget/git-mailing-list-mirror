From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 22:53:50 +0000
Message-ID: <AANLkTikHvr7Xp8jST4wrtyhF3UY5hnvVsuEsr=D9byXj@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-4-git-send-email-avarab@gmail.com>
	<7viq2dgrji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCTk-00059i-Pm
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab0IJWxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:53:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61969 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0IJWxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:53:51 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so2627038iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 15:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h0qK4XhkM63X3ZnpYO/Z4nToWHe+rCdS7Sm67UuXNqk=;
        b=OopwtsebPJTd7WF7/RvZFEOmolG4cmc9bwnLlRNVaYcCzbz84lTzZb69Hb4MpWdX1I
         xMp73ldgXmo3p38JqClGFSmsBb0DbCP33OnNJuem+WHJTV3gFmeHXRWHI4LQvyZT3XcH
         UlrFmLYmDQCXDRSQhAu+rNJyfNn6pLEAcLrn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fFQbFllq/ipAkVNOfnOfzsmHsQLz8zlXpz1Gli+31u6c0jIfAH9be8UqOPP5q4V4Et
         LQg06x9kYFZVmXYamBRpeYvaX+ats7+yfZw8BUSKihJ9/wdFsTB3HJijyM3umeT2Se8s
         VUEU6jBOwHkesv9WYx+ZW71xf2xslh1dNpkdc=
Received: by 10.231.148.20 with SMTP id n20mr1643885ibv.196.1284159231024;
 Fri, 10 Sep 2010 15:53:51 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 15:53:50 -0700 (PDT)
In-Reply-To: <7viq2dgrji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155978>

On Fri, Sep 10, 2010 at 22:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> +C:
>> +
>> + - Include builtin.h at the top, it'll pull in in gettext.h, which
>> + =C2=A0 defines the gettext interface.
>
> Hmm, I would have thought that <git-compat-util.h> would be a much mo=
re
> natural place for this kind of thing, not <builtin.h>. =C2=A0Shouldn'=
t you be
> able to write a non-builtin Porcelain if you wanted to?

I don't know, I just put it in builtin.h for the builtin/*.c commands,
the rest of the porcelain stuff should all have gettext.h already.

Maybe gettext.h should be in git-compat-util.h, I don't know.
