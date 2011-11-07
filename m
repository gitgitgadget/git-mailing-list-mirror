From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 7 Nov 2011 08:24:34 -0800
Message-ID: <CA+55aFyKocxDUD2YhhBhfDzp+WHOddOZ_3mfqwADri86aUOUFQ@mail.gmail.com>
References: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <20111104145908.GA3903@thunk.org> <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
 <22879.1320652337@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
X-From: linux-kernel-owner@vger.kernel.org Mon Nov 07 17:25:10 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RNS0Q-0001Z6-Vd
	for glk-linux-kernel-3@lo.gmane.org; Mon, 07 Nov 2011 17:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939Ab1KGQY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 7 Nov 2011 11:24:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55110 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab1KGQY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2011 11:24:56 -0500
Received: by wwi36 with SMTP id 36so6952851wwi.1
        for <multiple recipients>; Mon, 07 Nov 2011 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=n0awxGr+SMOszzG2C7pHN6H0YBVM7FK3osLyoIpqRlQ=;
        b=kunwdtgCd7+GEYqNiGg1tulLHL8Vch7Nxpke73a40XyunIjaL/jo2HyJ05DPkqgPkV
         PpfiWWdppFgHHBihg2s6/61zAGtl+SLUHotJEkhF8pf/z8D8Pg+DRHz6b8curjT4ytsv
         LN3YjTXWG+iqYCfZz/beXk4fMRlbdqYDYC1jg=
Received: by 10.216.229.162 with SMTP id h34mr5188699weq.82.1320683095109;
 Mon, 07 Nov 2011 08:24:55 -0800 (PST)
Received: by 10.216.166.3 with HTTP; Mon, 7 Nov 2011 08:24:34 -0800 (PST)
In-Reply-To: <22879.1320652337@turing-police.cc.vt.edu>
X-Google-Sender-Auth: aEx0HHDuTR746Nu9BZVzrtQ1eOw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184991>

On Sun, Nov 6, 2011 at 11:52 PM,  <Valdis.Kletnieks@vt.edu> wrote:
>
> OK.. I'll bite. =A0How do you disambiguate a '42deadbeef' in the chan=
gelog part
> of a commit as being a commit ID, as opposed to being an address in a=
 traceback
> or something similar? Yes, I know you only change the ones that actua=
lly map to
> a commit ID, but I'd not be surprised if by now we've got enough comm=
its and
> stack tracebacks in the git history that we'll birthday-paradox ourse=
lves into
> a false-positive in an automatic replacement.

I don't think we are quite there yet. And (sadly) most of the commit
ID's in the history are 7 hex characters, because that used to be the
default git abbreviation. So there is unlikely to be any real
conflicts.

If we do miss one or two, that will be sad and embarrassing, but is
not a real problem in practice.

We probably could add various heuristics (the SHA1 values are *often*
preceded by the string "commit"), and a really good import would also
have somebody at least visually inspecting ones that other heuristics
say might be debatable (for example - because they have 8 hex digits
and there are other numbers around them that were *not* converted),
but in the end perfection is the enemy of good. It's not really worth
the headache to worry about *all* the cases, if you can cheaply and
simply get 99+% right.

And I think the 99% is almost trivial. While the last 1% may or may
not be worth worrying about.

               Linus
