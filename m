From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 12 Sep 2010 22:44:41 +0000
Message-ID: <AANLkTi=0S=fAosE6Ejp=cJiMuMsi6o-cS023tQTL5MC1@mail.gmail.com>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
	<20100830030819.GA25415@sigill.intra.peff.net>
	<AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
	<7vmxrmd57r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 00:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuvHz-0001nY-Tn
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 00:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab0ILWon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 18:44:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65027 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0ILWom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 18:44:42 -0400
Received: by iwn5 with SMTP id 5so4494070iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ScQbEclgg2Nlbr5YAPxhggA6LhYtLgXJqYUpHd+COjY=;
        b=cvKJOCSHz1DEyUedQbgDvPVnTCQAOXy+M5pL3t9kYlYqaRP8QXXj6fGyb/p6/y1Zu/
         wUvgXuFy41Xgf9RQl1TB+HY9n5mU/l6zMR7e60f/aabqhaKtfRk1FFG566dknPiSoOkc
         cT/7bWNkTEXZmgrleObPWLb/zbcDmHwNdxNBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SnQkzx9AYfIJWkWpGz3r1Uii3LfNOnHKdn+VlME3w/j2xhxZqYVrt/sqOMsTPJXTQN
         4c2HTsnso9+rfYZWawBI4tgQgMraAJgrNjRLdaIZ/y744WxgLA6iQOXKwqbonBsfnPso
         HUTO6Iq0gQXsRAQRpqBXRujBrcbJDXPNUFsL0=
Received: by 10.231.151.198 with SMTP id d6mr5084435ibw.86.1284331481904; Sun,
 12 Sep 2010 15:44:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 12 Sep 2010 15:44:41 -0700 (PDT)
In-Reply-To: <7vmxrmd57r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156062>

On Sun, Sep 12, 2010 at 21:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I just like the UI of having each commit "pop up" where I can either
>> page up/down within the commit, or dismiss it with "q" and go to the
>> next one.
>>
>> You can't do both of those in a pager, up/down goes across commits,
>> and "q" quits the whole pager.
>
> I would throw this not into the incomplete scriptability category but=
 into
> the "user does not know how to use his pager" category. =C2=A0With "/=
^commit .*"
> you can not only advance to the next commit with "/<RET>", you can go=
 back
> to the previous one with "?<RET>", and keep going in the same directi=
on
> with "n".

That was already suggested, but I prefer not to see anything else in
the pager myself. E.g. if I have a large terminal window I want to see
*only* the pertinent commit in that entire window, nothing else.

Which is why I still use my git-review alias.

> wouldn't be much of an improvement over "git rev-list | xargs -n1 'cm=
d'"
> pipeline from the _scriptability_ point of view.
>
> So no.

=46ine, I don't think it should be in core either after this
discussion. So we're in agreement.

The problem I was trying to solve was solved with Jeff's suggestion.
