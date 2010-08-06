From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 6 Aug 2010 17:01:19 +0000
Message-ID: <AANLkTimJCgZ8kU0Nrm6Zi-PXSgT96bFfTi0oaaX2t-6v@mail.gmail.com>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
	<7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
	<AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
	<7vmxszamwd.fsf@alter.siamese.dyndns.org>
	<AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
	<7viq3nagje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 19:01:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhQIS-00083Y-Lq
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 19:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336Ab0HFRBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 13:01:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52767 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310Ab0HFRBV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 13:01:21 -0400
Received: by iwn33 with SMTP id 33so1453089iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=su90Do1+7BHsvFXZzgfumSTlz9yZmYLcffdSu7kMs+Q=;
        b=tIqxyCb/qKCLCwH+oQc91IVK39SNjMFW9U6uipT5bT9vdpvG3jB5aECZ/itfi5lqrk
         lAZyluaJWn0L+pxECdGQpBptsDfuRREIuYwnuf147T97QPBz45TE2mpD/dLgRs7e0pja
         gN/dvW0z/lxsXDaMaoaS20KSLQSkozCMBnMY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PP/SkYcgFG98j81gq5zS6JxDOiuNtBsXW5cK/Wi+0XGytAS2XZqJYRT9AT/NjKaOeq
         serGV60nBkZMUoqNVWzreu76fJ47DbgDZMeLsIvi8eLDITVVg3wtJ0YlhKidJj090Wty
         5shP9ZPRHnS3myp+AwoDn1wRqkYjh8DSvzYc4=
Received: by 10.231.59.212 with SMTP id m20mr14271891ibh.130.1281114080350; 
	Fri, 06 Aug 2010 10:01:20 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 10:01:19 -0700 (PDT)
In-Reply-To: <7viq3nagje.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152796>

On Fri, Aug 6, 2010 at 15:48, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Aug 6, 2010 at 13:30, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> That is one good example. =C2=A0Perhaps we can get a list of messag=
es that we
>>> can place in Documentation/ area (e.g. "'Not up-to-date' - this mes=
sage is
>>> given when you have local changes in a file in the working tree; gi=
ven by
>>> command X, Y and Z") out of that effort for free? =C2=A0Perhaps suc=
h a list can
>>> help us verify that i18n does not break plumbing output (because th=
e list
>>> does not contain plumbing messages)?
>>
>> We'd get this sort of list out of "TRANSLATORS:" comments for
>> free. They're automatically extracted and presented to translators a=
nd
>> others with the xgettext program.
>>
>> Maintaining a list of messages in Documentation/ somewhere that's
>> bound to get out of date with the source code doesn't make sense giv=
en
>> the TRANSLATORS support.
>
> Read it again---I didn't say "maintaining" a list at all; we are sayi=
ng
> the same thing more or less ;-) =C2=A0You might need to massage the o=
utput from
> TRANSLATORS: comment to a more readable form suitable for inclusion i=
n the
> documentation (depending on how that thing looks like), though.

Ah yes. I didn't read it carefully enough. Yeah, if we're just talking
about autogeneration it isn't hard to get a list of all translatable
strings into a single ASCIIDOC page.

I plan to write some translator documentation once this gets in and we
start having people submit translations. E.g. a document that lists
some of the core Git concepts that the translator will need to
translate (e.g. "pull", "push", "commit", "tree", "object" etc.).
