From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Thu, 18 Jun 2015 07:37:45 +0700
Message-ID: <CACsJy8COWS+LoVOxKmAdMhk8FPEnOZpJ1mesJr0orOD7wN2Qsg@mail.gmail.com>
References: <558127CB.70603@web.de> <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
 <vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
 <vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
 <vpqtwu6sf4r.fsf@anie.imag.fr> <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
 <xmqqd20u48at.fsf@gitster.dls.corp.google.com> <5581A3A3.1070908@web.de>
 <vpqh9q6gsdt.fsf@anie.imag.fr> <xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
 <5581CAA6.5080306@web.de> <xmqq8ubi6rap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Andres G. Aragoneses" <knocte@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 02:38:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5NqX-0002Nd-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 02:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbFRAiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 20:38:17 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33325 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbFRAiQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 20:38:16 -0400
Received: by igbqq3 with SMTP id qq3so3268620igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 17:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6hJvnE3g+b+xfhGehtoAhT+nQ3jrazJ3AN7Nc3sNyPM=;
        b=vQeGxtx23C6RVor7MrqW7a0USVe95WaIoNbJKT/UvtTlWCnClaag2lWvA31VWiQY75
         Em8dmORayVNRHeNpvh1Pm7fR5ZSNSRFAZo8fbi9EpvixK9lZBi0jvdv3+T/bSp7qp2oX
         zF4C5qmF/tmjTFeILIqolFYyD42MFw3UT62sEJsNrHi3TunXmNfjSPk0ASeTVV//6Re+
         lUFRlIMbBWO5PNAPPQn5W56lW69Lj9m0u400POamnaWfaE0B4seUqm34zDuM8Ah45Uod
         cQiXnM8Sh3rstzfAhsgixlsBO93U81KKiQi1W0Yx8csCj3ve+gGW+iGbPx23Y0tY/Brl
         nQ6g==
X-Received: by 10.107.47.224 with SMTP id v93mr11688727iov.86.1434587895772;
 Wed, 17 Jun 2015 17:38:15 -0700 (PDT)
Received: by 10.107.6.226 with HTTP; Wed, 17 Jun 2015 17:37:45 -0700 (PDT)
In-Reply-To: <xmqq8ubi6rap.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271932>

On Thu, Jun 18, 2015 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 2015-06-17 21.23, Junio C Hamano wrote:
>> []
>>>> Basically, I'm fine with anything starting with "Switch branches o=
r",
>>>> but please do change the headline ;-).
>>>
>>> Likewise; I agree "switch branches or" part is good.
>>
>> How about this:
>>
>> git-checkout - Switch branches or restore changes to the working tre=
e
>
> Gahh.  We are NOT restoring CHANGES.  We are restoring the whole
> contents to a path.

"the whole contents" is only true when --patch is not used, I think.
--=20
Duy
