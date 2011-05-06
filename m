From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: move private shopt shim for zsh to __git_ namespace
Date: Fri, 6 May 2011 11:35:50 +0300
Message-ID: <BANLkTimrjra=vz7MHTDWMq8Bk_2jv-D-Ng@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
	<BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
	<BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
	<20110427212704.GB18596@elie>
	<20110506054604.GA13351@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 10:36:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIGW1-0001jr-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1EFIfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 04:35:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51637 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1EFIfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 04:35:51 -0400
Received: by fxm17 with SMTP id 17so2069848fxm.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AeXhRPC1l3+696maAiEiCp5VEjlPqM1SV5tP8dE+wJU=;
        b=V0+IQSEjh8B93FFqUneriuCW4Rhf/SSNIV+OC6Iztlp+mUpf+I9RUQOPJ1J0yeB18b
         g/mJ9fWegeap4gIhOSWkA3WRBtgx5ST++OmszqeVsWz7Z4b9y+6ZRL4WIs2TTUSFBqef
         X3Xy6KZTnuqzVCWc1gFhL4CrhZRHxJZmE3B1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I6g6ER12u0qW7OHEqNbmPfFeKTpf23qF9gRw1tZ9sZzqMhWnfcDYgo2/tCqfTmyu1E
         bPGEeOSNxvY9OGLOpjNV+YdutycjJ9BxGKdlLk4+K9/T3dIormntKyBDpwtWdvPsJRkI
         Nab2pqoBw7eODGS75AQUzY/ZYjNtmkgPxguUY=
Received: by 10.223.24.134 with SMTP id v6mr717306fab.146.1304670950221; Fri,
 06 May 2011 01:35:50 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Fri, 6 May 2011 01:35:50 -0700 (PDT)
In-Reply-To: <20110506054604.GA13351@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172958>

On Fri, May 6, 2011 at 8:46 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> (culling cc list of quiet people :))
> Jonathan Nieder wrote:
>
>> Most zsh users probably probably do not expect a custom shopt functi=
on
>> to enter their environment just because they ran "source
>> ~/.git-completion.sh".
>>
>> Such namespace pollution makes development of other scripts confusin=
g
>> (because it makes the bash-specific shopt utility seem to be availab=
le
>> in zsh) and makes git's tab completion script brittle (since any oth=
er
>> shell snippet implementing some other subset of shopt will break it)=
=2E
>> Rename the shopt shim to the more innocuous __git_shopt to be a good
>> citizen (with two underscores to avoid confusion with completion rul=
es
>> for a hypothetical "git shopt" command).
>
> By the way, I meant the above[1] as a genuine patch submission.
> Thoughts? =C2=A0Bugs? =C2=A0Improvements?

Looks fine to me.

--=20
=46elipe Contreras
