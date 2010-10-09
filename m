From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 00/21] git notes merge
Date: Sat, 9 Oct 2010 13:28:50 +0200
Message-ID: <AANLkTimzyeLd5BNowAC+XzTYHXNUxkXhxhq9YRasO-3A@mail.gmail.com>
References: <1286586528-3473-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 13:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Xc4-0001tl-Vf
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 13:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760268Ab0JIL3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 07:29:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53643 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab0JIL3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 07:29:11 -0400
Received: by yxd39 with SMTP id 39so353805yxd.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2Otr3qQKJ5LCuUWLL2qjcplL+tFj6Riz3VJCDpz2kiA=;
        b=Z1j05qbnHDezDYCMqS5WC0jjQjRgA0j80Kyic0e6ZGEgjMbYwqsDZ6mx3vODW112G9
         8hRRdJ+Fqi0RuKKb1/PZU8MCeyEaSu0tLzcT8NaczY7d4kY/wNIE0/t/P08qQ5+I2epa
         UVyXmojhSW4CfmpMn4rG8ucZaJR73aAjlTE3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RiXDUaTLF03ovHo17EToKUThNaTrsbTiUjQnLD0zQOoEKP3JEc1k9ttM7Pw6AJz6/X
         m77XsI/q7Yg1t2g50Ff5j0Bq88tFogFsIENbRUC1am6ehBepK28MTm8u3S3HzHo6l5Km
         DeL41SDsP6Qt7avY7yj9WzUkCymBA9V10BpJk=
Received: by 10.151.1.41 with SMTP id d41mr4253473ybi.215.1286623750289; Sat,
 09 Oct 2010 04:29:10 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Sat, 9 Oct 2010 04:28:50 -0700 (PDT)
In-Reply-To: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158583>

Heya,

On Sat, Oct 9, 2010 at 03:08, Johan Herland <johan@herland.net> wrote:
> - Fetching and pushing note refs:
> =C2=A0- Add refs/notes/* to default fetch refspec?

Or at least add a '--notes[=3D<notes namespace>]' to fetch, pull, and p=
ush.

> =C2=A0- A way to specify (at clone time) which refspec(s) to set up?

How would that look like?

> =C2=A0- A way for the remote repo to hint at which refspecs you might=
 want
> =C2=A0 =C2=A0to set up (by default?)

I assume this would be a generic mechanism of sorts? Are there any
other use cases for this other than notes?

--=20
Cheers,

Sverre Rabbelier
