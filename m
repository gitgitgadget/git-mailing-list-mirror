From: John Tapsell <johnflux@gmail.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 10:06:03 +0000
Message-ID: <43d8ce650902250206j7f8411a4p5d256e0a4da7fe49@mail.gmail.com>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
	 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
	 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902250108q48837d85mfcee33b990c5bf00@mail.gmail.com>
	 <7v4oyi7sn4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGfr-0006QT-4X
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbZBYKGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 05:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbZBYKGG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:06:06 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:14754 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZBYKGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 05:06:05 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2594528qwi.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7V+V+dYeKXfYZJ3aWB9ZmLzY0JflbiwAjTtFgRwS4+4=;
        b=ObZsO22ZlBnwHP7tDtDhvlfcvNOgGqg0POHsHpJARd6bLdJwLTMGVpDRsYBBvjE/wJ
         pLGxVxfmhV3eJNwMHUQ9B+ddOHjqvjQJz87m16CiDDkkYRnf7d8UZSFN2xTc4nv8FVDV
         QFvf5a6n4FNpcpEwIq/DCpdsJq75GIOd7UFeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m3gRf3J+My9nFpNx22Hr2Um1/bmqjI/IAfgAjHxGKksMznbNFno5zGd6h3CCv4iNsW
         mROKg/m6VAJ9S4nmTWvD8aJaxytVjDTR69AfWXT5oiusv6xnf8uQulbqyhIqu9yzllKa
         AY43RjRrYAOW9BjKLbt5jEWWAYtooGLj1h7oE=
Received: by 10.224.60.139 with SMTP id p11mr282615qah.116.1235556363368; Wed, 
	25 Feb 2009 02:06:03 -0800 (PST)
In-Reply-To: <7v4oyi7sn4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111435>

2009/2/25 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/2/25 Junio C Hamano <gitster@pobox.com>:
>>
>>> Please don't talk about changing the default without thinking the
>>> ramifications through.
>>
>> Talking about doesn't harm anything. =C2=A0I don't really get why yo=
u're a
>> bit hostile.
>
> I am not saying any discussion about the defaults is bad.
>
> But these topics add flames from uninformed people we have to douse e=
arly
> to the list traffic, and make it harder to find useful topics by degr=
ading
> S/N ratio.

You know, there might be a reason why you get lots of "uninformed
people" complaining about the defaults.  Distinguishing the flames
shouldn't be your first instinct :)

> In other words, it certainly harms a lot.
>
> I just want people to think twice (or more) if the change you are goi=
ng to
> propose is worthwhile before imposing that cost to everybody. =C2=A0A=
 couple of
> changes around "git push" scheduled for 1.7.0 are default changes, an=
d it
> was worthwhile to discuss about them, but I do not think this one des=
erves
> the human bandwidth, especially we already had discussion on it recen=
tly
> and we have a reasonable configuration mechanism for doing what you w=
ant
> already.
