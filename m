From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 21:02:10 +0100
Message-ID: <AANLkTi=G0m_AY3PMVs93=u=cKtVrAjFD56KPURYAyhyh@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
 <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
 <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
 <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
 <AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
 <AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
 <AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
 <AANLkTin-kF_+DKDAu=gt12WfOcEVJaED-Qny8sFQ=oKP@mail.gmail.com> <AANLkTi=hRk-bqNvvMRCmbSu8Mc4uux5aowgLGnPLnD4A@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 21:02:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLi1e-0006EK-3v
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 21:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0KYUCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 15:02:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47779 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0KYUCc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 15:02:32 -0500
Received: by fxm15 with SMTP id 15so173169fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=CsPWZimMXmNsWNoYc4I9m9gvCFa1yI3aqy+oKDAaXaI=;
        b=CXYLcEOS1NtZy9VjJnbAb95adgyown8BBV2sGvyigTIJr1gXQ/WeLRK5K8gpXPk5TF
         wmHi7pMwy4fqQ3Ycy+nBZuWUc+6lmWq5gRYV83Gdp2KofFXCCM7+DM+IDwQhIJH3vrrV
         X4DmQzaR4r7GsQIulwCTi3pzCEkLSxuUxu+ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=XzloQYSOajUhJWK+eNc5ft8HFS5DszIGMZl0YJXNBrhCoJYmgfv+NfXU+oVdI4F3ky
         XuVOw8O+HnnlfHttYETX71niXrDYUuWXwe4HdASAmUbvKW0Cb7A3L/+sKSXb1480U1k/
         z6o0zBpc8vWCcymCfS/BywIidy8S+vOQ0GaLs=
Received: by 10.223.79.72 with SMTP id o8mr1205512fak.83.1290715350859; Thu,
 25 Nov 2010 12:02:30 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 12:02:10 -0800 (PST)
In-Reply-To: <AANLkTi=hRk-bqNvvMRCmbSu8Mc4uux5aowgLGnPLnD4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162154>

On Thu, Nov 25, 2010 at 7:06 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 18:55, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Thu, Nov 25, 2010 at 5:33 PM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> Anyway, if that works it's a cleaner way to disable it.
>>>
>>
>> Yes, that works. But that is a work-around, not a solution. I alread=
y
>> told the make system not to translate git, why should I have to
>> anything else? In fact, I did exactly what the documentation at the
>> top of the makefile told me to do. It says to set NO_GETTEXT, nothin=
g
>> about clearing NEEDS_LIBINTL.
>
> Oh yeah that's definitely a bug that I need to solve. But that should
> just be something like:
>
> ifdef NO_GETTEXT
> =A0 =A0NEEDS_LIBINTL =3D
> endif
>
> Stuck in some strategic location. Then it all should just work.
>

Well, there you go. That's one of the things that needs to get fixed ;)

I don't quite understand why you won't do it the way I just proposed
(and IIRC a while ago by Hannes), though.
