From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 21:11:32 +0100
Message-ID: <cb7bb73a1002071211n23a410f9icc3d4d29179c44ca@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002070248.03855.johan@herland.net> <cb7bb73a1002070314t4f382d31k91423eac00a68715@mail.gmail.com> 
	<201002071341.36440.jnareb@gmail.com> <7vock0evs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 21:12:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeDU7-0003hX-R4
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab0BGULy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 15:11:54 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:62566 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab0BGULy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 15:11:54 -0500
Received: by ewy28 with SMTP id 28so1823525ewy.28
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EyxR6n8DfWWl0Wul++oJrQM8/GgsY17Ziizb7Y4UK9s=;
        b=v10TRJ4yV2qTWi5yhdU1xW21yxgTJu6/ji0QW8hcFa3HOhJUj+DHLotwcuTSxoty50
         rh4qYjUlLy68Fy3Or3GcJfe1f9eboDw+xdLESbRDIJDIjFVXFmjuRE9u8gOrH/T5BTw8
         crotYnbWpZknMTiSU+3ZtAbdFBWHwEuDWE6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FxMT0KRipIpmW/+lQJO+U90vybmnHs2Yop4qeFYGi+V2NgJ5supfK655DVF4Hax5UM
         rG0g/5oeiAlDQRaI+5NyYUHt1kIVN2/W4SUrDp/4Ea02MjqAajlnlWlUMmTjkL5ldqIX
         K1+R2PhWYgqt46Jz+8x9Un2MiKCeY+Q1a+3Sc=
Received: by 10.213.1.23 with SMTP id 23mr3700674ebd.98.1265573512341; Sun, 07 
	Feb 2010 12:11:52 -0800 (PST)
In-Reply-To: <7vock0evs8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139251>

On Sun, Feb 7, 2010 at 7:38 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Notes are fundamenally metainformation about an _object_ [*1*] and ar=
e not
> metainformation about refs. =A0Since whatever magic notation to denot=
e notes
> we choose wants to be applied to an arbitrary commit, it shouldn't be=
 the
> at-brace syntax.

Makes sense. ^{note[:namespace]} is ok for me too btw, although maybe
it looks a little off-base when compared with the tag indicator ^{}
which works, in a sense, in the opposite direction.

> [Footnote]
>
> *1* Yes, I am aware of movements to misuse notes to annotate anything
> after mapping it to a random SHA-1 value, but I think that is outside=
 the
> scope of notes. =A0Our design decision should be based on supporting =
the
> primary use of annotating an object, and that might still keep such a=
 use
> working, in which case that would be an added bonus. =A0But our desig=
n
> shouldn't be constrained by such a secondary use.


BTW, I still think that notes should be attachable to named refs (not
SHA-1, thus) too.

--=20
Giuseppe "Oblomov" Bilotta
