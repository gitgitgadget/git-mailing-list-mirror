From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 15:52:26 +0000
Message-ID: <AANLkTi=4y4_N04atgt1YvE-DuPg6uXt_n2j95+VhN9oV@mail.gmail.com>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com>
	<vpqd3u53sd2.fsf@bauges.imag.fr>
	<4C54410B.704@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 17:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfEMU-0003pS-4X
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 17:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab0GaPw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 11:52:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58565 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab0GaPw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 11:52:26 -0400
Received: by iwn7 with SMTP id 7so2426342iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yIwIznczpgCwxy/X193auHBLPWxfHuSknSQg1Mvs784=;
        b=YeXK3gj0wTDFVP6yLDtpce1VMacQmkbCpLevqx6nv2RCQpqTLbt+6ld5O6fZe8aCIK
         VxlZVxXj6wOLOKm9P17YxBL9ur9YHHzDxOyFJp0GOOeYVEmM7JuINkfwEV+KwJuaqSD/
         UrS9y6YXT9jMNgeUKHfgCXK3GKjTpBhlzf86Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OfIAQqfYnN4XjhGg1jobH6rSNP1n1PJG3Dq16ndm6z0rn9SosxMhUcMU7CMSLmrSPL
         EXUjCVzq7388Dmh5eqcgGk+G9pedwFwhsqoNBz08f13Amp1o9xTAMb0Y4hOZc/mFmIPx
         AEx3we2vnupNsfNi/ZxEcblCfSpFXIoqPc/wA=
Received: by 10.231.119.229 with SMTP id a37mr3623320ibr.169.1280591546072; 
	Sat, 31 Jul 2010 08:52:26 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 31 Jul 2010 08:52:26 -0700 (PDT)
In-Reply-To: <4C54410B.704@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152331>

On Sat, Jul 31, 2010 at 15:28, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 07/30/2010 05:24 PM, Matthieu Moy wrote:
>>
>> Marc Branchaud<marcnarc@xiplink.com> =C2=A0writes:
>>
>>>> The name of the command may be subject to discussions. I've chosen
>>>> "run", but maybe "shell" would be OK too. In both cases, it doesn'=
t
>>>> allow the one-letter version since both "r" and "s" are already us=
ed.
>>>
>>> "exec" with one-letter "x"?
>>
>> Thanks, that sounds good, yes. Any other thought?
>
> I like run, for the short version what about ! (as in vi)? =C2=A0Mayb=
e with an
> optional space.

"run" clashes with the short form of "reword", "exec" also does that,
but the "x" key for that is more obvious. ! is a shift-combo away.

Anyway, </bikeshedding>
