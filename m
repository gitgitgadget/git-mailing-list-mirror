From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Sat, 22 May 2010 12:01:29 +0000
Message-ID: <AANLkTimQzAM7qA32FRFvQC1cx7UEEKtBxjU89whrSqF5@mail.gmail.com>
References: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com>
	 <AANLkTil-PDpdkcJaJn2FUrJrSIJ6lP0OcvY5l7HRorsa@mail.gmail.com>
	 <201005221244.32213.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 22 14:06:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFnSt-00020f-Go
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 14:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0EVMBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 08:01:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55755 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab0EVMBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 08:01:31 -0400
Received: by iwn6 with SMTP id 6so2204148iwn.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dr1ZuxW9KunqMxO1nbHf9Ddx7G/TM/jMtcDEUKbO0a4=;
        b=NxBV3C0ISQiSk4x+Wtoo1x/BIUJy/k9ICarqXtwnVYnDDDaITtoSbGaJypaOXLR7M/
         N8QVH9DGj3maZpV4y1ye1Cquv30VXFkas8Tz/lmlGe9BIv7dgZLDiF3mZpAqsOxNrwfC
         Gz+D/AZUnxkNis5/vvO7hbRR2eKnQo/V06lnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DSPHgk7hPA1aCUc57eOsNLiOhpvLBjvbR0Rz+brue3bTNnf84TlsE2uag3sLPZc2Pn
         /dnbdsWt3YxfrWekQXZfw/NR1Whza7bRFxAFOLzuRxuqzkk9u88XfYUIugeeYOW8V3sh
         uoXARcsi5GMH5NjewqSNzl9D+2sZ975tuiaTE=
Received: by 10.231.185.86 with SMTP id cn22mr1943689ibb.69.1274529689913; 
	Sat, 22 May 2010 05:01:29 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 22 May 2010 05:01:29 -0700 (PDT)
In-Reply-To: <201005221244.32213.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147518>

On Sat, May 22, 2010 at 10:44, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> That would completely ruin the scriptability of almost all commands.
> Imagine the user added the following options as default:
>
> =C2=A0add --edit
> =C2=A0checkout --patch
> =C2=A0cherry-pick --no-commit
> =C2=A0commit --amend
> =C2=A0pull --rebase
>
> I'm sure you can find one option that changes the command in somethin=
g
> completely different *for every command*.

Sure. But so would adding this as git-add to your $PATH:

    #!/bin/sh
    /usr/lib/git-core/git-add --edit $@

Git already has plenty of ways to shoot yourself in the foot. I don't
see how it's worse if that's done through some generalized facility
which results in less special-case code in individual tools.
