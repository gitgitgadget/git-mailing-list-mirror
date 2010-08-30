From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH v2] Add global and system-wide gitattributes
Date: Mon, 30 Aug 2010 11:09:23 +0200
Message-ID: <8739twh3gc.fsf@gmail.com>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
	<1281977813-6528-1-git-send-email-gsvick@gmail.com>
	<87d3t7ow39.fsf@gmail.com> <vpqbp8mskv1.fsf@bauges.imag.fr>
	<7vy6bohde7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org,
	Henrik Grubbstrm <grubba@grubba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 11:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq0PH-0004mE-Qf
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 11:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0H3JLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 05:11:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37663 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab0H3JLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 05:11:53 -0400
Received: by pvg2 with SMTP id 2so2022025pvg.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=USGl25pXUMkNtm9ftH6UON1VvHeSER7z1XU8nE0CuUg=;
        b=YynHpBl00b0niyM+zEUxHGucM7J+waXy74yKQujAEdd9TfLpZKiHOX6xeG5Uj0YqHz
         EvQm6EKJAbcFk3KXcse00TGtQ2oPF9D4FSi7kQiQjVAmW/wm6G3ahJ2gOm+cWJ2KgYp2
         SaEHz4D/ZXCajx176fR+8EEp4h/fmO98sCb4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=xzyiYyift1W81FnWL22cRcNCV4bkr4Z3nNRfoyNfREnUFZXnpG7MDg7N+4TS1+LrGP
         QgFIT0NWKYHqq9vq6WchvZ5Y2RsM5e5EL9qcXx3BFKqRSPX4g3PoqJhVZ1GW5heIKMrN
         sXVgcLpCxY69fYTw3A1RWDDxF8pDPwhlL/P18=
Received: by 10.142.246.16 with SMTP id t16mr4390028wfh.110.1283159395826;
        Mon, 30 Aug 2010 02:09:55 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id z1sm9376155wfd.3.2010.08.30.02.09.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 02:09:54 -0700 (PDT)
In-Reply-To: <7vy6bohde7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 29 Aug 2010 22:34:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154778>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>>
>>> Petr Onderka <gsvick@gmail.com> writes:
>>>
>>>> Allow gitattributes to be set globally and system wide. This way, =
settings
>>>> for particular file types can be set in one place and apply for al=
l user's
>>>> repositories.
>>>
>>> [...]
>>>
>>> I really can't wait till this gets into Git and I'm certainly not t=
he
>>> only one (thank you so much for working on it, Petr!).
>>
>> Same here ;-).
>>
>>> Any reason the patch still hasn't been applied?
>>

[...]

>
> Isn't the patch in question on 'pu' to be tried by interested parties
> already?

I see it now, sorry for the confusion. I didn't check when I saw no
response to the mail.

=C5=A0t=C4=9Bp=C3=A1n
