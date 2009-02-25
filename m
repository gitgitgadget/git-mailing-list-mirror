From: John Tapsell <johnflux@gmail.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 07:09:42 +0000
Message-ID: <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
	 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 08:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDvQ-0002E9-QF
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbZBYHJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 02:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZBYHJq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:09:46 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:26113 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZBYHJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 02:09:45 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2499016qwi.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 23:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/GORijWvUzrLjVkM+XAJjqVnORTDkRshE6j/nRn0nZg=;
        b=LNHVF76OfBWMEGiqntjb7LxVe5eBHnEuLPhHS91K9n3/K28gwAdOd/n5n/wUFvSzvw
         7Y+S86SaDIpv2ZzimeVHPAb/bujf3TE8rsyvYADPni+9K8/pGQcD4htatJ0k9wEMc6T3
         wuKZ/ZgMYUQ3BjgFFp0uW1tTJRliO3c5K4Peg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=NbSWoFb+7mOiWF4BOIo1lSlfmr1qkYdC9Tp8IfHLqlrOEOV2DUEIyHTNZGiV0l6fv2
         fxQHvdzMqSQw/mLW4elBOoeHM32KnAnuSLK9UJyekIgvj43tjlTZtgNnRbAAM/ZStlgZ
         rGeEVxRQVROE5qlhqD2wkcFugiZOjOjj7m5YU=
Received: by 10.224.46.8 with SMTP id h8mr30531qaf.181.1235545782798; Tue, 24 
	Feb 2009 23:09:42 -0800 (PST)
In-Reply-To: <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111380>

2009/2/25 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> =C2=A0 Following the idea of 'least damage', what do people think of=
 making
>> "git push" only push the branch you are currently on?
>
> Having an easy way to ask to push only one branch (typically the curr=
ently
> checked-out one) is a good thing. =C2=A0You can obviously say "git pu=
sh origin
> master" (or whatever branch you are on). =C2=A0We also added "git pus=
h origin
> HEAD". =C2=A0I thought we even added "git push HEAD" or "git push --c=
urrent",
> but I may be mistaken.
>
> But if you are talking about changing the default when "git push" is =
run
> without any parameter, I have to say it is a terrible idea, for two
> reasons, and one is too obvious to state so I wouldn't repeat it and =
talk
> only about the other one.

Presumably the obvious is that it might be confusing to existing
users?  Perhaps, but it doesn't cause any damage.  It's moving to a
'safer' default.

> I've noticed that people who ask for such a default tend to push too =
often
> and worse they tend to push before they have their act together. =C2=A0=
Surely
> their other branches may not be ready, but it is likely their current
> branch isn't either ;-)

You're against making push affect only the current branch in order to
punish people who push too often?  Okaaay..

> If you shoot for the least damage for such people, the sanest default=
 for
> "git push" would be to do nothing. =C2=A0You *always* say what to pus=
h where,
> then there is no risk of pushing something you did not intend to. =C2=
=A0Perhaps
> "push.default =3D never" configuration may not be such a bad idea?

That wouldn't be a terrible idea, although perhaps a bit strange.

John
