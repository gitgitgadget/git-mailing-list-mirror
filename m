From: Eugene Sajine <euguess@gmail.com>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 14:10:33 -0400
Message-ID: <CAPZPVFZKNdDcnaVn237gArqdBuc4ek77vxsp8BMaicARBTKqBg@mail.gmail.com>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
	<7vipnd3trk.fsf@alter.siamese.dyndns.org>
	<CAPZPVFanWTpCDO+A0dV4TWUVx-22VjFOdk6f7cmgfU59GqG3sQ@mail.gmail.com>
	<vpqr521j98h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:10:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIlSR-0000dT-M2
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 20:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab1JYSKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 14:10:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45858 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab1JYSKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 14:10:34 -0400
Received: by iaby12 with SMTP id y12so826715iab.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oxzTpxOqGULr1WNvMcJEdAVJLPtlbvS/6Rz2AysHNDg=;
        b=XRe/RemlICaenC8b6uJef2fyARNCMQIEW2mlxrr8VZXvVOsgYlJGXb9zgzdMN2iSBu
         FDWV3NnxXmQWL7VF+dXEzH9/gNcQCjv2uaXVtU+/83AAriGb/HyQZipvHoazILGB+TtK
         tETta/5nA9APjYUM1O342ooql3qE0ZW83XjuA=
Received: by 10.231.5.225 with SMTP id 33mr688487ibw.3.1319566233792; Tue, 25
 Oct 2011 11:10:33 -0700 (PDT)
Received: by 10.231.199.17 with HTTP; Tue, 25 Oct 2011 11:10:33 -0700 (PDT)
In-Reply-To: <vpqr521j98h.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184230>

On Tue, Oct 25, 2011 at 1:01 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> On Tue, Oct 25, 2011 at 12:45 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>
>>> Just a wild guess. perhaps you specified prefix=3D/usr/local/git-1.=
7.4.1/
>>> eons ago when you built and installed 1.7.4.1 like this:
>>>
>>> =C2=A0 =C2=A0make prefix=3D/usr/local/git-1.7.4.1 all install
>>>
>>> and then you did it differently when you installed 1.7.6.4, e.g.
>>>
>>> =C2=A0 =C2=A0make all
>>> =C2=A0 =C2=A0make prefix=3D/usr/local/git-1.7.6.4 install
>>>
>>>
>>
>>
>> Are you saying that the first command is more correct?
>> I will check it.
>
> At build time, Git registers the "exec path" (i.e. where to find
> git-<command> executables). So, if you run "make all" without specify=
ing
> the install path, Git will set an arbitrary exec-path, and the
> installation won't work.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

Matthieu/Junio,

Thank you very much for your help - there was a mistake made during
the build where the exec path folder was incorrect and unreachable.

Thanks!
