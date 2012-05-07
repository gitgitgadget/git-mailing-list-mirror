From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v4 5/6] completion: calculate argument position properly
Date: Mon, 7 May 2012 23:01:12 +0200
Message-ID: <CAMP44s3rC6bT3rjrBFdnywwsp5NrXt54L5L-7oKZ=bNFKccq+w@mail.gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com>
	<7v7gwn6cmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:01:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRV3W-0000i2-V5
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab2EGVBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 17:01:14 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58593 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab2EGVBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 17:01:13 -0400
Received: by eeit10 with SMTP id t10so111392eei.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AshLKAivAgctmorGniIPhOALeFSaMsCyFnoGPzf3uT8=;
        b=uAFeJGivhfZ4qA8k5WdD/jrmqqs8wSWOTU+/x3qAv79s0JQvKeAC9sKCB77P/8X8W7
         1KVkpA4tfAsFlW+Swsr7FE2BWErTyXYR73wgJf8ZEhWW5GejPaRiAJXdZb73cCeBXJFO
         PEZDD9mrwIzDxX1GysKGmLCfjiQlt6mMxAmn75ttP0ii/CiUjo8DSc9Z71rriCDUaIEi
         pLYAeLm9y9kuC3E5bZZAdY8OfAE5N5Yxwa/QtvUM8XxQaAZ/bI+chALpQ+361cU9/4yi
         RZ6iZxSF2KJfNFFOrk7Gr4qsubUH9d1Hm5b0J8K/n6lsXjZyV2ty3fiFMt18wxoonGMS
         Nk+w==
Received: by 10.14.47.9 with SMTP id s9mr414486eeb.50.1336424472557; Mon, 07
 May 2012 14:01:12 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Mon, 7 May 2012 14:01:12 -0700 (PDT)
In-Reply-To: <7v7gwn6cmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197306>

On Mon, May 7, 2012 at 8:59 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, May 7, 2012 at 3:23 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>
>>> @@ -2642,6 +2642,8 @@ _git ()
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 (( cmd_pos =3D c + 1 ))
>>
>> Actually, I would prefer cmd_pos=3D$((c + 1)).
>
> Yeah, that would feel more natural.
>
> Together with 4/6, I am guessing that you are using $cmd and $cmd_pos=
 as a
> global variable to pass state to/from helper functions. =C2=A0Are the=
y properly
> documented in code (if not, please do so)?

Like cur, prev, words, and cwords? Wait a second... they are not
documented anywhere. I'm also not going to work on this... not my
itch.

--=20
=46elipe Contreras
