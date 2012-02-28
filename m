From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree Ready #2
Date: Tue, 28 Feb 2012 17:42:45 -0500
Message-ID: <CAHqTa-2An1Vge-_Zjc8f0ZdgNo3Yd72YxEMSAKQkRaHfJ65n+A@mail.gmail.com>
References: <87ty2ro1zf.fsf@smith.obbligato.org> <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org> <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
 <7vobsox84l.fsf@alter.siamese.dyndns.org> <CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
 <87hayfv75y.fsf@smith.obbligato.org> <7vy5rrfft2.fsf@alter.siamese.dyndns.org>
 <87ty2ft0tm.fsf@smith.obbligato.org> <7vobsk56md.fsf@alter.siamese.dyndns.org>
 <20120227212157.GA19779@sigill.intra.peff.net> <m3ehtfvhkv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 23:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2VlJ-0004yc-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 23:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965907Ab2B1WnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 17:43:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55920 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2B1WnG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 17:43:06 -0500
Received: by ggnh1 with SMTP id h1so2880332ggn.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 14:43:06 -0800 (PST)
Received-SPF: pass (google.com: domain of apenwarr@gmail.com designates 10.236.79.202 as permitted sender) client-ip=10.236.79.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of apenwarr@gmail.com designates 10.236.79.202 as permitted sender) smtp.mail=apenwarr@gmail.com; dkim=pass header.i=apenwarr@gmail.com
Received: from mr.google.com ([10.236.79.202])
        by 10.236.79.202 with SMTP id i50mr31915109yhe.61.1330468986479 (num_hops = 1);
        Tue, 28 Feb 2012 14:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7S1r89Uvacgu45RMdAC3fY+uYo99oAmU2dnpdKr9tOc=;
        b=fIpjv+NRQYXwomphbOpIyc/1L55S5vUcXudSjokIizhvNUece5FH2xTC9FDDJlNZbr
         SXQ3rpIsTmmfxLsd1WeeUAVDMkEiXGYV/g9jpTRyMbAauO1VINb2N+mKHPYD9q9jaeIa
         OyMAIwoc4z1cL0mSeUYc3Kx/A6lAzxsMYGxF0=
Received: by 10.236.79.202 with SMTP id i50mr24148932yhe.61.1330468986428;
 Tue, 28 Feb 2012 14:43:06 -0800 (PST)
Received: by 10.147.182.2 with HTTP; Tue, 28 Feb 2012 14:42:45 -0800 (PST)
In-Reply-To: <m3ehtfvhkv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191788>

On Mon, Feb 27, 2012 at 9:04 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>> Yeah, I don't see much point in rewriting. If parts of the history s=
uck,
>> then so be it. =A0It's probably not that big to store. And while it'=
s
>> sometimes easier to fix bad commit messages when they are recent and=
 in
>> your memory (rather than trying to remember later what you meant to
>> say), I think it is already too late for that. Any archaeology you d=
o
>> now to make good commit messages could probably just as easily be do=
ne
>> if and when somebody actually needs the commit message later (emphas=
is
>> on the "if" -- it's likely that nobody will care about most of the
>> commit messages later at all).
>
> Anyway we already have subtree merges if subsystem with bad error
> messages -- see gitweb.

So be it then!  May my lame commit messages persist forever!  As if I
don't have enough embarrassing stuff on the Internet.

(Personally I think the vast majority of the commit messages are
perfectly fine, and the ones that aren't generally describe boring
commits anyway, like changes to the 'todo' file.)

Have fun,

Avery
