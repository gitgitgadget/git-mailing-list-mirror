From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sat, 19 May 2012 09:54:28 +0200
Message-ID: <CACY+Hvp-G4odbftiFeu1u+1icROD36M=CzSn3DKu_TEaqNB3OQ@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<20120519024503.GA2801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 09:54:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVeUk-0004xP-Fb
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648Ab2ESHya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 03:54:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50427 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550Ab2ESHy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 03:54:29 -0400
Received: by obbtb18 with SMTP id tb18so5052781obb.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mSeTDVwE94Ggjg3tHuvqZRF3c9ag1bkc3n5JRhvqhpI=;
        b=raV7ElS+iOADSiodjVXcavIDYmTktAISv2/5PjXlgwrVNHZTsEQ7C30ESUvofbG/bQ
         mfj+14rXPyK/8z0JYfKFdaY7/JOmi92gRnz4oBKWh7iUj2q7x6vQjc2IRYIWK45UcNjy
         P86ufZIc+93eF+G09D+rO2NPjP40vbLVjhep5Cs8p9MsnWdrRIqJMJGf5/sdtuwZEVVg
         lEGQYAcCMPJVZQCp/yJnQZ0N5RoLnkNM+uMOwFigL0HsUDWpLCVeZUd2OR38PtSLtoao
         w94ALkg4Iv5Lfu3MGmq8gk0qmKZD3wyVzizdQceR9EqTFJzwns94eDgJzLTQl3vYKIIu
         qxgQ==
Received: by 10.50.88.200 with SMTP id bi8mr2673455igb.12.1337414068230; Sat,
 19 May 2012 00:54:28 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sat, 19 May 2012 00:54:28 -0700 (PDT)
In-Reply-To: <20120519024503.GA2801@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198025>

On Sat, May 19, 2012 at 4:45 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 19, 2012 at 04:41:33AM +0200, Felipe Contreras wrote:
>
>> These two patches are meant to fix the backwards compatibility of _g=
it, and
>> _gitk. This also helps my zsh's wrapper.
>>
>> Felipe Contreras (2):
>> =A0 completion: rename _git and _gitk
>> =A0 completion: add support for backwards compatibilit
>
> Thanks. This looks like the obviously correct solution. Even if we en=
d
> up with a public _GIT_complete or whatever, the backwards-compatibili=
ty
> is worth it.

Cool. Just though the patches now. Felipe, which variant should I use
to define _main_git completion for the alias g with the 2 patches
applied to git_completion.bash? Using bash-4.2.28.
