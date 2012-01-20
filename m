From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: More support on branch description?
Date: Fri, 20 Jan 2012 15:24:18 +0700
Message-ID: <CACsJy8CULRFOk0-LqL03gHD2jy39rb39MCdMnQ5r2bnTyDjBKw@mail.gmail.com>
References: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
 <7v4nvrib7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 09:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro9mK-0002O9-QY
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 09:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab2ATIYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 03:24:51 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:48562 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2ATIYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 03:24:51 -0500
Received: by werb13 with SMTP id b13so188957wer.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tj9/y7iTqZ88sU1ecpTx/aGfKu5P78fX53sFMkipfWw=;
        b=CuYYGBYskyH+KtOWrBVm1e8OWh1TNuxocBuTd7v0u7CnBWma0uNzHQSsE1ih8ISn0z
         mA4vZRCbsKQ4R1TjN2nSYrb8VunD5s+hSjQfF0xR7hukZLSfbEmIqtkUpJ6nyYR/tO0k
         1kMLzMcA91Dnywv/tX30vwdSaaKjWxW2IjHYg=
Received: by 10.216.131.91 with SMTP id l69mr479905wei.28.1327047889614; Fri,
 20 Jan 2012 00:24:49 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 20 Jan 2012 00:24:18 -0800 (PST)
In-Reply-To: <7v4nvrib7u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188870>

On Fri, Jan 20, 2012 at 5:22 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> You however are misguided to say "Showing a short summary along...".

It should have been "short status".

> The branch description support is to give users a place to record det=
ailed
> explanation about a branch, similar in size to what you would normall=
y
> place in a log message of a commit or a cover letter of a series. =C2=
=A0There
> wasn't any convenient place to do so for a branch that is (1) inheren=
tly a
> moving target while it is being developed and (2) is not a good match=
 for
> tags and notes.

I was thinking about that (and wondering if I abused
branch.*.description), maybe we can have a similar convention for
commit message, one short line, empty line, then more detail
explanation. But branch.*.description is tied to
format-patch/request-pull, maybe another config key.

> There already is a good place for a brief summary and it is called "b=
ranch
> name". Name your branches just like you name your functions.

Yes, but it's not suitable for current status of the branch.
--=20
Duy
