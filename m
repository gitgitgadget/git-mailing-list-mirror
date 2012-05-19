From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sat, 19 May 2012 19:45:47 +0200
Message-ID: <CACY+HvpUXiK3_bmBZV7i_bgKOP7vSuYb2k4ARtqPGXzdpJfbPg@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<20120519024503.GA2801@sigill.intra.peff.net>
	<CACY+Hvp-G4odbftiFeu1u+1icROD36M=CzSn3DKu_TEaqNB3OQ@mail.gmail.com>
	<20120519153134.GB6979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 19:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVnj1-0003UR-DE
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 19:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab2ESRpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 13:45:50 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48772 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab2ESRps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 13:45:48 -0400
Received: by yhmm54 with SMTP id m54so3679732yhm.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=c4JSPI12SoHh2WjDUFUM8mthNJSI49xos3jczR9PyIc=;
        b=GQAqR+OOTxp+NdL9lyEPrIbFI2m7e76XXYFnDzmtN+6joJmu8mrCdgB++mzryI3mmn
         0Nd10PnglmVkArEQEfAd/+DLP6zFUAxuJRC/aImk0LGxKY+GaTf/RhZIbX2i56D5XTx7
         Je030X6svfkdQ6c5hHvDe+VVclhcCUG0tAlOTBlikfiyrGRSd/QF02qhGiiWGRYRK5Ei
         6hIJ/83T1olSlemz3BPI3Om1QhKlIuT5gHpbC4zEyv2zjZwP7H6jpdFCeO0DDQCCm81w
         ma1bPV2rzs9K4BmCg1VrdA+FIUkivbiYgy7DvtxUx4AwxOSTvo30paeojX8gvzrdpuoB
         dssA==
Received: by 10.50.51.136 with SMTP id k8mr3393893igo.74.1337449547853; Sat,
 19 May 2012 10:45:47 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sat, 19 May 2012 10:45:47 -0700 (PDT)
In-Reply-To: <20120519153134.GB6979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198036>

On Sat, May 19, 2012 at 5:31 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 19, 2012 at 09:54:28AM +0200, Carsten Mattner wrote:
>
>> >> Felipe Contreras (2):
>> >> =A0 completion: rename _git and _gitk
>> >> =A0 completion: add support for backwards compatibilit
>> >
>> > Thanks. This looks like the obviously correct solution. Even if we=
 end
>> > up with a public _GIT_complete or whatever, the backwards-compatib=
ility
>> > is worth it.
>>
>> Cool. Just though the patches now. Felipe, which variant should I us=
e
>> to define _main_git completion for the alias g with the 2 patches
>> applied to git_completion.bash? Using bash-4.2.28.
>
> I think the point of the patches is that you can continue to use your
> same "complete ... -F _git g" line as always (with these patches you
> could also say "__git_complete g _main_git", but that is not backward=
s
> compatible to older versions, if you use the same bashrc on multiple
> machines).

Great, is that short form always enough with the patches applied
and the non-internal function to use for future compatibility?
