From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 20:55:46 +0200
Message-ID: <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJVs-0002Vb-Hu
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZBVSzv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZBVSzu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:55:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:52491 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZBVSzt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:55:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2560996fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5tGMQmP/XpdNCjEbWFHzeWkqknX9VHOq5XLwh1/iVEc=;
        b=KDW7OPmZF19UKkUq7UrTDfO3Qmo6b/uSIqQ4I32mq2ccC6ME1xl8YLkXOQZjVKTBG6
         Ol2ihv/+GP4GQDn+PhR9vaZPCmcZCIrtvabTR+d2+F+aJ2qqieHSTZ/VMPr6x1Bd3Bce
         q19jHhUQU71W15VEYuHMUzRl8lhz7MegYKsig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HmMFNiYHKHFmtBpg+o4dhoprlRUHZD3ZJ+4Mt8R7L81mDnInTWhyJDdrOJ3eOiDaMK
         V6ulqVDjt5L/D0qpjGn1U14zKRHy06xP1aewAM4+YBEDjfVl/2fxB9/ZK0SAgYWXrLbl
         EfB0/emHGmRy8AEDcMbosm6vRZi9TiyTc2Uj0=
Received: by 10.86.28.2 with SMTP id b2mr204897fgb.75.1235328946712; Sun, 22 
	Feb 2009 10:55:46 -0800 (PST)
In-Reply-To: <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111049>

On Sun, Feb 22, 2009 at 8:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I understand the option should be kept for people that are used to i=
t,
>
> It is not just that. =C2=A0New people should learn existing lingo, as=
 that is
> the word used in the existing documentation and various random web pa=
ges,
> so that they can use the same language when they teach people who are
> newer than themselves.

Yes, but the existing lingo is not perfect... I'm proposing this
particular lingo to be changed.

> If the existing word was not pretty (that came from "pretty-formattin=
g")
> but something unpronouncible like '--gzxfw=3Dshort", then your argume=
nt
> might make some sense, but there is no such "breakage we need to fix"
> here.

It's not breakage that needs to be fixed, it's UI improvement, and one
guideline is that the interface needs to be intuitive and natural
(when possible). IMO pretty > gzxfw, but format > pretty. Don't you
think that --format=3Demail is more natural than --pretty=3Demail? I th=
ink
you are holding a bit too tight on the code reason why it's called
--pretty, but users shouldn't need to see the code in order to
understand why the naming of the options in git commands make sense.

--=20
=46elipe Contreras
